import 'package:flashcard_pet/src/features/authentication/data/fake_auth_repository.dart';
import 'package:flashcard_pet/src/features/authentication/presentation/account/account_screen.dart';
import 'package:flashcard_pet/src/features/authentication/presentation/sign_in/email_password_sign_in_form_type.dart';
import 'package:flashcard_pet/src/features/authentication/presentation/sign_in/email_password_sign_in_screen.dart';
import 'package:flashcard_pet/src/features/decks/presentation/deck_list_screen.dart';
import 'package:flashcard_pet/src/features/flashcards/presentation/study/study_flashcard_screen.dart';
import 'package:flashcard_pet/src/routing/go_router_refresh_stream.dart';
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

@Riverpod(keepAlive: true)
GoRouter goRouter(GoRouterRef ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return GoRouter(
    initialLocation: '/home',
    debugLogDiagnostics: false,
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
      GoRoute(
        path: '/home',
        name: AppRoute.home.name,
        builder: (context, state) => const DeckListScreen(),
        routes: [
          GoRoute(
            path: 'account',
            name: AppRoute.account.name,
            pageBuilder: (context, state) => const MaterialPage(
              fullscreenDialog: true,
              child: AccountScreen(),
            ),
          ),
          GoRoute(
              path: 'study',
              name: AppRoute.study.name,
              pageBuilder: (context, state) {
                return const MaterialPage(
                  fullscreenDialog: true,
                  child: StudyFlashcardScreen(),
                );
              }),
        ],
      ),
      GoRoute(
        path: '/signIn',
        name: AppRoute.signIn.name,
        pageBuilder: (context, state) => const MaterialPage(
          fullscreenDialog: true,
          child: EmailPasswordSignInScreen(
            formType: EmailPasswordSignInFormType.signIn,
          ),
        ),
      ),
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),
  );
}
