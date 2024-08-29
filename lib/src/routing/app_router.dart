import 'package:flashcard_pet/src/features/authentication/data/fake_auth_repository.dart';
import 'package:flashcard_pet/src/features/decks/presentation/decks_list_screen.dart';
import 'package:flashcard_pet/src/features/flashcards/presentation/study/study_flashcard_screen.dart';
import 'package:flashcard_pet/src/routing/go_router_refresh_stream.dart';
import 'package:flashcard_pet/src/routing/ui/scaffold_with_nested_navigation.dart';
import 'package:flashcard_pet/src/routing/not_found_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

enum AppRoute {
  home,
  study,
  account,
  signIn,
}

enum NavigationItem {
  decks(label: "Decks", icon: Icons.card_travel),
  study(label: "Study", icon: Icons.edit);
  //pet(label: "Pet", icon: Icons.pets);

  final String label;
  final IconData icon;

  const NavigationItem({required this.label, required this.icon});
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorHomeKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellHome');
final _shellNavigatorStudyKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellStudy');

@Riverpod(keepAlive: true)
GoRouter goRouter(GoRouterRef ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return GoRouter(
    initialLocation: '/home',
    debugLogDiagnostics: false,
    navigatorKey: _rootNavigatorKey,
    redirect: (context, state) {
      final isLoggedIn = authRepository.currentUser != null;
      final path = state.uri.path;
      if (isLoggedIn) {
        if (path == '/signIn') {
          return '/home';
        }
      } else {
        if (path == '/home/account') {
          return '/signIn';
        }
      }
      return null;
    },
    refreshListenable: GoRouterRefreshStream(authRepository.authStateChanges()),
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          // the UI shell
          return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
        },
        branches: [
          // first branch (decks)
          StatefulShellBranch(
            navigatorKey: _shellNavigatorHomeKey,
            routes: [
              // top route inside branch
              GoRoute(
                path: '/home',
                name: AppRoute.home.name,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: DeckListScreen(),
                ),
              ),
            ],
          ),
          // second branch (study)
          StatefulShellBranch(
            navigatorKey: _shellNavigatorStudyKey,
            routes: [
              // top route inside branch
              GoRoute(
                path: '/study',
                name: AppRoute.study.name,
                pageBuilder: (context, state) {
                  return const NoTransitionPage(
                    child: StudyFlashcardScreen(),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),
  );
}
