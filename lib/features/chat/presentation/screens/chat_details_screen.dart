import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_geolounge/core/core.dart';
import 'package:the_geolounge/features/auth/auth.dart';
import 'package:the_geolounge/features/chat/data/supabase_chat_repository.dart';
import 'package:the_geolounge/features/chat/domain/message.dart';
import 'package:the_geolounge/features/chat/presentation/controller/chat_controller.dart';
import 'package:the_geolounge/features/chat/presentation/widgets/chat_bubble_widget.dart';
import 'package:the_geolounge/gen/strings.g.dart';

class ChatDetailsScreen extends ConsumerWidget {
  const ChatDetailsScreen({
    required this.requestId,
    required this.senderId,
    required this.receiverId,
    super.key,
  });
  final String requestId;
  final String senderId;
  final String receiverId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messagesProvider = ref.watch(getChatMessagesProvider.call(requestId));
    final currentUserId =
        ref.watch(supabaseClientProvider).auth.currentUser!.id;
    final otherUserId = currentUserId == senderId ? receiverId : senderId;
    return Scaffold(
      appBar: AppBar(
        title: Text(context.t.chat.chat_details),
      ),
      body: messagesProvider.when(
        data: (messages) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  reverse: true,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: ChatBubbleWidget(
                        message: messages[index],
                        currentUserId: currentUserId,
                      ),
                    );
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: PostTextField(
                  onSend: (text) {
                    ref.read(chatControllerProvider.notifier).sendMessage(
                          receiverId: otherUserId,
                          requestId: requestId,
                          content: text!,
                        );
                  },
                  validator: (p0) {
                    if (p0 == null) {
                      return null;
                    }
                    if (p0.isEmpty) {
                      return t.chat.too_short;
                    }
                    if (p0.length > 255) {
                      return t.chat.too_long;
                    }
                    return null;
                  },
                ),
              ),
            ],
          );
        },
        error: (e, s) => ErrorResultWidget(
          onRefresh: () =>
              ref.refresh(getChatMessagesProvider.call(requestId).future),
        ),
        loading: () {
          return const _LoadingChatWidget();
        },
      ),
    );
  }
}

class _LoadingChatWidget extends StatelessWidget {
  const _LoadingChatWidget();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      children: List.generate(10, (index) {
        final message = Message(
          id: 'id',
          senderId: index.isEven ? '$index' : '${index + 1}',
          receiverId: '${index + 1}',
          chatRequestId: 'chatRequestId',
          content: 'index' * 2,
          sentAt: DateTime.now(),
        );
        return ChatBubbleWidget(
          currentUserId: '$index',
          message: message,
        ).applyShimmer(
          highlightColor: index.isEven ? Colors.green[200] : Colors.grey[200],
          baseColor: index.isEven ? Colors.green : Colors.grey,
        );
      }),
    );
  }
}
