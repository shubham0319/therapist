part of 'user_onboarding_bloc.dart';

abstract class UserOnboardingEvent extends Equatable {
  const UserOnboardingEvent();
  @override
  List<Object?> get props => [];
}

class UserOnboardingSubmitted extends UserOnboardingEvent {
  const UserOnboardingSubmitted({
    required this.userId,
    required this.name,
    this.phone = '',
    this.state = '',
    this.nation = '',
    this.lookingFor = const [],
  });

  final String userId;
  final String name;
  final String phone;
  final String state;
  final String nation;
  final List<String> lookingFor;

  @override
  List<Object?> get props => [userId, name, phone, state, nation, lookingFor];
}
