import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_geolounge/core/core.dart';
import 'package:the_geolounge/features/post/presentation/controller/fetch_post_controller.dart';
import 'package:the_geolounge/features/post/presentation/controller/post_controller.dart';
import 'package:the_geolounge/features/post/presentation/widgets/filter_posts_button.dart';
import 'package:the_geolounge/features/post/presentation/widgets/post_card_shimmer.dart';
import 'package:the_geolounge/features/post/presentation/widgets/post_card_widget.dart';
import 'package:the_geolounge/gen/strings.g.dart';
import 'package:very_good_infinite_list/very_good_infinite_list.dart';

class PostsScreen extends ConsumerWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      postControllerProvider,
      (previous, current) {
        if (current.hasError && (!current.isLoading)) {
          current.error.toString().errorLogger();
          if (context.mounted) {
            context.snackBar(t.posts.something_wrong);
          }
        }
      },
    );
    final responseAsync = ref.watch(fetchPostProvider);
    final controller = ref.watch(fetchPostProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: const FilterPostsButton(),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(FontAwesomeIcons.pen),
        onPressed: () => ref.read(goRouterProvider).push(Routes.createPost),
      ),
      body: RefreshIndicator.adaptive(
        onRefresh: () async =>
            ref.read(fetchPostProvider.notifier).invalidateProvider(),
        child: InfiniteList(
          hasReachedMax: controller.hasReachedMaxLimit,
          hasError: responseAsync.hasError,
          centerLoading: true,
          centerError: true,
          isLoading: responseAsync.isLoading,
          itemCount: responseAsync.valueOrNull?.length ?? 0,
          separatorBuilder: (context, index) => const Divider(
            height: 24,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          onFetchData: controller.loadNextPage,
          errorBuilder: (context) {
            return ErrorResultWidget(
              onRefresh: () =>
                  ref.read(fetchPostProvider.notifier).invalidateProvider(),
            );
          },
          emptyBuilder: (context) => const EmptyResultWidget(),
          loadingBuilder: (context) {
            return responseAsync.value == null
                ? Column(
                    children:
                        List.generate(5, (index) => const PostCardShimmer()),
                  )
                : const CircularProgressIndicator.adaptive();
          },
          itemBuilder: (context, index) {
            return PostCardWidget(post: responseAsync.requireValue[index]);
          },
        ),
      ),
    );
  }
}
