import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jiffy/jiffy.dart';
import 'package:the_geolounge/core/constants/vote_type.dart';
import 'package:the_geolounge/features/post/domain/comment.dart';
import 'package:the_geolounge/features/post/presentation/controller/post_controller.dart';
import 'package:the_geolounge/features/post/presentation/widgets/card_options_dialog.dart';
import 'package:the_geolounge/features/post/presentation/widgets/comment_avatar.dart';
import 'package:the_geolounge/features/post/presentation/widgets/send_message_dialog.dart';

class CommentCardWidget extends ConsumerWidget {
  const CommentCardWidget({
    required this.comment,
    required this.userId,
    super.key,
  });
  final String userId;
  final Comment comment;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(
              child: CommentAvatar(
                postId: comment.postId,
                userId: comment.userId,
              ),
            ),
            8.heightBox,
            if (userId == comment.userId)
              const Padding(
                padding: EdgeInsets.all(8),
                child: Icon(
                  FontAwesomeIcons.feather,
                  size: 16,
                  color: Colors.grey,
                ),
              )
            else
              const SizedBox.shrink(),
            const Expanded(child: SizedBox()),
            CardOptionsDialog(
              onReport: () =>
                  ref.read(postControllerProvider.notifier).reportContent(
                        postId: comment.id,
                        userId: userId,
                        content: comment.content,
                      ),
              onDelete: () => ref
                  .read(postControllerProvider.notifier)
                  .deleteComment(comment.id),
              onSendMessage: () async {
                await showDialog<void>(
                  context: context,
                  builder: (context) => SendMessageDialog(
                    receiverId: comment.userId,
                    postId: comment.postId,
                  ),
                );
              },
              authorId: comment.userId,
            ),
            const SizedBox(
              width: 24,
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            comment.content,
            style: context.bodyMedium,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  TextButton.icon(
                    label: Text(
                      comment.upvotes.length.toString(),
                    ),
                    onPressed: () => ref
                        .read(postControllerProvider.notifier)
                        .voteComment(comment.id, VoteType.upvote),
                    icon: const Icon(
                      FontAwesomeIcons.chevronUp,
                      size: 16,
                    ),
                  ),
                  TextButton.icon(
                    label: Text(
                      comment.downvotes.isEmpty
                          ? '0'
                          : '-${comment.downvotes.length}',
                    ),
                    onPressed: () => ref
                        .read(postControllerProvider.notifier)
                        .voteComment(comment.id, VoteType.downvote),
                    icon: const Icon(
                      FontAwesomeIcons.chevronDown,
                      size: 16,
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: () {
                  ref.read(parentCommentProvider.notifier).state = (
                    parentCommentContent: comment.content,
                    parentCommentId: comment.id
                  );
                },
                icon: const Icon(Icons.reply),
              ),
              Text(
                Jiffy.parseFromDateTime(comment.createdAt).fromNow(),
                style: context.labelSmall!.copyWith(color: Colors.grey),
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

final parentCommentProvider = StateProvider.autoDispose<
    ({String? parentCommentContent, String? parentCommentId})>(
  (ref) => (parentCommentContent: null, parentCommentId: null),
);
