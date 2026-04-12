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
import 'package:therapist/features/user/presentation/user_onboarding_page.dart';
import 'package:therapist/shared/widgets/scaffold_with_nav.dart';

/// Named route constants — use these everywhere instead of raw strings.
abstract class AppRoutes {
  // ── Shared ────────────────────────────────────────────────────────────────
  static const login      = '/login';
  // ── Therapist ─────────────────────────────────────────────────────────────
  static const onboarding = '/onboarding';
  static const pending    = '/pending';
  static const rejected   = '/rejected';
  static const home       = '/home';
  static const profile    = '/profile';
  static const blog       = '/blog';
  static const blogDetail = '/blog/detail';
  static const blogCreate = '/blog/create';
  static const blogEdit   = '/blog/edit';
  // ── User (client/patient) ─────────────────────────────────────────────────
  static const userOnboarding = '/user/onboarding';
  static const userHome       = '/user/home';
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
        // ── User routes ──────────────────────────────────────────────────────
        GoRoute(
          path: AppRoutes.userOnboarding,
          pageBuilder: (ctx, state) => _fade(const UserOnboardingPage()),
        ),
        GoRoute(
          path: AppRoutes.userHome,
          // Placeholder until a dedicated user home is built.
          pageBuilder: (ctx, state) => _fade(const _UserHomePlaceholder()),
        ),
      ],
    );

String? _redirect(BuildContext ctx, GoRouterState state, AuthBloc authBloc) {
  final authState = authBloc.state;
  final location  = state.matchedLocation;

  // While loading / initial, stay put.
  if (authState is AuthInitial || authState is AuthLoading) return null;

  // Unauthenticated — send to login unless already there.
  if (authState is AuthUnauthenticated || authState is AuthError) {
    return _publicRoutes.contains(location) ? null : AppRoutes.login;
  }

  if (authState is AuthAuthenticated) {
    final status      = authState.status;
    final accountType = authState.accountType;

    // ── User (client/patient) flow ─────────────────────────────────────────
    if (accountType == 'user') {
      if (_publicRoutes.contains(location)) {
        return _defaultForUserStatus(status);
      }
      // Block user from therapist-only routes.
      if (_isTherapistRoute(location)) return _defaultForUserStatus(status);
      return null;
    }

    // ── Therapist flow ─────────────────────────────────────────────────────
    // Coming from login — send to the right place.
    if (_publicRoutes.contains(location)) return _defaultForStatus(status);

    // Status-locked pages: only allow if status matches.
    if (_isStatusLockedRoute(location)) {
      final expected = _defaultForStatus(status);
      if (location != expected) return expected;
    }

    // Free authenticated pages (home, blog, profile) — block if not verified.
    if (_isFreeAuthRoute(location) && status != 'verified') {
      return _defaultForStatus(status);
    }
  }

  return null;
}

/// Landing page for each therapist status.
String _defaultForStatus(String status) => switch (status) {
      'needs_onboarding' => AppRoutes.onboarding,
      'pending'          => AppRoutes.pending,
      'rejected'         => AppRoutes.rejected,
      'verified'         => AppRoutes.home,
      _                  => AppRoutes.login,
    };

/// Landing page for each user status.
String _defaultForUserStatus(String status) => switch (status) {
      'needs_onboarding' => AppRoutes.userOnboarding,
      'active'           => AppRoutes.userHome,
      _                  => AppRoutes.userHome,
    };

/// Routes that are exclusively tied to a specific therapist status.
bool _isStatusLockedRoute(String location) =>
    location == AppRoutes.onboarding ||
    location == AppRoutes.pending    ||
    location == AppRoutes.rejected;

/// Therapist-only authenticated pages (verified therapists can freely navigate).
bool _isFreeAuthRoute(String location) =>
    location == AppRoutes.home    ||
    location == AppRoutes.profile ||
    location.startsWith(AppRoutes.blog);

/// All therapist-specific routes (to block user accounts from accessing).
bool _isTherapistRoute(String location) =>
    location == AppRoutes.onboarding   ||
    location == AppRoutes.pending      ||
    location == AppRoutes.rejected     ||
    location == AppRoutes.home         ||
    location == AppRoutes.profile      ||
    location.startsWith(AppRoutes.blog);

// ─────────────────────────────────────────────────────────────────────────────
// User home placeholder — shown after user onboarding until a full home is built
// ─────────────────────────────────────────────────────────────────────────────

class _UserHomePlaceholder extends StatelessWidget {
  const _UserHomePlaceholder();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Find a Therapist')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.search, size: 64,
                color: theme.colorScheme.primary),
            const SizedBox(height: 16),
            Text('Therapist discovery coming soon!',
                style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            Text('We\'re building the therapist search experience.',
                style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant)),
          ],
        ),
      ),
    );
  }
}

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
