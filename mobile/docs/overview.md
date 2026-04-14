# Mobile App — Overview

## Tech Stack
- Flutter (Dart) · BLoC pattern · GoRouter · GetIt DI
- gRPC-Web (port 8080, web) / native gRPC (port 50051, mobile)
- Protobuf stubs auto-generated via `make proto` from `proto/therapist.proto`
- Secure storage via `flutter_secure_storage`

## Accounts
Two account types share the same login screen:
- **Therapist** — onboards, gets verified, publishes blogs
- **User (client)** — onboards, searches/discovers therapists

---

## Auth Flow

```
LoginPage
  ├── Toggle: Therapist | Looking for help
  ├── Google (stub)
  └── Email OTP (dev bypass: any email + OTP 123456)
        ↓
  AuthBloc.verifyOtp(accountType)
        ↓
  AuthCallback RPC  →  TherapistSession  →  GoRouter redirect
  UserAuthCallback  →  TherapistSession  →  GoRouter redirect
```

**Session storage** (`SessionStore`):
- Keys: `account_type`, `entity_id`, `status`, `access_token`, `refresh_token`, `expires_at`
- `isTherapist` / `isUser` helpers on `StoredSession`

**Token refresh** (silent, on app start):
- Therapist → `RefreshSession` RPC
- User      → `UserRefreshSession` RPC

---

## Router (`core/router/app_router.dart`)

| Route | Who | Condition |
|---|---|---|
| `/login` | All | Unauthenticated |
| `/onboarding` | Therapist | status = needs_onboarding |
| `/pending` | Therapist | status = pending |
| `/rejected` | Therapist | status = rejected |
| `/home` | Therapist | status = verified |
| `/blog` `/blog/detail` `/blog/create` `/blog/edit` | Therapist | verified |
| `/user/onboarding` | User | status = needs_onboarding |
| `/user/home` | User | status = active |
| `/user/therapist` | User | tap on card |

Redirect logic: `_redirect()` checks `AuthAuthenticated.accountType` and `status`, blocks cross-account routes.

---

## DI (`core/di/injection.dart`)

Singletons: `SessionStore`, `GrpcClient`, `AuthRepository`, `OnboardingRepository`, `BlogRepository`, `UserRepository`, `DiscoveryRepository`

Factories (fresh per use): `AuthBloc`, `OnboardingBloc`, `BlogBloc`, `UserOnboardingBloc`, `DiscoveryBloc`, `UserProfileCubit`
