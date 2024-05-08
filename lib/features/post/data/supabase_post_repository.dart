import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:the_geolounge/core/core.dart';
import 'package:the_geolounge/features/auth/data/supabase_auth_repository.dart';
import 'package:the_geolounge/features/post/domain/comment.dart';
import 'package:the_geolounge/features/post/domain/post.dart';
import 'package:the_geolounge/features/post/domain/post_card.dart';
import 'package:the_geolounge/features/post/domain/report.dart';
import 'package:the_geolounge/features/user/data/supabase_user_repository.dart';

part 'supabase_post_repository.g.dart';

class PostRepository {
  PostRepository({
    required this.supabase,
    required this.ref,
  });
  final SupabaseClient supabase;
  final Ref ref;

  Future<void> createPost(String content, Rooms room) async {
    final currentUser = await ref.read(userRepositoryProvider).getCurrentUser();
    final post = Post.toMap(
      content: content,
      room: room,
      country: currentUser.country,
      city: currentUser.city,
    );
    await supabase.from(SupabaseConstants.post).insert(post);
  }

  Future<PostCard> fetchPost(String postId) async {
    final post = await supabase
        .rpc<Map<String, dynamic>>('get_post_cards')
        .eq('post_id', postId)
        .single();
    return PostCard.fromMap(post);
  }

  Future<List<PostCard>> fetchPosts(
    int page, {
    required bool getLocalPosts,
  }) async {
    const pageSize = 9;
    final end = page * pageSize;
    final start = end - pageSize;
    var query = supabase.rpc<List<dynamic>>('get_post_cards');
    if (getLocalPosts) {
      final currentUser =
          await ref.read(userRepositoryProvider).getCurrentUser();
      final userCity = currentUser.city;
      query = query.eq('city', userCity);
    }
    final result = await query.order('created_at').range(start, end);
    final posts =
        result.map((e) => PostCard.fromMap(e as Map<String, dynamic>)).toList();
    // ignore: lines_longer_than_80_chars
    '${posts.length} Posts were added, page:$page, local:$getLocalPosts, ($start,$end)'
        .infoLogger();
    return posts;
  }

  Future<void> deletePost(String postId) async {
    await supabase.from(SupabaseConstants.post).delete().eq('id', postId);
  }

  Stream<Post> getPost(String id) {
    final posts = supabase
        .from(SupabaseConstants.post)
        .stream(
          primaryKey: ['id'],
        )
        .eq('id', id)
        .map((list) => list.map(Post.fromMap).toList().first);
    final comments = supabase
        .from(SupabaseConstants.comment)
        .stream(primaryKey: ['id'])
        .eq('post_id', id)
        .map(
          (comments) => comments.map(Comment.fromMap).toList(),
        );
    final combinedStream = Rx.combineLatest2(posts, comments, (post, comment) {
      return post.copyWith(comments: comment);
    });
    return combinedStream;
  }

  Future<void> votePost(String postId, VoteType vote) async {
    final voteColumn = vote == VoteType.upvote ? 'upvotes' : 'downvotes';
    final query = await supabase
        .from(SupabaseConstants.post)
        .select()
        .eq('id', postId)
        .single();
    final post = Post.fromMap(query);
    final votes = vote == VoteType.upvote ? post.upvotes : post.downvotes;
    if (votes.contains(supabase.auth.currentUser!.id)) {
      votes.remove(supabase.auth.currentUser!.id);
      await supabase
          .from(SupabaseConstants.post)
          .update({voteColumn: votes}).eq('id', postId);
    } else {
      votes.add(supabase.auth.currentUser!.id);
      await supabase
          .from(SupabaseConstants.post)
          .update({voteColumn: votes}).eq('id', postId);
    }
  }

//=======Comments=======
  Future<void> addComment(
    String postId,
    String content,
  ) async {
    final comment = Comment.toMap(postId: postId, content: content);
    await supabase.from(SupabaseConstants.comment).insert(comment);
  }

  Future<void> deleteComment(String commentId) async {
    await supabase.from(SupabaseConstants.comment).delete().eq('id', commentId);
  }

  Future<void> voteComment(
    String commentId,
    VoteType vote,
  ) async {
    final query = await supabase
        .from(SupabaseConstants.comment)
        .select()
        .eq('id', commentId)
        .single();
    final comment = Comment.fromMap(query);
    final voteColumn = vote == VoteType.upvote ? 'upvotes' : 'downvotes';
    final votes = vote == VoteType.upvote ? comment.upvotes : comment.downvotes;
    if (votes.contains(supabase.auth.currentUser!.id)) {
      votes.remove(supabase.auth.currentUser!.id);
      await supabase
          .from(SupabaseConstants.comment)
          .update({voteColumn: votes}).eq('id', commentId);
    } else {
      votes.add(supabase.auth.currentUser!.id);
      await supabase
          .from(SupabaseConstants.comment)
          .update({voteColumn: votes}).eq('id', commentId);
    }
  }

  Future<void> replyToComment(
    String postId,
    String parentCommentId,
    String content,
  ) async {
    final comment = Comment.toMap(
      postId: postId,
      content: content,
      parentCommentId: parentCommentId,
    );
    await supabase.from(SupabaseConstants.comment).insert(comment);
  }

  Future<void> reportContent({
    required String postId,
    required String userId,
    required String content,
  }) async {
    final report =
        Report.toMap(postId: postId, userId: userId, content: content);
    await supabase
        .from(SupabaseConstants.reports)
        .upsert(report, ignoreDuplicates: true, onConflict: 'id');
  }
}

@Riverpod(keepAlive: true)
PostRepository postRepository(PostRepositoryRef ref) {
  return PostRepository(
    ref: ref,
    supabase: ref.watch(supabaseClientProvider),
  );
}

@riverpod
Stream<Post> getPostDetails(GetPostDetailsRef ref, String postId) {
  return ref.watch(postRepositoryProvider).getPost(postId);
}
