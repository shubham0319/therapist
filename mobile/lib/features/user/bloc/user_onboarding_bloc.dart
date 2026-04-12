import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:therapist/core/di/injection.dart';
import 'package:therapist/features/user/data/user_repository.dart';

part 'user_onboarding_event.dart';
part 'user_onboarding_state.dart';

class UserOnboardingBloc
    extends Bloc<UserOnboardingEvent, UserOnboardingState> {
  UserOnboardingBloc() : super(const UserOnboardingInitial()) {
    on<UserOnboardingSubmitted>(_onSubmit);
  }

  final _repo = sl<UserRepository>();

  Future<void> _onSubmit(
    UserOnboardingSubmitted e,
    Emitter<UserOnboardingState> emit,
  ) async {
    emit(const UserOnboardingSubmitting());

    final result = await _repo.completeOnboarding(
      userId:     e.userId,
      name:       e.name,
      phone:      e.phone,
      state:      e.state,
      nation:     e.nation,
      lookingFor: e.lookingFor,
    );

    result.fold(
      (failure) => emit(UserOnboardingFailure(failure.message)),
      (_) => emit(const UserOnboardingSuccess()),
    );
  }
}
