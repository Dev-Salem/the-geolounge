import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:the_geolounge/core/core.dart';
import 'package:the_geolounge/features/chat/data/supabase_chat_repository.dart';
part 'chat_controller.g.dart';

@riverpod
class ChatController extends _$ChatController {
  @override
  FutureOr<void> build() {}

  Future<void> updateRequestStatus(
    String requestId,
    RequestStatus requestStatus,
  ) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref
          .watch(chatRepositoryProvider)
          .updateRequestStatus(requestId, requestStatus),
    );
  }

  Future<void> sendChatRequest({
    required String receiverId,
    required String postId,
    required String openingMessage,
  }) async {
    state = await AsyncValue.guard(
      () => ref.watch(chatRepositoryProvider).sendRequest(
            receiverId: receiverId,
            postId: postId,
            openingMessage: openingMessage,
          ),
    );
    ref.read(goRouterProvider)
      ..pop()
      ..pop();
  }

  Future<void> sendMessage({
    required String receiverId,
    required String requestId,
    required String content,
  }) async {
    state = await AsyncValue.guard(
      () => ref.watch(chatRepositoryProvider).sendMessage(
            receiverId: receiverId,
            requestId: requestId,
            content: content,
          ),
    );
  }

  Future<void> deleteChat(String requestId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.watch(chatRepositoryProvider).deleteChat(requestId),
    );
    ref.watch(goRouterProvider)
      ..pop()
      ..pop();
  }
}
