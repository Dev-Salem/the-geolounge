import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_geolounge/core/widgets/error_result_widget.dart';
import 'package:the_geolounge/core/widgets/post_text_field.dart';
import 'package:the_geolounge/features/post/data/supabase_post_repository.dart';
import 'package:the_geolounge/features/post/presentation/controller/post_controller.dart';
import 'package:the_geolounge/features/post/presentation/widgets/comment_card_widget.dart';
import 'package:the_geolounge/features/post/presentation/widgets/comments_tree.dart';

class PostDetailsScreen extends ConsumerWidget {
  const PostDetailsScreen({
    required this.postId,
    super.key,
  });
  final String postId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final parentComment = ref.watch(parentCommentProvider);
    final parentCommentId = parentComment.parentCommentId;
    final parentCommentContent = parentComment.parentCommentContent;
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: PostTextField(
        replyTo: parentCommentContent,
        validator: (p0) {
          if (p0 == null) {
            return null;
          }
          if (p0.length < 3) {
            return 'too short';
          }
          if (p0.length > 255) {
            return 'too long';
          }
          return null;
        },
        onSend: (text) {
          if (parentCommentContent == null || parentCommentId == null) {
            ref.read(postControllerProvider.notifier).addComment(postId, text!);
          } else {
            ref.read(postControllerProvider.notifier).replyToComment(
                  postId,
                  parentCommentId,
                  text!,
                );
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: ref.watch(getPostDetailsProvider.call(postId)).when(
            skipLoadingOnRefresh: false,
            data: (post) => CommentsTree(post: post),
            error: (error, e) => Center(
              child: ErrorResultWidget(
                onRefresh: () =>
                    ref.invalidate(getPostDetailsProvider.call(postId)),
              ),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
    );
  }
}
