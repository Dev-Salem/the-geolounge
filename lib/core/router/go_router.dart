import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:the_geolounge/core/core.dart';
import 'package:the_geolounge/features/auth/data/supabase_auth_repository.dart';
import 'package:the_geolounge/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:the_geolounge/features/chat/presentation/screens/chat_details_screen.dart';
import 'package:the_geolounge/features/chat/presentation/screens/chat_screen.dart';
import 'package:the_geolounge/features/post/presentation/screens/create_post_screen.dart';
import 'package:the_geolounge/features/post/presentation/screens/post_details_screen.dart';
import 'package:the_geolounge/features/post/presentation/screens/posts_screen.dart';
import 'package:the_geolounge/features/settings/presentation/screens/account_screen.dart';
import 'package:the_geolounge/features/user/user.dart';

part 'go_router.g.dart';

final _postKey = GlobalKey<NavigatorState>(debugLabel: '1-Post Key');
final _chatKey = GlobalKey<NavigatorState>(debugLabel: '2-Chat key');
final _accountKey = GlobalKey<NavigatorState>(debugLabel: '3-Account Key');
final _rootKey = GlobalKey<NavigatorState>();

@riverpod
GoRouter goRouter(GoRouterRef ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final userRepository = ref.watch(userRepositoryProvider);
  return GoRouter(
    refreshListenable: GoRouterRefreshStream(authRepository.authStateChanges()),
    initialLocation: Routes.post,
    navigatorKey: _rootKey,
    debugLogDiagnostics: kDebugMode,
    redirect: (context, state) async {
      final path = state.uri.path;
      final currentSession = authRepository.currentSession;
      final isFirstSignIn = userRepository.isFirstSignIn;
      if (currentSession == null) {
        return Routes.signIn;
      } else {
        if (isFirstSignIn) {
          return Routes.profile;
        }
        if (path.startsWith('/signIn')) {
          return Routes.post;
        }
      }
      return null;
    },
    routes: [
      GoRoute(
        path: Routes.signIn,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: Routes.createPost,
        builder: (context, state) => const CreatePostScreen(),
      ),
      GoRoute(
        path: Routes.profile,
        builder: (context, state) => const ProfileScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppScaffoldShell(navigationShell: navigationShell);
        },
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            initialLocation: Routes.post,
            navigatorKey: _postKey,
            routes: [
              GoRoute(
                name: Routes.post,
                path: Routes.post,
                pageBuilder: (context, state) => NoTransitionPage(
                  child: AppScaffold(
                    body: PostsScreen(
                      key: state.pageKey,
                    ),
                  ),
                ),
                routes: [
                  GoRoute(
                    name: Routes.postDetails,
                    path: ':id',
                    pageBuilder: (context, state) {
                      return NoTransitionPage(
                        child: AppScaffold(
                          body: PostsScreen(
                            key: state.pageKey,
                          ),
                          secondaryBody: PostDetailsScreen(
                            postId: state.pathParameters['id']!,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),

          //Chat Bar
          StatefulShellBranch(
            initialLocation: Routes.chat,
            navigatorKey: _chatKey,
            routes: [
              GoRoute(
                name: Routes.chat,
                path: Routes.chat,
                pageBuilder: (context, state) => NoTransitionPage(
                  child: AppScaffold(
                    body: ChatScreen(
                      key: state.pageKey,
                    ),
                  ),
                ),
                routes: [
                  GoRoute(
                    name: Routes.chatDetails,
                    path: ':requestId/:senderId/:receiverId',
                    pageBuilder: (context, state) {
                      return NoTransitionPage(
                        child: AppScaffold(
                          body: const ChatScreen(),
                          secondaryBody: ChatDetailsScreen(
                            requestId: state.pathParameters['requestId']!,
                            senderId: state.pathParameters['senderId']!,
                            receiverId: state.pathParameters['receiverId']!,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _accountKey,
            routes: [
              GoRoute(
                path: Routes.account,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: AppScaffold(body: AccountScreen()),
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
