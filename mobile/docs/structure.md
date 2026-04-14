# Mobile — File Structure

```
lib/
├── app.dart                        # MaterialApp.router + AuthBloc at root
├── main.dart                       # Boot: Env.load → configureDependencies → runApp
│
├── core/
│   ├── config/env.dart             # Env vars (grpcHost, grpcPort, supabaseUrl…)
│   ├── di/injection.dart           # GetIt wiring (sl<T>())
│   ├── error/
│   │   ├── failures.dart           # AuthFailure, ServerFailure, etc.
│   │   └── result.dart             # Result<T> = success(T) | error(Failure)
│   ├── network/grpc_client.dart    # ClientChannel (native gRPC / gRPC-Web)
│   ├── proto/                      # Generated: therapist.pb.dart + .pbgrpc.dart
│   ├── router/app_router.dart      # GoRouter, routes, redirect logic
│   ├── session/session_store.dart  # SecureStorage wrapper + StoredSession
│   └── theme/app_theme.dart        # AppTheme.light/dark + AppColors
│
├── features/
│   ├── auth/
│   │   ├── bloc/                   # AuthBloc, AuthEvent, AuthState
│   │   ├── data/auth_repository.dart
│   │   └── presentation/login_page.dart
│   │
│   ├── onboarding/                 # Therapist onboarding (multi-step form)
│   │   ├── bloc/
│   │   ├── data/onboarding_repository.dart
│   │   └── presentation/onboarding_page.dart
│   │
│   ├── status/
│   │   └── presentation/           # pending_page.dart, rejected_page.dart
│   │
│   ├── home/                       # Therapist home (verified)
│   │   ├── bloc/
│   │   └── presentation/home_page.dart
│   │
│   ├── blog/
│   │   ├── bloc/                   # BlogBloc, BlogEvent, BlogState
│   │   ├── data/blog_repository.dart   # BlogModel + all CRUD RPCs
│   │   └── presentation/
│   │       ├── blog_list_page.dart
│   │       ├── blog_detail_page.dart
│   │       └── create_blog_page.dart
│   │
│   ├── user/                       # Client/patient account
│   │   ├── bloc/
│   │   │   ├── user_onboarding_bloc.dart
│   │   │   └── user_profile_cubit.dart   # Caches profile (state/nation) for discovery
│   │   ├── data/
│   │   │   ├── user_repository.dart      # completeOnboarding, getProfile
│   │   │   └── looking_for_options.dart  # 30 mental-health categories
│   │   └── presentation/
│   │       ├── user_onboarding_page.dart
│   │       └── user_home_page.dart       # Search + recommendations UI
│   │
│   └── discovery/                  # Therapist discovery (user-facing)
│       ├── bloc/                   # DiscoveryBloc, DiscoveryEvent, DiscoveryState
│       ├── data/discovery_repository.dart  # TherapistCardModel, SearchResult
│       └── presentation/
│           └── therapist_profile_page.dart
│
└── shared/
    ├── widgets/
    │   ├── app_button.dart
    │   ├── app_text_field.dart
    │   └── scaffold_with_nav.dart  # Bottom nav shell (therapist)
    ├── constants/
    └── utils/
```
