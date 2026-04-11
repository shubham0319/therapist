import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:therapist/core/di/injection.dart';
import 'package:therapist/features/auth/data/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthInitial()) {
    on<AuthStarted>(_onStarted);
    on<AuthGoogleSignInRequested>(_onGoogleSignIn);
    on<AuthEmailOtpRequested>(_onEmailOtp);
    on<AuthOtpVerified>(_onOtpVerified);
    on<AuthSignOutRequested>(_onSignOut);
  }

  final _repo = sl<AuthRepository>();

  Future<void> _onStarted(AuthStarted event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    final result = await _repo.getCurrentSession();
    result.fold(
      (_) => emit(const AuthUnauthenticated()),
      (session) => emit(AuthAuthenticated(
        therapistId:  session.therapistId,
        status:       session.status,
        accessToken:  session.accessToken,
        refreshToken: session.refreshToken,
      )),
    );
  }

  Future<void> _onGoogleSignIn(
      AuthGoogleSignInRequested event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    final result = await _repo.signInWithGoogle();
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (session) => emit(AuthAuthenticated(
        therapistId:  session.therapistId,
        status:       session.status,
        accessToken:  session.accessToken,
        refreshToken: session.refreshToken,
      )),
    );
  }

  Future<void> _onEmailOtp(
      AuthEmailOtpRequested event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    final result = await _repo.sendEmailOtp(event.email);
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(AuthOtpSent(contact: event.email)),
    );
  }

  Future<void> _onOtpVerified(
      AuthOtpVerified event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    final result = await _repo.verifyOtp(
      contact: event.contact,
      otp: event.otp,
      isEmail: event.isEmail,
    );
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (session) => emit(AuthAuthenticated(
        therapistId:  session.therapistId,
        status:       session.status,
        accessToken:  session.accessToken,
        refreshToken: session.refreshToken,
      )),
    );
  }

  Future<void> _onSignOut(
      AuthSignOutRequested event, Emitter<AuthState> emit) async {
    final refreshToken = state is AuthAuthenticated
        ? (state as AuthAuthenticated).refreshToken
        : '';
    await _repo.signOut(refreshToken);
    emit(const AuthUnauthenticated());
  }
}
