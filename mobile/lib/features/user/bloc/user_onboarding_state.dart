part of 'user_onboarding_bloc.dart';

abstract class UserOnboardingState extends Equatable {
  const UserOnboardingState();
  @override
  List<Object?> get props => [];
}

class UserOnboardingInitial extends UserOnboardingState {
  const UserOnboardingInitial();
}

class UserOnboardingSubmitting extends UserOnboardingState {
  const UserOnboardingSubmitting();
}

class UserOnboardingSuccess extends UserOnboardingState {
  const UserOnboardingSuccess();
}

class UserOnboardingFailure extends UserOnboardingState {
  const UserOnboardingFailure(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
