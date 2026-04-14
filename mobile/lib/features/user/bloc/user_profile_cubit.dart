import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:therapist/core/di/injection.dart';
import 'package:therapist/features/user/data/user_repository.dart';

/// Holds the authenticated user's profile so any widget can read
/// state/nation without another async call.
class UserProfileCubit extends Cubit<UserModel?> {
  UserProfileCubit() : super(null);

  final _repo = sl<UserRepository>();

  Future<void> load(String userId) async {
    if (userId.isEmpty) return;
    final result = await _repo.getProfile(userId: userId);
    result.fold((_) {}, (profile) => emit(profile));
  }

  UserModel? get profile => state;
}
