import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:therapist/features/auth/presentation/login_page.dart';
import 'package:therapist/features/home/presentation/home_page.dart';
import 'package:therapist/features/onboarding/presentation/onboarding_page.dart';
import 'package:therapist/shared/widgets/scaffold_with_nav.dart';

/// Named route constants — use these everywhere instead of raw strings.
abstract class AppRoutes {
  static const login = '/login';
  static const onboarding = '/onboarding';
  static const home = '/home';
  static const profile = '/profile';
}

final appRouter = GoRouter(
  initialLocation: AppRoutes.login,
  debugLogDiagnostics: true,
  redirect: _globalRedirect,
  routes: [
    GoRoute(
      path: AppRoutes.login,
      pageBuilder: (ctx, state) => _fade(const LoginPage()),
    ),
    GoRoute(
      path: AppRoutes.onboarding,
      pageBuilder: (ctx, state) => _fade(const OnboardingPage()),
    ),
    ShellRoute(
      builder: (ctx, state, child) => ScaffoldWithNav(child: child),
      routes: [
        GoRoute(
          path: AppRoutes.home,
          pageBuilder: (ctx, state) => _fade(const HomePage()),
        ),
        GoRoute(
          path: AppRoutes.profile,
          pageBuilder: (ctx, state) => _fade(const HomePage()), // stub
        ),
      ],
    ),
  ],
);

String? _globalRedirect(BuildContext ctx, GoRouterState state) {
  final session = Supabase.instance.client.auth.currentSession;
  final isLoggedIn = session != null;
  final onLoginPage = state.matchedLocation == AppRoutes.login;

  if (!isLoggedIn && !onLoginPage) return AppRoutes.login;
  if (isLoggedIn && onLoginPage) return AppRoutes.home;
  return null;
}

CustomTransitionPage<void> _fade(Widget child) => CustomTransitionPage<void>(
      child: child,
      transitionsBuilder: (ctx, animation, _, c) =>
          FadeTransition(opacity: animation, child: c),
    );
