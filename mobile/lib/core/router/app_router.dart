import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:therapist/features/auth/bloc/auth_bloc.dart';
import 'package:therapist/features/auth/presentation/login_page.dart';
import 'package:therapist/features/blog/data/blog_repository.dart';
import 'package:therapist/features/blog/presentation/blog_detail_page.dart';
import 'package:therapist/features/blog/presentation/blog_list_page.dart';
import 'package:therapist/features/blog/presentation/create_blog_page.dart';
import 'package:therapist/features/home/presentation/home_page.dart';
import 'package:therapist/features/onboarding/presentation/onboarding_page.dart';
import 'package:therapist/features/status/presentation/pending_page.dart';
import 'package:therapist/features/status/presentation/rejected_page.dart';
import 'package:therapist/shared/widgets/scaffold_with_nav.dart';

/// Named route constants — use these everywhere instead of raw strings.
abstract class AppRoutes {
  static const login      = '/login';
  static const onboarding = '/onboarding';
  static const pending    = '/pending';
  static const rejected   = '/rejected';
  static const home       = '/home';
  static const profile    = '/profile';
  static const blog       = '/blog';
  static const blogDetail = '/blog/detail';
  static const blogCreate = '/blog/create';
  static const blogEdit   = '/blog/edit';
}

/// Routes that are only accessible when unauthenticated.
const _publicRoutes = {AppRoutes.login};

GoRouter buildRouter(AuthBloc authBloc) => GoRouter(
      initialLocation: AppRoutes.login,
      debugLogDiagnostics: true,
      refreshListenable: _AuthBlocListenable(authBloc),
      redirect: (ctx, state) => _redirect(ctx, state, authBloc),
      routes: [
        GoRoute(
          path: AppRoutes.login,
          pageBuilder: (ctx, state) => _fade(const LoginPage()),
        ),
        GoRoute(
          path: AppRoutes.onboarding,
          pageBuilder: (ctx, state) => _fade(const OnboardingPage()),
        ),
        GoRoute(
          path: AppRoutes.pending,
          pageBuilder: (ctx, state) => _fade(const PendingPage()),
        ),
        GoRoute(
          path: AppRoutes.rejected,
          pageBuilder: (ctx, state) => _fade(
            RejectedPage(reason: state.extra as String?),
          ),
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
              pageBuilder: (ctx, state) => _fade(const HomePage()),
            ),
            GoRoute(
              path: AppRoutes.blog,
              pageBuilder: (ctx, state) => _fade(const BlogListPage()),
            ),
          ],
        ),
        // Blog detail / create / edit — outside shell so they have no bottom nav.
        GoRoute(
          path: AppRoutes.blogDetail,
          pageBuilder: (ctx, state) {
            final blogId = state.extra as String;
            return _fade(BlogDetailPage(blogId: blogId));
          },
        ),
        GoRoute(
          path: AppRoutes.blogCreate,
          pageBuilder: (ctx, state) => _fade(const CreateBlogPage()),
        ),
        GoRoute(
          path: AppRoutes.blogEdit,
          pageBuilder: (ctx, state) {
            final blog = state.extra as BlogModel;
            return _fade(CreateBlogPage(existingBlog: blog));
          },
        ),
      ],
    );

String? _redirect(BuildContext ctx, GoRouterState state, AuthBloc authBloc) {
  final authState = authBloc.state;
  final location  = state.matchedLocation;

  // While loading / initial, stay put
  if (authState is AuthInitial || authState is AuthLoading) return null;

  // Unauthenticated — send to login unless already there
  if (authState is AuthUnauthenticated || authState is AuthError) {
    return _publicRoutes.contains(location) ? null : AppRoutes.login;
  }

  if (authState is AuthAuthenticated) {
    final status = authState.status;

    // Coming from login — send to the right place
    if (_publicRoutes.contains(location)) return _defaultForStatus(status);

    // Status-locked pages: only allow if status matches
    if (_isStatusLockedRoute(location)) {
      final expected = _defaultForStatus(status);
      if (location != expected) return expected;
    }

    // Free authenticated pages (home, blog, profile) — block if not verified
    if (_isFreeAuthRoute(location) && status != 'verified') {
      return _defaultForStatus(status);
    }
  }

  return null;
}

/// The landing page for each status.
String _defaultForStatus(String status) => switch (status) {
      'needs_onboarding' => AppRoutes.onboarding,
      'pending'          => AppRoutes.pending,
      'rejected'         => AppRoutes.rejected,
      'verified'         => AppRoutes.home,
      _                  => AppRoutes.login,
    };

/// Pages that are exclusively tied to a specific status (must redirect away if status changes).
bool _isStatusLockedRoute(String location) =>
    location == AppRoutes.onboarding ||
    location == AppRoutes.pending    ||
    location == AppRoutes.rejected;

/// Pages that verified users can freely navigate between.
bool _isFreeAuthRoute(String location) =>
    location == AppRoutes.home    ||
    location == AppRoutes.profile ||
    location.startsWith(AppRoutes.blog);

CustomTransitionPage<void> _fade(Widget child) => CustomTransitionPage<void>(
      child: child,
      transitionsBuilder: (ctx, animation, _, c) =>
          FadeTransition(opacity: animation, child: c),
    );

/// Makes GoRouter re-evaluate redirects whenever AuthBloc emits a new state.
class _AuthBlocListenable extends ChangeNotifier {
  _AuthBlocListenable(AuthBloc bloc) {
    _sub = bloc.stream.listen((_) => notifyListeners());
  }

  late final dynamic _sub;

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }
}
