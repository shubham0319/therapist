import 'package:get_it/get_it.dart';
import 'package:therapist/core/config/env.dart';
import 'package:therapist/core/network/grpc_client.dart';
import 'package:therapist/features/auth/bloc/auth_bloc.dart';
import 'package:therapist/features/auth/data/auth_repository.dart';
import 'package:therapist/features/onboarding/bloc/onboarding_bloc.dart';
import 'package:therapist/features/onboarding/data/onboarding_repository.dart';

final sl = GetIt.instance;

/// Call once in main() after Env.load().
Future<void> configureDependencies() async {
  // ── Supabase (paused for testing) ─────────────────────────────────────────
  // TODO: uncomment when auth is ready
  // await Supabase.initialize(url: Env.supabaseUrl, anonKey: Env.supabaseAnonKey);
  // sl.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);

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
    () => AuthRepository(grpc: sl()),
  );
  sl.registerLazySingleton<OnboardingRepository>(
    () => OnboardingRepository(grpc: sl()),
  );

  // ── BLoCs (registered as factories so each creation gets a fresh instance)
  sl.registerFactory<AuthBloc>(() => AuthBloc());
  sl.registerFactory<OnboardingBloc>(() => OnboardingBloc());
}
