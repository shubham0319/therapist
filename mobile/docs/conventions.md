# Conventions

## Pattern: Feature Structure
Every feature follows:
```
feature/
  bloc/         BLoC + event + state (parts)
  data/         Repository + Model classes
  presentation/ Pages / widgets
```

## Pattern: Repository
- Returns `Result<T>` (never throws)
- All gRPC calls use `CallOptions(timeout: Duration(seconds: 15))`
- Model has `static T fromProto(PbType pb)` factory

## Pattern: BLoC
- Registered as `factory` in DI (fresh instance per route)
- Events are immutable plain classes
- States are sealed/abstract classes
- Repository accessed via `sl<Repository>()`

## Pattern: Reading Auth State
Always synchronous:
```dart
final state = context.read<AuthBloc>().state as AuthAuthenticated;
final therapistId = state.therapistId;
final userId = state.userId;
```
Never read from `SessionStore` async inside a BLoC.

## Pattern: Navigation
```dart
context.go(AppRoutes.xxx)          // replace stack
context.push(AppRoutes.xxx, extra: model)  // push with data
```
Extra is typed and cast in `pageBuilder`:
```dart
final card = state.extra as TherapistCardModel;
```

## Pattern: gRPC per-call timeout
Every stub call must have:
```dart
options: CallOptions(timeout: _kRpcTimeout)
```
Missing timeout = spinner hangs forever on network loss.

## Adding a New Feature
1. Add RPC + messages to `proto/therapist.proto`
2. Run `make proto` (regenerates Go + Dart stubs)
3. Add Go: `schema/gen/xxx.sql.go` → `db/xxx.go` → `service/xxx.go` → `handler/xxx.go`
4. Add interface methods to `service/facade.go` + `handler/facade.go`
5. Add Dart: `repository` → `bloc` → `presentation`
6. Register in `core/di/injection.dart`
7. Add route in `core/router/app_router.dart`
8. Run `go build ./...` + `flutter analyze --no-fatal-infos`
