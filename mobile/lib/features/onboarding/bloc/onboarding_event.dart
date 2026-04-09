part of 'onboarding_bloc.dart';

sealed class OnboardingEvent extends Equatable {
  const OnboardingEvent();
  @override
  List<Object?> get props => [];
}

class OnboardingSubmitted extends OnboardingEvent {
  const OnboardingSubmitted({
    required this.therapistId,
    required this.data,
  });
  final String therapistId;
  final OnboardingFormData data;
  @override
  List<Object?> get props => [therapistId];
}