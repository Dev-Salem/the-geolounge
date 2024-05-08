import 'dart:async';
import 'package:animated_tree_view/helpers/collection_utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:the_geolounge/core/core.dart';
import 'package:the_geolounge/features/auth/auth.dart';
import 'package:the_geolounge/features/chat/domain/chat_request.dart';
import 'package:the_geolounge/features/chat/domain/message.dart';
part 'supabase_chat_repository.g.dart';

class ChatRepository {
  ChatRepository({
    required this.supabase,
  });
  final SupabaseClient supabase;
  Future<void> sendRequest({
    required String receiverId,
    required String postId,
    required String openingMessage,
  }) async {
    final chatRequest = ChatRequest.toMap(
      receiverId: receiverId,
      postId: postId,
      openingMessage: openingMessage,
    );
    final existingRequest = await supabase
        .from(SupabaseConstants.chatRequest)
        .select()
        .match({'receiver_id': receiverId, 'post_id': postId});
    if (existingRequest.isNotEmpty) {
      throw const PostgrestException(
        message: 'Already Sent A Request To The User',
      );
    }
    await supabase.from(SupabaseConstants.chatRequest).insert(chatRequest);
  }

  Stream<List<ChatRequest>> getChatRequests({
    required RequestStatus requestStatus,
  }) {
    final currentUserId = supabase.auth.currentUser!.id;
    final requests = supabase
        .from(SupabaseConstants.chatRequest)
        .stream(primaryKey: ['id'])
        .eq('receiver_id', currentUserId)
        .map(
          (list) => list
              .map(
                (request) => request['status'] == requestStatus.name
                    ? ChatRequest.fromMap(request)
                    : null,
              )
              .filterNotNull(),
        );
    return requests;
  }

  Future<void> updateRequestStatus(
    String requestId,
    RequestStatus requestStatus,
  ) async {
    await supabase
        .from(SupabaseConstants.chatRequest)
        .update({'status': requestStatus.name}).eq('id', requestId);
  }

  Stream<List<ChatRequest>> getAcceptedChatRequests() {
    final currentUserId = supabase.auth.currentUser!.id;
    final receivedChatRequests = supabase
        .from(SupabaseConstants.chatRequest)
        .stream(primaryKey: ['id'])
        .eq('receiver_id', currentUserId)
        .map(
          (list) => list
              .map(
                (request) => request['status'] == RequestStatus.accepted.name
                    ? ChatRequest.fromMap(request)
                    : null,
              )
              .filterNotNull(),
        );

    final sentChatRequests = supabase
        .from(SupabaseConstants.chatRequest)
        .stream(primaryKey: ['id'])
        .eq('sender_id', currentUserId)
        .map(
          (list) => list
              .map(
                (request) => request['status'] == RequestStatus.accepted.name
                    ? ChatRequest.fromMap(request)
                    : null,
              )
              .filterNotNull(),
        );
    final combinedRequests = Rx.combineLatest2(
      receivedChatRequests,
      sentChatRequests,
      (receivedRequest, sentRequest) => receivedRequest + sentRequest,
    );
    return combinedRequests;
  }

  Stream<List<Message>> getMessages(String requestId) {
    final messages = supabase
        .from(SupabaseConstants.messages)
        .stream(primaryKey: ['id'])
        .eq('chat_request_id', requestId)
        .order('sent_at');
    return messages
        .map((messagesList) => messagesList.map(Message.fromMap).toList());
  }

  Future<void> sendMessage({
    required String receiverId,
    required String requestId,
    required String content,
  }) async {
    final message = Message.toMap(receiverId, requestId, content);
    await supabase.from(SupabaseConstants.messages).insert(message);
  }

  Future<void> deleteChat(String requestId) async {
    await supabase
        .from(SupabaseConstants.chatRequest)
        .delete()
        .eq('id', requestId);
  }

  Stream<Message> getLastMessage(String chatId) {
    final message = supabase
        .from(SupabaseConstants.messages)
        .stream(primaryKey: ['id'])
        .eq('chat_request_id', chatId)
        .order('sent_at')
        .limit(1)
        .map((message) => Message.fromMap(message.first));
    return message;
  }
}

@Riverpod(keepAlive: true)
ChatRepository chatRepository(ChatRepositoryRef ref) {
  return ChatRepository(supabase: ref.watch(supabaseClientProvider));
}

@riverpod
Stream<List<Message>> getMessages(GetMessagesRef ref, String requestId) {
  return ref.watch(chatRepositoryProvider).getMessages(requestId);
}

@riverpod
Stream<List<ChatRequest>> getChatRequests(
  GetChatRequestsRef ref,
  RequestStatus requestStatus,
) {
  return ref
      .watch(chatRepositoryProvider)
      .getChatRequests(requestStatus: requestStatus);
}

@riverpod
Stream<List<ChatRequest>> getAcceptedChatRequests(
  GetAcceptedChatRequestsRef ref,
) {
  return ref.watch(chatRepositoryProvider).getAcceptedChatRequests();
}

@riverpod
Stream<List<Message>> getChatMessages(
  GetChatMessagesRef ref,
  String chatRequestId,
) {
  return ref.watch(chatRepositoryProvider).getMessages(chatRequestId);
}

@riverpod
Stream<Message> getLastMessage(GetLastMessageRef ref, String chatId) {
  return ref.watch(chatRepositoryProvider).getLastMessage(chatId);
}
