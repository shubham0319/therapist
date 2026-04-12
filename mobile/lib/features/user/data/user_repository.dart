import 'package:grpc/service_api.dart';
import 'package:therapist/core/error/failures.dart';
import 'package:therapist/core/error/result.dart';
import 'package:therapist/core/network/grpc_client.dart';
import 'package:therapist/core/proto/therapist.pbgrpc.dart';

const _kRpcTimeout = Duration(seconds: 15);

/// Lightweight model for the authenticated user (client/patient).
class UserModel {
  const UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
    required this.state,
    required this.nation,
    required this.lookingFor,
    required this.onboardingCompleted,
  });

  final String id;
  final String email;
  final String name;
  final String phone;
  final String state;
  final String nation;
  final List<String> lookingFor;
  final bool onboardingCompleted;

  static UserModel fromProto(User pb) => UserModel(
        id:                  pb.id,
        email:               pb.email,
        name:                pb.name,
        phone:               pb.phone,
        state:               pb.state,
        nation:              pb.nation,
        lookingFor:          List.unmodifiable(pb.lookingFor),
        onboardingCompleted: pb.onboardingCompleted,
      );
}

class UserRepository {
  UserRepository({required GrpcClient grpc}) : _grpc = grpc;

  final GrpcClient _grpc;

  TherapistServiceClient get _stub => TherapistServiceClient(_grpc.channel);

  // ── Complete onboarding ───────────────────────────────────────────────────

  Future<Result<void>> completeOnboarding({
    required String userId,
    required String name,
    String phone = '',
    String state = '',
    String nation = '',
    List<String> lookingFor = const [],
  }) async {
    try {
      await _stub.completeUserOnboarding(
        CompleteUserOnboardingRequest()
          ..userId = userId
          ..name = name
          ..phone = phone
          ..state = state
          ..nation = nation
          ..lookingFor.addAll(lookingFor),
        options: CallOptions(timeout: _kRpcTimeout),
      );
      return Result.success(null);
    } catch (e) {
      return Result.error(ServerFailure(e.toString()));
    }
  }

  // ── Get profile ───────────────────────────────────────────────────────────

  Future<Result<UserModel>> getProfile({required String userId}) async {
    try {
      final res = await _stub.getUserProfile(
        GetUserProfileRequest()..userId = userId,
        options: CallOptions(timeout: _kRpcTimeout),
      );
      return Result.success(UserModel.fromProto(res.user));
    } catch (e) {
      return Result.error(ServerFailure(e.toString()));
    }
  }
}
