import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:the_geolounge/features/post/data/supabase_post_repository.dart';
import 'package:the_geolounge/features/post/domain/post_card.dart';

abstract class PaginationController<T, I> {
  I get _initialPage;

  late I currentPage = _initialPage;

  FutureOr<List<T>> loadPage(I page);

  Future<void> loadNextPage();

  I nextPage(I currentPage);

  bool get hasReachedMaxLimit;

  void invalidateProvider();
}

mixin AsyncPaginationController<T, I> on AsyncNotifier<List<T>>
    implements PaginationController<T, I> {
  @override
  late I currentPage = _initialPage;

  @override
  FutureOr<List<T>> build() async => loadPage(_initialPage);

  @override
  late bool hasReachedMaxLimit = false;

  @override
  Future<void> loadNextPage() async {
    state = AsyncLoading<List<T>>();

    final newState = await AsyncValue.guard<List<T>>(() async {
      currentPage = nextPage(currentPage);
      final elements = await loadPage(currentPage);
      hasReachedMaxLimit = elements.isEmpty;
      return [...?state.value, ...elements];
    });
    state = newState;
  }

  @override
  void invalidateProvider() {
    ref.invalidateSelf();
    hasReachedMaxLimit = false;
    currentPage = _initialPage;
  }
}

class AsyncPostsNotifier extends AsyncNotifier<List<PostCard>>
    with AsyncPaginationController<PostCard, int> {
  late final _repository = ref.read(postRepositoryProvider);

  @override
  final _initialPage = 1;

  @override
  FutureOr<List<PostCard>> loadPage(int page) async {
    final posts =
        await _repository.fetchPosts(page, getLocalPosts: _getLocalPosts);
    return posts;
  }

  @override
  int nextPage(int currentPage) => currentPage + 1;

  bool _getLocalPosts = true;
  bool changePostsLocality() {
    _getLocalPosts = !_getLocalPosts;
    invalidateProvider();
    return _getLocalPosts;
  }

  void replaceOldPost(PostCard updatedPost) {
    final oldPostIndex =
        state.value!.indexWhere((element) => element.id == updatedPost.id);
    final updatedPostsList = state.value!;
    updatedPostsList[oldPostIndex] = updatedPost;
    state = AsyncValue.data(updatedPostsList);
  }
}

final fetchPostProvider =
    AsyncNotifierProvider<AsyncPostsNotifier, List<PostCard>>(() {
  return AsyncPostsNotifier();
});
