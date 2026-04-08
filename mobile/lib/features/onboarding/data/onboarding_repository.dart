import 'package:therapist/core/error/failures.dart';
import 'package:therapist/core/network/grpc_client.dart';

class OnboardingData {
  const OnboardingData({
    required this.fullName,
    required this.languagesSpoken,
    required this.specializations,
    required this.yearsOfExperience,
    required this.sessionFee,
    required this.sessionTypes,
    required this.degreeCertificateUrl,
    required this.registrationNumber,
    required this.issuingBody,
    this.gender,
    this.bio,
    this.profilePhotoUrl,
    this.phoneNumber,
    this.governmentIdUrl,
  });

  final String fullName;
  final List<String> languagesSpoken;
  final List<String> specializations;
  final int yearsOfExperience;
  final String sessionFee;
  final List<String> sessionTypes; // "chat" | "audio" | "video"
  final String degreeCertificateUrl;
  final String registrationNumber;
  final String issuingBody;
  final String? gender;
  final String? bio;
  final String? profilePhotoUrl;
  final String? phoneNumber;
  final String? governmentIdUrl;
}

class OnboardingRepository {
  OnboardingRepository({required GrpcClient grpc}) : _grpc = grpc;

  final GrpcClient _grpc;

  Future<({Failure? failure, void value})> submitOnboarding({
    required String therapistId,
    required OnboardingData data,
  }) async {
    try {
      // TODO: wire up generated gRPC stub
      // final stub = TherapistServiceClient(_grpc.channel);
      // await stub.completeOnboarding(CompleteOnboardingRequest(...));
      return (failure: null, value: null);
    } catch (e) {
      return (failure: ServerFailure(e.toString()), value: null);
    }
  }
}
