part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

class AuthOtpSent extends AuthState {
  const AuthOtpSent({required this.contact});
  final String contact;
  @override
  List<Object?> get props => [contact];
}

class AuthAuthenticated extends AuthState {
  const AuthAuthenticated({required this.therapistId, required this.status});
  final String therapistId;
  // "needs_onboarding" | "pending" | "verified" | "rejected"
  final String status;
  @override
  List<Object?> get props => [therapistId, status];
}

class AuthError extends AuthState {
  const AuthError(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
