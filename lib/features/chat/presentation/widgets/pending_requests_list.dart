import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_geolounge/core/constants/request_status.dart';
import 'package:the_geolounge/features/chat/data/supabase_chat_repository.dart';
import 'package:the_geolounge/features/chat/domain/chat_request.dart';
import 'package:the_geolounge/features/chat/presentation/controller/chat_controller.dart';
import 'package:the_geolounge/features/post/presentation/widgets/comment_avatar.dart';
import 'package:the_geolounge/gen/strings.g.dart';

class PendingRequestsList extends ConsumerWidget {
  const PendingRequestsList({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pendingChatRequestsProvider =
        ref.watch(getChatRequestsProvider.call(RequestStatus.pending));
    return pendingChatRequestsProvider.when(
      skipLoadingOnRefresh: false,
      data: (requests) {
        return requests.isEmpty
            ? const SizedBox.shrink()
            : SizedBox(
                height: 128,
                child: ListView.builder(
                  itemCount: requests.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final request = requests[index];
                    return _PendingRequestCard(
                      request: requests[index],
                      onAccept: () {
                        ref
                            .read(chatControllerProvider.notifier)
                            .updateRequestStatus(
                              request.id,
                              RequestStatus.accepted,
                            );
                      },
                      onReject: () {
                        ref
                            .read(chatControllerProvider.notifier)
                            .updateRequestStatus(
                              request.id,
                              RequestStatus.rejected,
                            );
                      },
                    );
                  },
                ),
              );
      },
      error: (e, s) => Center(
        child: Text(
          t.posts.something_wrong,
        ),
      ),
      loading: LinearProgressIndicator.new,
    );
  }
}

class _PendingRequestCard extends StatelessWidget {
  const _PendingRequestCard({
    required this.onAccept,
    required this.onReject,
    required this.request,
  });
  final VoidCallback onAccept;
  final VoidCallback onReject;
  final ChatRequest request;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        width: 300,
        child: Center(
          child: ListTile(
            leading:
                CommentAvatar(userId: request.senderId, postId: request.postId),
            title: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    request.openingMessage,
                    softWrap: true,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton.icon(
                        onPressed: onAccept,
                        icon: const Icon(
                          FontAwesomeIcons.check,
                          size: 16,
                        ),
                        label: Text(t.chat.accept),
                      ),
                      TextButton.icon(
                        onPressed: onReject,
                        icon: const Icon(
                          FontAwesomeIcons.x,
                          size: 16,
                          color: Colors.red,
                        ),
                        label: Text(
                          t.chat.reject,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
