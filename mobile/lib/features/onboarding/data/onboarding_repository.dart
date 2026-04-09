import 'dart:typed_data';

import 'package:therapist/core/error/failures.dart';
import 'package:therapist/core/error/result.dart';
import 'package:therapist/core/network/grpc_client.dart';
import 'package:therapist/core/proto/therapist.pbgrpc.dart';

class OnboardingFormData {
  const OnboardingFormData({
    this.fullName = '',
    this.phone = '',
    this.gender = '',
    this.bio = '',
    this.specializations = const [],
    this.languages = const [],
    this.yearsOfExperience = 0,
    this.sessionTypes = const [],
    this.sessionFee = '',
    this.registrationNumber = '',
    this.issuingBody = '',
    this.profilePhotoBytes,
    this.profilePhotoName,
    this.degreeCertBytes,
    this.degreeCertName,
    this.govIdBytes,
    this.govIdName,
  });

  final String fullName;
  final String phone;
  final String gender;
  final String bio;
  final List<String> specializations;
  final List<String> languages;
  final int yearsOfExperience;
  final List<String> sessionTypes;
  final String sessionFee;
  final String registrationNumber;
  final String issuingBody;
  final Uint8List? profilePhotoBytes;
  final String? profilePhotoName;
  final Uint8List? degreeCertBytes;
  final String? degreeCertName;
  final Uint8List? govIdBytes;
  final String? govIdName;

  OnboardingFormData copyWith({
    String? fullName,
    String? phone,
    String? gender,
    String? bio,
    List<String>? specializations,
    List<String>? languages,
    int? yearsOfExperience,
    List<String>? sessionTypes,
    String? sessionFee,
    String? registrationNumber,
    String? issuingBody,
    Uint8List? profilePhotoBytes,
    String? profilePhotoName,
    Uint8List? degreeCertBytes,
    String? degreeCertName,
    Uint8List? govIdBytes,
    String? govIdName,
  }) {
    return OnboardingFormData(
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      gender: gender ?? this.gender,
      bio: bio ?? this.bio,
      specializations: specializations ?? this.specializations,
      languages: languages ?? this.languages,
      yearsOfExperience: yearsOfExperience ?? this.yearsOfExperience,
      sessionTypes: sessionTypes ?? this.sessionTypes,
      sessionFee: sessionFee ?? this.sessionFee,
      registrationNumber: registrationNumber ?? this.registrationNumber,
      issuingBody: issuingBody ?? this.issuingBody,
      profilePhotoBytes: profilePhotoBytes ?? this.profilePhotoBytes,
      profilePhotoName: profilePhotoName ?? this.profilePhotoName,
      degreeCertBytes: degreeCertBytes ?? this.degreeCertBytes,
      degreeCertName: degreeCertName ?? this.degreeCertName,
      govIdBytes: govIdBytes ?? this.govIdBytes,
      govIdName: govIdName ?? this.govIdName,
    );
  }
}

class OnboardingRepository {
  OnboardingRepository({required GrpcClient grpc}) : _grpc = grpc;

  final GrpcClient _grpc;

  TherapistServiceClient get _stub => TherapistServiceClient(_grpc.channel);

  /// Upload a single file to the backend and return the storage URL.
  Future<Result<String>> uploadFile({
    required String fileName,
    required String fileType,
    required Uint8List bytes,
  }) async {
    try {
      final res = await _stub.uploadFile(
        UploadFileRequest()
          ..fileName = fileName
          ..fileType = fileType
          ..data = bytes,
      );
      return Result.success(res.url);
    } catch (e) {
      return Result.error(ServerFailure(e.toString()));
    }
  }

  /// Upload all documents then submit the onboarding form via gRPC.
  Future<Result<void>> submitOnboarding({
    required String therapistId,
    required OnboardingFormData data,
  }) async {
    try {
      if (data.degreeCertBytes == null) {
        return Result.error(const ValidationFailure('Degree certificate is required'));
      }

      // 1. Upload degree certificate (required)
      final certResult = await uploadFile(
        fileName: data.degreeCertName!,
        fileType: 'degree_certificate',
        bytes: data.degreeCertBytes!,
      );
      late String certUrl;
      certResult.fold((f) => throw Exception(f.message), (url) => certUrl = url);

      // 2. Upload profile photo (optional)
      String profilePhotoUrl = '';
      if (data.profilePhotoBytes != null) {
        final r = await uploadFile(
          fileName: data.profilePhotoName!,
          fileType: 'profile_photo',
          bytes: data.profilePhotoBytes!,
        );
        r.fold((f) => throw Exception(f.message), (url) => profilePhotoUrl = url);
      }

      // 3. Upload government ID (optional)
      String govIdUrl = '';
      if (data.govIdBytes != null) {
        final r = await uploadFile(
          fileName: data.govIdName!,
          fileType: 'government_id',
          bytes: data.govIdBytes!,
        );
        r.fold((f) => throw Exception(f.message), (url) => govIdUrl = url);
      }

      // 4. Submit onboarding
      await _stub.completeOnboarding(
        CompleteOnboardingRequest()
          ..therapistId = therapistId
          ..fullName = data.fullName
          ..languagesSpoken.addAll(data.languages)
          ..specializations.addAll(data.specializations)
          ..yearsOfExperience = data.yearsOfExperience
          ..sessionFee = data.sessionFee
          ..sessionTypes.addAll(data.sessionTypes)
          ..degreeCertificate = certUrl
          ..registrationNumber = data.registrationNumber
          ..issuingBody = data.issuingBody
          ..gender = data.gender
          ..bio = data.bio
          ..profilePhoto = profilePhotoUrl
          ..phoneNumber = data.phone
          ..governmentId = govIdUrl,
      );

      return Result.success(null);
    } on Exception catch (e) {
      return Result.error(ServerFailure(e.toString()));
    } catch (e) {
      return Result.error(UnexpectedFailure(e.toString()));
    }
  }
}
