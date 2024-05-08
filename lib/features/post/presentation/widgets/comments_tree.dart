import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:flutter/material.dart';
import 'package:the_geolounge/core/widgets/empty_result_widget.dart';
import 'package:the_geolounge/features/post/domain/comment.dart';
import 'package:the_geolounge/features/post/domain/post.dart';
import 'package:the_geolounge/features/post/presentation/widgets/comment_card_widget.dart';
import 'package:the_geolounge/features/post/presentation/widgets/post_card.dart';

class CommentsTree extends StatelessWidget {
  const CommentsTree({
    required this.post,
    super.key,
  });
  final Post post;
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        PostCard(
          post: post,
          showCommentButton: false,
        ),
        if (post.comments!.isEmpty)
          const EmptyResultWidget()
        else
          TreeView.simpleTyped<Comment, TreeNode<Comment>>(
            shrinkWrap: true,
            focusToNewNode: false,
            expansionIndicatorBuilder: (p0, p1) => ChevronIndicator.rightDown(
              tree: p1,
              padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 10),
            ),
            tree: _buildNestedCommentTree(post.comments!),
            showRootNode: false,
            indentation: const Indentation(
              width: 20,
            ),
            builder: (context, node) {
              return CommentCardWidget(
                comment: node.data!,
                userId: post.userId,
              );
            },
          ),
      ],
    );
  }
}

TreeNode<Comment> _buildNestedCommentTree(List<Comment> comments) {
  final root = TreeNode<Comment>.root();

  final commentNodeMap = <String, TreeNode<Comment>>{};

  for (final comment in comments) {
    commentNodeMap[comment.id] =
        TreeNode<Comment>(data: comment, key: comment.id);
  }

  for (final comment in comments) {
    final node = commentNodeMap[comment.id];
    if (comment.parentCommentId == null) {
      root.add(node!);
    } else {
      final parentNode = commentNodeMap[comment.parentCommentId];
      parentNode?.add(node!);
    }
  }

  return root;
}
