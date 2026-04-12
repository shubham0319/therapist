import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:therapist/core/config/env.dart';
import 'package:therapist/core/network/grpc_client.dart';
import 'package:therapist/core/session/session_store.dart';
import 'package:therapist/features/auth/bloc/auth_bloc.dart';
import 'package:therapist/features/auth/data/auth_repository.dart';
import 'package:therapist/features/blog/bloc/blog_bloc.dart';
import 'package:therapist/features/blog/data/blog_repository.dart';
import 'package:therapist/features/onboarding/bloc/onboarding_bloc.dart';
import 'package:therapist/features/onboarding/data/onboarding_repository.dart';
import 'package:therapist/features/user/bloc/user_onboarding_bloc.dart';
import 'package:therapist/features/user/data/user_repository.dart';

final sl = GetIt.instance;

/// Call once in main() after Env.load().
Future<void> configureDependencies() async {
  // ── Secure storage ────────────────────────────────────────────────────────
  const storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );
  sl.registerLazySingleton<SessionStore>(() => const SessionStore(storage));

  // ── gRPC ──────────────────────────────────────────────────────────────────
  sl.registerLazySingleton<GrpcClient>(
    () => GrpcClient(
      host: Env.grpcHost,
      port: Env.grpcPort,
      webPort: Env.grpcWebPort,
    ),
  );

  // ── Repositories ──────────────────────────────────────────────────────────
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepository(grpc: sl(), store: sl()),
  );
  sl.registerLazySingleton<OnboardingRepository>(
    () => OnboardingRepository(grpc: sl()),
  );
  sl.registerLazySingleton<BlogRepository>(
    () => BlogRepository(grpc: sl()),
  );
  sl.registerLazySingleton<UserRepository>(
    () => UserRepository(grpc: sl()),
  );

  // ── BLoCs (registered as factories so each creation gets a fresh instance)
  sl.registerFactory<AuthBloc>(() => AuthBloc());
  sl.registerFactory<OnboardingBloc>(() => OnboardingBloc());
  sl.registerFactory<BlogBloc>(() => BlogBloc());
  sl.registerFactory<UserOnboardingBloc>(() => UserOnboardingBloc());
}
