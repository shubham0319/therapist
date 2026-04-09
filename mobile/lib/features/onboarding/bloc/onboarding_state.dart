part of 'onboarding_bloc.dart';

sealed class OnboardingState extends Equatable {
  const OnboardingState();
  @override
  List<Object?> get props => [];
}

class OnboardingInitial extends OnboardingState {
  const OnboardingInitial();
}

class OnboardingSubmitting extends OnboardingState {
  const OnboardingSubmitting();
}

class OnboardingSuccess extends OnboardingState {
  const OnboardingSuccess();
}

class OnboardingFailure extends OnboardingState {
  const OnboardingFailure(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}