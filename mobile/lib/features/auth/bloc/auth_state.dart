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
  const AuthAuthenticated({
    required this.therapistId,
    required this.status,
    required this.accessToken,
    required this.refreshToken,
    this.accountType = 'therapist',
    this.userId = '',
  });

  /// 'therapist' | 'user'
  final String accountType;
  /// Non-empty when accountType == 'therapist'
  final String therapistId;
  /// Non-empty when accountType == 'user'
  final String userId;
  final String status;
  final String accessToken;
  final String refreshToken;

  bool get isTherapist => accountType == 'therapist';
  bool get isUser      => accountType == 'user';

  @override
  List<Object?> get props => [accountType, therapistId, userId, status];
}

class AuthError extends AuthState {
  const AuthError(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
