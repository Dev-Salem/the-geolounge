import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:the_geolounge/core/core.dart';
import 'package:the_geolounge/features/post/data/supabase_post_repository.dart';
import 'package:the_geolounge/features/post/domain/post_card.dart';
import 'package:the_geolounge/features/post/presentation/controller/fetch_post_controller.dart';
import 'package:the_geolounge/features/post/presentation/widgets/comment_card_widget.dart';
part 'post_controller.g.dart';

@riverpod
class PostController extends _$PostController {
  @override
  FutureOr<void> build() {}
  Future<void> addPost(String content, Rooms room) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(postRepositoryProvider).createPost(content, room),
    );
    if (state.hasValue) {
      ref.watch(goRouterProvider).go(Routes.post);
      ref.watch(fetchPostProvider.notifier).invalidateProvider();
    }
  }

  Future<void> addComment(
    String postId,
    String content, {
    String? parentCommentId,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(postRepositoryProvider).addComment(postId, content),
    );
  }

  Future<void> votePost(String postId, VoteType vote) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.watch(postRepositoryProvider).votePost(postId, vote),
    );
    if (state.hasValue) {
      final updatedPost = await _fetchPost(postId);
      if (updatedPost.hasValue) {
        ref
            .watch(fetchPostProvider.notifier)
            .replaceOldPost(updatedPost.requireValue);
      }
    }
  }

  Future<AsyncValue<PostCard>> _fetchPost(String postId) async {
    return AsyncValue.guard(
      () => ref.watch(postRepositoryProvider).fetchPost(postId),
    );
  }

  Future<void> voteComment(String commentId, VoteType vote) async {
    state = await AsyncValue.guard(
      () => ref.read(postRepositoryProvider).voteComment(commentId, vote),
    );
  }

  Future<void> replyToComment(
    String postId,
    String parentCommentId,
    String content,
  ) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref
          .read(postRepositoryProvider)
          .replyToComment(postId, parentCommentId, content),
    );
    if (!state.isLoading) {
      ref.read(parentCommentProvider.notifier).state =
          (parentCommentContent: null, parentCommentId: null);
    }
  }

  Future<void> deletePost(String postId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(postRepositoryProvider).deletePost(postId),
    );
    ref.watch(fetchPostProvider.notifier).invalidateProvider();
    ref.watch(goRouterProvider).pop();
  }

  Future<void> deleteComment(String commentId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(postRepositoryProvider).deleteComment(commentId),
    );
    ref.watch(goRouterProvider).pop();
  }

  Future<String?> reportContent({
    required String postId,
    required String userId,
    required String content,
  }) async {
    state = await AsyncValue.guard(
      () => ref
          .read(postRepositoryProvider)
          .reportContent(postId: postId, userId: userId, content: content),
    );
    ref.watch(goRouterProvider).pop();
    if (state.hasValue) {
      return 'The Post was reported successfully';
    }
    return null;
  }
}
