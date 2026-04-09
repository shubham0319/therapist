import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:therapist/core/di/injection.dart';
import 'package:therapist/features/onboarding/data/onboarding_repository.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc() : super(const OnboardingInitial()) {
    on<OnboardingSubmitted>(_onSubmit);
  }

  final _repo = sl<OnboardingRepository>();

  Future<void> _onSubmit(
      OnboardingSubmitted e, Emitter<OnboardingState> emit) async {
    emit(const OnboardingSubmitting());

    final result = await _repo.submitOnboarding(
      therapistId: e.therapistId,
      data: e.data,
    );

    result.fold(
      (failure) => emit(OnboardingFailure(failure.message)),
      (_) => emit(const OnboardingSuccess()),
    );
  }
}