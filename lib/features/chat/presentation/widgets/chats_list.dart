// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:the_geolounge/core/core.dart';
import 'package:the_geolounge/features/chat/data/supabase_chat_repository.dart';
import 'package:the_geolounge/features/chat/presentation/controller/chat_controller.dart';
import 'package:the_geolounge/features/chat/presentation/widgets/chat_options_dialog.dart';
import 'package:the_geolounge/features/post/presentation/widgets/comment_avatar.dart';

class ChatsList extends ConsumerWidget {
  const ChatsList({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final acceptedChatRequestsProvider =
        ref.watch(getAcceptedChatRequestsProvider);
    return acceptedChatRequestsProvider.when(
      skipLoadingOnRefresh: false,
      data: (acceptedRequests) {
        if (acceptedRequests.isEmpty) {
          return const EmptyResultWidget();
        }
        return ListView.builder(
          shrinkWrap: true,
          itemCount: acceptedRequests.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final request = acceptedRequests[index];
            return Column(
              children: [
                ListTile(
                  onTap: () {
                    ref.read(goRouterProvider).pushNamed(
                      Routes.chatDetails,
                      pathParameters: {
                        'requestId': request.id,
                        'senderId': request.senderId,
                        'receiverId': request.receiverId,
                      },
                    );
                  },
                  onLongPress: () {
                    showDialog<void>(
                      context: context,
                      builder: (context) => ChatOptionsDialog(
                        onDelete: () {
                          ref
                              .read(chatControllerProvider.notifier)
                              .deleteChat(request.id);
                        },
                      ),
                    );
                  },
                  leading: CommentAvatar(
                    userId: request.senderId + request.receiverId,
                    postId: request.id,
                  ),
                  subtitle: _LastChatMessage(chatId: request.id)
                      .setOpacity(opacity: 0.7),
                  title: Text(
                    request.openingMessage,
                  ),
                ),
                const Divider(),
              ],
            );
          },
        );
      },
      error: (e, s) => ErrorResultWidget(
        onRefresh: () {
          ref
            ..invalidate(getAcceptedChatRequestsProvider)
            ..invalidate(
              getChatRequestsProvider.call(RequestStatus.pending),
            );
        },
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class _LastChatMessage extends ConsumerWidget {
  final String chatId;
  const _LastChatMessage({
    required this.chatId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(getLastMessageProvider.call(chatId));

    return provider.when(
      data: (message) {
        final timeSent = Jiffy.parseFromDateTime(message.sentAt).fromNow();
        return Text(
          '$timeSent • ${message.content}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: context.labelSmall,
        );
      },
      error: (e, r) => const Text(''),
      loading: () => const Text('...'),
    );
  }
}
