import 'package:therapist/core/error/failures.dart';

/// Lightweight result type used by all repositories.
/// Avoids adding the `dartz` package for a single Either type.
class Result<T> {
  const Result._({this.failure, this.value});

  factory Result.success(T value) => Result._(value: value);
  factory Result.error(Failure failure) => Result._(failure: failure);

  final Failure? failure;
  final T? value;

  bool get isSuccess => failure == null;

  void fold(
    void Function(Failure) onError,
    void Function(T) onSuccess,
  ) {
    if (failure != null) {
      onError(failure!);
    } else {
      onSuccess(value as T);
    }
  }
}
