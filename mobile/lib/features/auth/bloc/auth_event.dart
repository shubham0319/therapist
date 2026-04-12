part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

class AuthStarted extends AuthEvent {
  const AuthStarted();
}

class AuthGoogleSignInRequested extends AuthEvent {
  const AuthGoogleSignInRequested();
}

class AuthEmailOtpRequested extends AuthEvent {
  const AuthEmailOtpRequested({required this.email});
  final String email;
  @override
  List<Object?> get props => [email];
}

class AuthPhoneOtpRequested extends AuthEvent {
  const AuthPhoneOtpRequested({required this.phone});
  final String phone;
  @override
  List<Object?> get props => [phone];
}

class AuthOtpVerified extends AuthEvent {
  const AuthOtpVerified({
    required this.contact,
    required this.otp,
    required this.isEmail,
    this.accountType = 'therapist',
  });
  final String contact;
  final String otp;
  final bool isEmail;
  /// 'therapist' | 'user'
  final String accountType;
  @override
  List<Object?> get props => [contact, otp, isEmail, accountType];
}

class AuthSignOutRequested extends AuthEvent {
  const AuthSignOutRequested();
}
