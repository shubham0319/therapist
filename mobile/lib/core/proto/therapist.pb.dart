// This is a generated file - do not edit.
//
// Generated from proto/therapist.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class AuthCallbackRequest extends $pb.GeneratedMessage {
  factory AuthCallbackRequest({
    $core.String? supabaseToken,
  }) {
    final result = create();
    if (supabaseToken != null) result.supabaseToken = supabaseToken;
    return result;
  }

  AuthCallbackRequest._();

  factory AuthCallbackRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AuthCallbackRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AuthCallbackRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'therapist'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'supabaseToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AuthCallbackRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AuthCallbackRequest copyWith(void Function(AuthCallbackRequest) updates) =>
      super.copyWith((message) => updates(message as AuthCallbackRequest))
          as AuthCallbackRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AuthCallbackRequest create() => AuthCallbackRequest._();
  @$core.override
  AuthCallbackRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AuthCallbackRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AuthCallbackRequest>(create);
  static AuthCallbackRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get supabaseToken => $_getSZ(0);
  @$pb.TagNumber(1)
  set supabaseToken($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSupabaseToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearSupabaseToken() => $_clearField(1);
}

class AuthCallbackResponse extends $pb.GeneratedMessage {
  factory AuthCallbackResponse({
    $core.String? therapistId,
    $core.String? status,
    $core.bool? onboardingCompleted,
    $core.String? referralId,
    $core.String? rejectionReason,
    $core.String? accessToken,
    $core.String? refreshToken,
    $fixnum.Int64? expiresAt,
  }) {
    final result = create();
    if (therapistId != null) result.therapistId = therapistId;
    if (status != null) result.status = status;
    if (onboardingCompleted != null)
      result.onboardingCompleted = onboardingCompleted;
    if (referralId != null) result.referralId = referralId;
    if (rejectionReason != null) result.rejectionReason = rejectionReason;
    if (accessToken != null) result.accessToken = accessToken;
    if (refreshToken != null) result.refreshToken = refreshToken;
    if (expiresAt != null) result.expiresAt = expiresAt;
    return result;
  }

  AuthCallbackResponse._();

  factory AuthCallbackResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AuthCallbackResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AuthCallbackResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'therapist'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'therapistId')
    ..aOS(2, _omitFieldNames ? '' : 'status')
    ..aOB(3, _omitFieldNames ? '' : 'onboardingCompleted')
    ..aOS(4, _omitFieldNames ? '' : 'referralId')
    ..aOS(5, _omitFieldNames ? '' : 'rejectionReason')
    ..aOS(6, _omitFieldNames ? '' : 'accessToken')
    ..aOS(7, _omitFieldNames ? '' : 'refreshToken')
    ..aInt64(8, _omitFieldNames ? '' : 'expiresAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AuthCallbackResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AuthCallbackResponse copyWith(void Function(AuthCallbackResponse) updates) =>
      super.copyWith((message) => updates(message as AuthCallbackResponse))
          as AuthCallbackResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AuthCallbackResponse create() => AuthCallbackResponse._();
  @$core.override
  AuthCallbackResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AuthCallbackResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AuthCallbackResponse>(create);
  static AuthCallbackResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get therapistId => $_getSZ(0);
  @$pb.TagNumber(1)
  set therapistId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTherapistId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTherapistId() => $_clearField(1);

  /// "needs_onboarding" | "pending" | "verified" | "rejected"
  @$pb.TagNumber(2)
  $core.String get status => $_getSZ(1);
  @$pb.TagNumber(2)
  set status($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get onboardingCompleted => $_getBF(2);
  @$pb.TagNumber(3)
  set onboardingCompleted($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasOnboardingCompleted() => $_has(2);
  @$pb.TagNumber(3)
  void clearOnboardingCompleted() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get referralId => $_getSZ(3);
  @$pb.TagNumber(4)
  set referralId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasReferralId() => $_has(3);
  @$pb.TagNumber(4)
  void clearReferralId() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get rejectionReason => $_getSZ(4);
  @$pb.TagNumber(5)
  set rejectionReason($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasRejectionReason() => $_has(4);
  @$pb.TagNumber(5)
  void clearRejectionReason() => $_clearField(5);

  /// Session tokens
  @$pb.TagNumber(6)
  $core.String get accessToken => $_getSZ(5);
  @$pb.TagNumber(6)
  set accessToken($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasAccessToken() => $_has(5);
  @$pb.TagNumber(6)
  void clearAccessToken() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get refreshToken => $_getSZ(6);
  @$pb.TagNumber(7)
  set refreshToken($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasRefreshToken() => $_has(6);
  @$pb.TagNumber(7)
  void clearRefreshToken() => $_clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get expiresAt => $_getI64(7);
  @$pb.TagNumber(8)
  set expiresAt($fixnum.Int64 value) => $_setInt64(7, value);
  @$pb.TagNumber(8)
  $core.bool hasExpiresAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearExpiresAt() => $_clearField(8);
}

class GetStatusRequest extends $pb.GeneratedMessage {
  factory GetStatusRequest({
    $core.String? supabaseToken,
  }) {
    final result = create();
    if (supabaseToken != null) result.supabaseToken = supabaseToken;
    return result;
  }

  GetStatusRequest._();

  factory GetStatusRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetStatusRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetStatusRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'therapist'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'supabaseToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetStatusRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetStatusRequest copyWith(void Function(GetStatusRequest) updates) =>
      super.copyWith((message) => updates(message as GetStatusRequest))
          as GetStatusRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetStatusRequest create() => GetStatusRequest._();
  @$core.override
  GetStatusRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetStatusRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetStatusRequest>(create);
  static GetStatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get supabaseToken => $_getSZ(0);
  @$pb.TagNumber(1)
  set supabaseToken($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSupabaseToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearSupabaseToken() => $_clearField(1);
}

class GetStatusResponse extends $pb.GeneratedMessage {
  factory GetStatusResponse({
    $core.String? therapistId,
    $core.String? status,
    $core.bool? onboardingCompleted,
    $core.String? referralId,
    $core.String? rejectionReason,
  }) {
    final result = create();
    if (therapistId != null) result.therapistId = therapistId;
    if (status != null) result.status = status;
    if (onboardingCompleted != null)
      result.onboardingCompleted = onboardingCompleted;
    if (referralId != null) result.referralId = referralId;
    if (rejectionReason != null) result.rejectionReason = rejectionReason;
    return result;
  }

  GetStatusResponse._();

  factory GetStatusResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetStatusResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetStatusResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'therapist'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'therapistId')
    ..aOS(2, _omitFieldNames ? '' : 'status')
    ..aOB(3, _omitFieldNames ? '' : 'onboardingCompleted')
    ..aOS(4, _omitFieldNames ? '' : 'referralId')
    ..aOS(5, _omitFieldNames ? '' : 'rejectionReason')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetStatusResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetStatusResponse copyWith(void Function(GetStatusResponse) updates) =>
      super.copyWith((message) => updates(message as GetStatusResponse))
          as GetStatusResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetStatusResponse create() => GetStatusResponse._();
  @$core.override
  GetStatusResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetStatusResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetStatusResponse>(create);
  static GetStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get therapistId => $_getSZ(0);
  @$pb.TagNumber(1)
  set therapistId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTherapistId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTherapistId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get status => $_getSZ(1);
  @$pb.TagNumber(2)
  set status($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get onboardingCompleted => $_getBF(2);
  @$pb.TagNumber(3)
  set onboardingCompleted($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasOnboardingCompleted() => $_has(2);
  @$pb.TagNumber(3)
  void clearOnboardingCompleted() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get referralId => $_getSZ(3);
  @$pb.TagNumber(4)
  set referralId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasReferralId() => $_has(3);
  @$pb.TagNumber(4)
  void clearReferralId() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get rejectionReason => $_getSZ(4);
  @$pb.TagNumber(5)
  set rejectionReason($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasRejectionReason() => $_has(4);
  @$pb.TagNumber(5)
  void clearRejectionReason() => $_clearField(5);
}

class CompleteOnboardingRequest extends $pb.GeneratedMessage {
  factory CompleteOnboardingRequest({
    $core.String? therapistId,
    $core.String? fullName,
    $core.Iterable<$core.String>? languagesSpoken,
    $core.Iterable<$core.String>? specializations,
    $core.int? yearsOfExperience,
    $core.String? sessionFee,
    $core.Iterable<$core.String>? sessionTypes,
    $core.String? degreeCertificate,
    $core.String? registrationNumber,
    $core.String? issuingBody,
    $core.String? gender,
    $core.String? bio,
    $core.String? profilePhoto,
    $core.String? phoneNumber,
    $core.String? governmentId,
    $core.String? addressText,
    $core.double? latitude,
    $core.double? longitude,
    $core.String? placeId,
    $core.String? addressState,
    $core.String? addressNation,
  }) {
    final result = create();
    if (therapistId != null) result.therapistId = therapistId;
    if (fullName != null) result.fullName = fullName;
    if (languagesSpoken != null) result.languagesSpoken.addAll(languagesSpoken);
    if (specializations != null) result.specializations.addAll(specializations);
    if (yearsOfExperience != null) result.yearsOfExperience = yearsOfExperience;
    if (sessionFee != null) result.sessionFee = sessionFee;
    if (sessionTypes != null) result.sessionTypes.addAll(sessionTypes);
    if (degreeCertificate != null) result.degreeCertificate = degreeCertificate;
    if (registrationNumber != null)
      result.registrationNumber = registrationNumber;
    if (issuingBody != null) result.issuingBody = issuingBody;
    if (gender != null) result.gender = gender;
    if (bio != null) result.bio = bio;
    if (profilePhoto != null) result.profilePhoto = profilePhoto;
    if (phoneNumber != null) result.phoneNumber = phoneNumber;
    if (governmentId != null) result.governmentId = governmentId;
    if (addressText != null) result.addressText = addressText;
    if (latitude != null) result.latitude = latitude;
    if (longitude != null) result.longitude = longitude;
    if (placeId != null) result.placeId = placeId;
    if (addressState != null) result.addressState = addressState;
    if (addressNation != null) result.addressNation = addressNation;
    return result;
  }

  CompleteOnboardingRequest._();

  factory CompleteOnboardingRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CompleteOnboardingRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CompleteOnboardingRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'therapist'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'therapistId')
    ..aOS(2, _omitFieldNames ? '' : 'fullName')
    ..pPS(3, _omitFieldNames ? '' : 'languagesSpoken')
    ..pPS(4, _omitFieldNames ? '' : 'specializations')
    ..aI(5, _omitFieldNames ? '' : 'yearsOfExperience')
    ..aOS(6, _omitFieldNames ? '' : 'sessionFee')
    ..pPS(7, _omitFieldNames ? '' : 'sessionTypes')
    ..aOS(8, _omitFieldNames ? '' : 'degreeCertificate')
    ..aOS(9, _omitFieldNames ? '' : 'registrationNumber')
    ..aOS(10, _omitFieldNames ? '' : 'issuingBody')
    ..aOS(11, _omitFieldNames ? '' : 'gender')
    ..aOS(12, _omitFieldNames ? '' : 'bio')
    ..aOS(13, _omitFieldNames ? '' : 'profilePhoto')
    ..aOS(14, _omitFieldNames ? '' : 'phoneNumber')
    ..aOS(15, _omitFieldNames ? '' : 'governmentId')
    ..aOS(16, _omitFieldNames ? '' : 'addressText')
    ..aD(17, _omitFieldNames ? '' : 'latitude')
    ..aD(18, _omitFieldNames ? '' : 'longitude')
    ..aOS(19, _omitFieldNames ? '' : 'placeId')
    ..aOS(20, _omitFieldNames ? '' : 'addressState')
    ..aOS(21, _omitFieldNames ? '' : 'addressNation')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CompleteOnboardingRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CompleteOnboardingRequest copyWith(
          void Function(CompleteOnboardingRequest) updates) =>
      super.copyWith((message) => updates(message as CompleteOnboardingRequest))
          as CompleteOnboardingRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CompleteOnboardingRequest create() => CompleteOnboardingRequest._();
  @$core.override
  CompleteOnboardingRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CompleteOnboardingRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CompleteOnboardingRequest>(create);
  static CompleteOnboardingRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get therapistId => $_getSZ(0);
  @$pb.TagNumber(1)
  set therapistId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTherapistId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTherapistId() => $_clearField(1);

  /// Required
  @$pb.TagNumber(2)
  $core.String get fullName => $_getSZ(1);
  @$pb.TagNumber(2)
  set fullName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFullName() => $_has(1);
  @$pb.TagNumber(2)
  void clearFullName() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<$core.String> get languagesSpoken => $_getList(2);

  @$pb.TagNumber(4)
  $pb.PbList<$core.String> get specializations => $_getList(3);

  @$pb.TagNumber(5)
  $core.int get yearsOfExperience => $_getIZ(4);
  @$pb.TagNumber(5)
  set yearsOfExperience($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasYearsOfExperience() => $_has(4);
  @$pb.TagNumber(5)
  void clearYearsOfExperience() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get sessionFee => $_getSZ(5);
  @$pb.TagNumber(6)
  set sessionFee($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasSessionFee() => $_has(5);
  @$pb.TagNumber(6)
  void clearSessionFee() => $_clearField(6);

  @$pb.TagNumber(7)
  $pb.PbList<$core.String> get sessionTypes => $_getList(6);

  @$pb.TagNumber(8)
  $core.String get degreeCertificate => $_getSZ(7);
  @$pb.TagNumber(8)
  set degreeCertificate($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasDegreeCertificate() => $_has(7);
  @$pb.TagNumber(8)
  void clearDegreeCertificate() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get registrationNumber => $_getSZ(8);
  @$pb.TagNumber(9)
  set registrationNumber($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasRegistrationNumber() => $_has(8);
  @$pb.TagNumber(9)
  void clearRegistrationNumber() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get issuingBody => $_getSZ(9);
  @$pb.TagNumber(10)
  set issuingBody($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasIssuingBody() => $_has(9);
  @$pb.TagNumber(10)
  void clearIssuingBody() => $_clearField(10);

  /// Optional
  @$pb.TagNumber(11)
  $core.String get gender => $_getSZ(10);
  @$pb.TagNumber(11)
  set gender($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasGender() => $_has(10);
  @$pb.TagNumber(11)
  void clearGender() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get bio => $_getSZ(11);
  @$pb.TagNumber(12)
  set bio($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasBio() => $_has(11);
  @$pb.TagNumber(12)
  void clearBio() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get profilePhoto => $_getSZ(12);
  @$pb.TagNumber(13)
  set profilePhoto($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasProfilePhoto() => $_has(12);
  @$pb.TagNumber(13)
  void clearProfilePhoto() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get phoneNumber => $_getSZ(13);
  @$pb.TagNumber(14)
  set phoneNumber($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasPhoneNumber() => $_has(13);
  @$pb.TagNumber(14)
  void clearPhoneNumber() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.String get governmentId => $_getSZ(14);
  @$pb.TagNumber(15)
  set governmentId($core.String value) => $_setString(14, value);
  @$pb.TagNumber(15)
  $core.bool hasGovernmentId() => $_has(14);
  @$pb.TagNumber(15)
  void clearGovernmentId() => $_clearField(15);

  /// Required when session_types contains "in_person"
  @$pb.TagNumber(16)
  $core.String get addressText => $_getSZ(15);
  @$pb.TagNumber(16)
  set addressText($core.String value) => $_setString(15, value);
  @$pb.TagNumber(16)
  $core.bool hasAddressText() => $_has(15);
  @$pb.TagNumber(16)
  void clearAddressText() => $_clearField(16);

  @$pb.TagNumber(17)
  $core.double get latitude => $_getN(16);
  @$pb.TagNumber(17)
  set latitude($core.double value) => $_setDouble(16, value);
  @$pb.TagNumber(17)
  $core.bool hasLatitude() => $_has(16);
  @$pb.TagNumber(17)
  void clearLatitude() => $_clearField(17);

  @$pb.TagNumber(18)
  $core.double get longitude => $_getN(17);
  @$pb.TagNumber(18)
  set longitude($core.double value) => $_setDouble(17, value);
  @$pb.TagNumber(18)
  $core.bool hasLongitude() => $_has(17);
  @$pb.TagNumber(18)
  void clearLongitude() => $_clearField(18);

  @$pb.TagNumber(19)
  $core.String get placeId => $_getSZ(18);
  @$pb.TagNumber(19)
  set placeId($core.String value) => $_setString(18, value);
  @$pb.TagNumber(19)
  $core.bool hasPlaceId() => $_has(18);
  @$pb.TagNumber(19)
  void clearPlaceId() => $_clearField(19);

  @$pb.TagNumber(20)
  $core.String get addressState => $_getSZ(19);
  @$pb.TagNumber(20)
  set addressState($core.String value) => $_setString(19, value);
  @$pb.TagNumber(20)
  $core.bool hasAddressState() => $_has(19);
  @$pb.TagNumber(20)
  void clearAddressState() => $_clearField(20);

  @$pb.TagNumber(21)
  $core.String get addressNation => $_getSZ(20);
  @$pb.TagNumber(21)
  set addressNation($core.String value) => $_setString(20, value);
  @$pb.TagNumber(21)
  $core.bool hasAddressNation() => $_has(20);
  @$pb.TagNumber(21)
  void clearAddressNation() => $_clearField(21);
}

class CompleteOnboardingResponse extends $pb.GeneratedMessage {
  factory CompleteOnboardingResponse({
    $core.bool? success,
  }) {
    final result = create();
    if (success != null) result.success = success;
    return result;
  }

  CompleteOnboardingResponse._();

  factory CompleteOnboardingResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CompleteOnboardingResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CompleteOnboardingResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'therapist'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CompleteOnboardingResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CompleteOnboardingResponse copyWith(
          void Function(CompleteOnboardingResponse) updates) =>
      super.copyWith(
              (message) => updates(message as CompleteOnboardingResponse))
          as CompleteOnboardingResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CompleteOnboardingResponse create() => CompleteOnboardingResponse._();
  @$core.override
  CompleteOnboardingResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CompleteOnboardingResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CompleteOnboardingResponse>(create);
  static CompleteOnboardingResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);
}

class ApproveTherapistRequest extends $pb.GeneratedMessage {
  factory ApproveTherapistRequest({
    $core.String? therapistId,
  }) {
    final result = create();
    if (therapistId != null) result.therapistId = therapistId;
    return result;
  }

  ApproveTherapistRequest._();

  factory ApproveTherapistRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ApproveTherapistRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ApproveTherapistRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'therapist'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'therapistId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ApproveTherapistRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ApproveTherapistRequest copyWith(
          void Function(ApproveTherapistRequest) updates) =>
      super.copyWith((message) => updates(message as ApproveTherapistRequest))
          as ApproveTherapistRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ApproveTherapistRequest create() => ApproveTherapistRequest._();
  @$core.override
  ApproveTherapistRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ApproveTherapistRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ApproveTherapistRequest>(create);
  static ApproveTherapistRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get therapistId => $_getSZ(0);
  @$pb.TagNumber(1)
  set therapistId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTherapistId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTherapistId() => $_clearField(1);
}

class ApproveTherapistResponse extends $pb.GeneratedMessage {
  factory ApproveTherapistResponse({
    $core.String? referralId,
  }) {
    final result = create();
    if (referralId != null) result.referralId = referralId;
    return result;
  }

  ApproveTherapistResponse._();

  factory ApproveTherapistResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ApproveTherapistResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ApproveTherapistResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'therapist'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'referralId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ApproveTherapistResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ApproveTherapistResponse copyWith(
          void Function(ApproveTherapistResponse) updates) =>
      super.copyWith((message) => updates(message as ApproveTherapistResponse))
          as ApproveTherapistResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ApproveTherapistResponse create() => ApproveTherapistResponse._();
  @$core.override
  ApproveTherapistResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ApproveTherapistResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ApproveTherapistResponse>(create);
  static ApproveTherapistResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get referralId => $_getSZ(0);
  @$pb.TagNumber(1)
  set referralId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasReferralId() => $_has(0);
  @$pb.TagNumber(1)
  void clearReferralId() => $_clearField(1);
}

class RejectTherapistRequest extends $pb.GeneratedMessage {
  factory RejectTherapistRequest({
    $core.String? therapistId,
    $core.String? reason,
  }) {
    final result = create();
    if (therapistId != null) result.therapistId = therapistId;
    if (reason != null) result.reason = reason;
    return result;
  }

  RejectTherapistRequest._();

  factory RejectTherapistRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RejectTherapistRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RejectTherapistRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'therapist'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'therapistId')
    ..aOS(2, _omitFieldNames ? '' : 'reason')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RejectTherapistRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RejectTherapistRequest copyWith(
          void Function(RejectTherapistRequest) updates) =>
      super.copyWith((message) => updates(message as RejectTherapistRequest))
          as RejectTherapistRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RejectTherapistRequest create() => RejectTherapistRequest._();
  @$core.override
  RejectTherapistRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RejectTherapistRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RejectTherapistRequest>(create);
  static RejectTherapistRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get therapistId => $_getSZ(0);
  @$pb.TagNumber(1)
  set therapistId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTherapistId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTherapistId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get reason => $_getSZ(1);
  @$pb.TagNumber(2)
  set reason($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasReason() => $_has(1);
  @$pb.TagNumber(2)
  void clearReason() => $_clearField(2);
}

class RejectTherapistResponse extends $pb.GeneratedMessage {
  factory RejectTherapistResponse({
    $core.bool? success,
  }) {
    final result = create();
    if (success != null) result.success = success;
    return result;
  }

  RejectTherapistResponse._();

  factory RejectTherapistResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RejectTherapistResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RejectTherapistResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'therapist'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RejectTherapistResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RejectTherapistResponse copyWith(
          void Function(RejectTherapistResponse) updates) =>
      super.copyWith((message) => updates(message as RejectTherapistResponse))
          as RejectTherapistResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RejectTherapistResponse create() => RejectTherapistResponse._();
  @$core.override
  RejectTherapistResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RejectTherapistResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RejectTherapistResponse>(create);
  static RejectTherapistResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);
}

class UploadFileRequest extends $pb.GeneratedMessage {
  factory UploadFileRequest({
    $core.List<$core.int>? data,
    $core.String? fileName,
    $core.String? fileType,
  }) {
    final result = create();
    if (data != null) result.data = data;
    if (fileName != null) result.fileName = fileName;
    if (fileType != null) result.fileType = fileType;
    return result;
  }

  UploadFileRequest._();

  factory UploadFileRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UploadFileRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UploadFileRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'therapist'),
      createEmptyInstance: create)
    ..a<$core.List<$core.int>>(
        1, _omitFieldNames ? '' : 'data', $pb.PbFieldType.OY)
    ..aOS(2, _omitFieldNames ? '' : 'fileName')
    ..aOS(3, _omitFieldNames ? '' : 'fileType')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadFileRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadFileRequest copyWith(void Function(UploadFileRequest) updates) =>
      super.copyWith((message) => updates(message as UploadFileRequest))
          as UploadFileRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UploadFileRequest create() => UploadFileRequest._();
  @$core.override
  UploadFileRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UploadFileRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UploadFileRequest>(create);
  static UploadFileRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get data => $_getN(0);
  @$pb.TagNumber(1)
  set data($core.List<$core.int> value) => $_setBytes(0, value);
  @$pb.TagNumber(1)
  $core.bool hasData() => $_has(0);
  @$pb.TagNumber(1)
  void clearData() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get fileName => $_getSZ(1);
  @$pb.TagNumber(2)
  set fileName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFileName() => $_has(1);
  @$pb.TagNumber(2)
  void clearFileName() => $_clearField(2);

  /// "profile_photo" | "degree_certificate" | "government_id"
  @$pb.TagNumber(3)
  $core.String get fileType => $_getSZ(2);
  @$pb.TagNumber(3)
  set fileType($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasFileType() => $_has(2);
  @$pb.TagNumber(3)
  void clearFileType() => $_clearField(3);
}

class UploadFileResponse extends $pb.GeneratedMessage {
  factory UploadFileResponse({
    $core.String? url,
  }) {
    final result = create();
    if (url != null) result.url = url;
    return result;
  }

  UploadFileResponse._();

  factory UploadFileResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UploadFileResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UploadFileResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'therapist'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'url')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadFileResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadFileResponse copyWith(void Function(UploadFileResponse) updates) =>
      super.copyWith((message) => updates(message as UploadFileResponse))
          as UploadFileResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UploadFileResponse create() => UploadFileResponse._();
  @$core.override
  UploadFileResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UploadFileResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UploadFileResponse>(create);
  static UploadFileResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get url => $_getSZ(0);
  @$pb.TagNumber(1)
  set url($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUrl() => $_has(0);
  @$pb.TagNumber(1)
  void clearUrl() => $_clearField(1);
}

class RefreshSessionRequest extends $pb.GeneratedMessage {
  factory RefreshSessionRequest({
    $core.String? refreshToken,
  }) {
    final result = create();
    if (refreshToken != null) result.refreshToken = refreshToken;
    return result;
  }

  RefreshSessionRequest._();

  factory RefreshSessionRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RefreshSessionRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RefreshSessionRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'therapist'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refreshToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RefreshSessionRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RefreshSessionRequest copyWith(
          void Function(RefreshSessionRequest) updates) =>
      super.copyWith((message) => updates(message as RefreshSessionRequest))
          as RefreshSessionRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RefreshSessionRequest create() => RefreshSessionRequest._();
  @$core.override
  RefreshSessionRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RefreshSessionRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RefreshSessionRequest>(create);
  static RefreshSessionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refreshToken => $_getSZ(0);
  @$pb.TagNumber(1)
  set refreshToken($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefreshToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefreshToken() => $_clearField(1);
}

class RefreshSessionResponse extends $pb.GeneratedMessage {
  factory RefreshSessionResponse({
    $core.String? therapistId,
    $core.String? status,
    $core.String? accessToken,
    $core.String? refreshToken,
    $fixnum.Int64? expiresAt,
  }) {
    final result = create();
    if (therapistId != null) result.therapistId = therapistId;
    if (status != null) result.status = status;
    if (accessToken != null) result.accessToken = accessToken;
    if (refreshToken != null) result.refreshToken = refreshToken;
    if (expiresAt != null) result.expiresAt = expiresAt;
    return result;
  }

  RefreshSessionResponse._();

  factory RefreshSessionResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RefreshSessionResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RefreshSessionResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'therapist'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'therapistId')
    ..aOS(2, _omitFieldNames ? '' : 'status')
    ..aOS(3, _omitFieldNames ? '' : 'accessToken')
    ..aOS(4, _omitFieldNames ? '' : 'refreshToken')
    ..aInt64(5, _omitFieldNames ? '' : 'expiresAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RefreshSessionResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RefreshSessionResponse copyWith(
          void Function(RefreshSessionResponse) updates) =>
      super.copyWith((message) => updates(message as RefreshSessionResponse))
          as RefreshSessionResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RefreshSessionResponse create() => RefreshSessionResponse._();
  @$core.override
  RefreshSessionResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RefreshSessionResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RefreshSessionResponse>(create);
  static RefreshSessionResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get therapistId => $_getSZ(0);
  @$pb.TagNumber(1)
  set therapistId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTherapistId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTherapistId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get status => $_getSZ(1);
  @$pb.TagNumber(2)
  set status($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get accessToken => $_getSZ(2);
  @$pb.TagNumber(3)
  set accessToken($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAccessToken() => $_has(2);
  @$pb.TagNumber(3)
  void clearAccessToken() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get refreshToken => $_getSZ(3);
  @$pb.TagNumber(4)
  set refreshToken($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasRefreshToken() => $_has(3);
  @$pb.TagNumber(4)
  void clearRefreshToken() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get expiresAt => $_getI64(4);
  @$pb.TagNumber(5)
  set expiresAt($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasExpiresAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearExpiresAt() => $_clearField(5);
}

class LogoutRequest extends $pb.GeneratedMessage {
  factory LogoutRequest({
    $core.String? refreshToken,
  }) {
    final result = create();
    if (refreshToken != null) result.refreshToken = refreshToken;
    return result;
  }

  LogoutRequest._();

  factory LogoutRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LogoutRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LogoutRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'therapist'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refreshToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LogoutRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LogoutRequest copyWith(void Function(LogoutRequest) updates) =>
      super.copyWith((message) => updates(message as LogoutRequest))
          as LogoutRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LogoutRequest create() => LogoutRequest._();
  @$core.override
  LogoutRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static LogoutRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LogoutRequest>(create);
  static LogoutRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refreshToken => $_getSZ(0);
  @$pb.TagNumber(1)
  set refreshToken($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefreshToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefreshToken() => $_clearField(1);
}

class LogoutResponse extends $pb.GeneratedMessage {
  factory LogoutResponse({
    $core.bool? success,
  }) {
    final result = create();
    if (success != null) result.success = success;
    return result;
  }

  LogoutResponse._();

  factory LogoutResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LogoutResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LogoutResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'therapist'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LogoutResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LogoutResponse copyWith(void Function(LogoutResponse) updates) =>
      super.copyWith((message) => updates(message as LogoutResponse))
          as LogoutResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LogoutResponse create() => LogoutResponse._();
  @$core.override
  LogoutResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static LogoutResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LogoutResponse>(create);
  static LogoutResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
