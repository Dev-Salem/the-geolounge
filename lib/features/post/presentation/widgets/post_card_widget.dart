import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jiffy/jiffy.dart';
import 'package:the_geolounge/core/core.dart';
import 'package:the_geolounge/features/post/domain/post_card.dart';
import 'package:the_geolounge/features/post/presentation/controller/post_controller.dart';
import 'package:the_geolounge/features/post/presentation/widgets/card_options_dialog.dart';
import 'package:the_geolounge/features/post/presentation/widgets/send_message_dialog.dart';
import 'package:the_geolounge/gen/strings.g.dart';

class PostCardWidget extends ConsumerWidget {
  const PostCardWidget({
    required this.post,
    super.key,
  });
  final PostCard post;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: _CardInfo(post: post)),
            //option button
            CardOptionsDialog(
              onReport: () {
                ref.read(postControllerProvider.notifier).reportContent(
                      postId: post.id,
                      userId: post.userId,
                      content: post.content,
                    );
              },
              onDelete: () {
                ref.read(postControllerProvider.notifier).deletePost(post.id);
              },
              onSendMessage: () async {
                await showDialog<void>(
                  context: context,
                  builder: (context) => SendMessageDialog(
                    receiverId: post.userId,
                    postId: post.id,
                  ),
                );
              },
              authorId: post.userId,
            ),
          ],
        ),
        4.heightBox,
        Text(
          post.content,
          style: context.bodyLarge,
        ),
        _CardActions(
          post: post,
          onUpvote: () async {
            await ref
                .read(postControllerProvider.notifier)
                .votePost(post.id, VoteType.upvote);
          },
          onDownvote: () async {
            await ref
                .read(postControllerProvider.notifier)
                .votePost(post.id, VoteType.downvote);
          },
          onComment: () {
            ref.read(goRouterProvider).goNamed(
              Routes.postDetails,
              pathParameters: {
                'id': post.id,
              },
            );
          },
        ),
        8.heightBox,
      ],
    );
  }
}

class _CardInfo extends StatelessWidget {
  const _CardInfo({
    required this.post,
  });
  final PostCard post;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 50,
          width: 50,
          margin: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            color: context.dividerColor,
            borderRadius: BorderRadiusDirectional.circular(10),
          ),
          child: const Icon(FontAwesomeIcons.circleUser),
        ),
        16.widthBox,
        //location & room
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                t['rooms.${post.room.name}'] as String,
              ),
              Text(
                '${post.country}, ${post.city}',
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CardActions extends StatelessWidget {
  const _CardActions({
    required this.onUpvote,
    required this.onDownvote,
    required this.onComment,
    required this.post,
  });
  final VoidCallback onUpvote;
  final VoidCallback onDownvote;
  final VoidCallback onComment;
  final PostCard post;
  @override
  Widget build(BuildContext context) {
    const cardIconsSize = 20.0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton.icon(
          label: Text(
            '${post.upvotes}',
          ),
          onPressed: onUpvote,
          icon: const Icon(
            FontAwesomeIcons.chevronUp,
            size: cardIconsSize,
          ),
        ),
        TextButton.icon(
          label: Text(
            post.downvotes == 0 ? '0' : '-${post.downvotes}',
          ),
          onPressed: onDownvote,
          icon: const Icon(
            FontAwesomeIcons.chevronDown,
            size: cardIconsSize,
          ),
        ),
        TextButton.icon(
          label: Text(
            '${post.comments}',
          ),
          onPressed: onComment,
          icon: const Icon(
            FontAwesomeIcons.commentDots,
            size: cardIconsSize,
          ),
        ),
        Flexible(
          child: Text(
            Jiffy.parseFromDateTime(post.createdAt).fromNow(),
            style: context.bodySmall!.copyWith(color: Colors.grey),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
