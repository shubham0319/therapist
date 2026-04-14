// This is a generated file - do not edit.
//
// Generated from proto/discovery.proto.

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

class TherapistCard extends $pb.GeneratedMessage {
  factory TherapistCard({
    $core.String? therapistId,
    $core.String? fullName,
    $core.String? bio,
    $core.String? profilePhoto,
    $core.Iterable<$core.String>? specializations,
    $core.double? sessionFee,
    $core.Iterable<$core.String>? sessionTypes,
    $core.double? rating,
    $core.int? totalSessions,
    $core.String? state,
    $core.String? nation,
    $core.String? addressText,
  }) {
    final result = create();
    if (therapistId != null) result.therapistId = therapistId;
    if (fullName != null) result.fullName = fullName;
    if (bio != null) result.bio = bio;
    if (profilePhoto != null) result.profilePhoto = profilePhoto;
    if (specializations != null) result.specializations.addAll(specializations);
    if (sessionFee != null) result.sessionFee = sessionFee;
    if (sessionTypes != null) result.sessionTypes.addAll(sessionTypes);
    if (rating != null) result.rating = rating;
    if (totalSessions != null) result.totalSessions = totalSessions;
    if (state != null) result.state = state;
    if (nation != null) result.nation = nation;
    if (addressText != null) result.addressText = addressText;
    return result;
  }

  TherapistCard._();

  factory TherapistCard.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TherapistCard.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TherapistCard',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'therapist'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'therapistId')
    ..aOS(2, _omitFieldNames ? '' : 'fullName')
    ..aOS(3, _omitFieldNames ? '' : 'bio')
    ..aOS(4, _omitFieldNames ? '' : 'profilePhoto')
    ..pPS(5, _omitFieldNames ? '' : 'specializations')
    ..aD(6, _omitFieldNames ? '' : 'sessionFee')
    ..pPS(7, _omitFieldNames ? '' : 'sessionTypes')
    ..aD(8, _omitFieldNames ? '' : 'rating')
    ..aI(9, _omitFieldNames ? '' : 'totalSessions')
    ..aOS(10, _omitFieldNames ? '' : 'state')
    ..aOS(11, _omitFieldNames ? '' : 'nation')
    ..aOS(12, _omitFieldNames ? '' : 'addressText')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TherapistCard clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TherapistCard copyWith(void Function(TherapistCard) updates) =>
      super.copyWith((message) => updates(message as TherapistCard))
          as TherapistCard;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TherapistCard create() => TherapistCard._();
  @$core.override
  TherapistCard createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TherapistCard getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TherapistCard>(create);
  static TherapistCard? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get therapistId => $_getSZ(0);
  @$pb.TagNumber(1)
  set therapistId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTherapistId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTherapistId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get fullName => $_getSZ(1);
  @$pb.TagNumber(2)
  set fullName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFullName() => $_has(1);
  @$pb.TagNumber(2)
  void clearFullName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get bio => $_getSZ(2);
  @$pb.TagNumber(3)
  set bio($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasBio() => $_has(2);
  @$pb.TagNumber(3)
  void clearBio() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get profilePhoto => $_getSZ(3);
  @$pb.TagNumber(4)
  set profilePhoto($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasProfilePhoto() => $_has(3);
  @$pb.TagNumber(4)
  void clearProfilePhoto() => $_clearField(4);

  @$pb.TagNumber(5)
  $pb.PbList<$core.String> get specializations => $_getList(4);

  @$pb.TagNumber(6)
  $core.double get sessionFee => $_getN(5);
  @$pb.TagNumber(6)
  set sessionFee($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasSessionFee() => $_has(5);
  @$pb.TagNumber(6)
  void clearSessionFee() => $_clearField(6);

  @$pb.TagNumber(7)
  $pb.PbList<$core.String> get sessionTypes => $_getList(6);

  @$pb.TagNumber(8)
  $core.double get rating => $_getN(7);
  @$pb.TagNumber(8)
  set rating($core.double value) => $_setDouble(7, value);
  @$pb.TagNumber(8)
  $core.bool hasRating() => $_has(7);
  @$pb.TagNumber(8)
  void clearRating() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.int get totalSessions => $_getIZ(8);
  @$pb.TagNumber(9)
  set totalSessions($core.int value) => $_setSignedInt32(8, value);
  @$pb.TagNumber(9)
  $core.bool hasTotalSessions() => $_has(8);
  @$pb.TagNumber(9)
  void clearTotalSessions() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get state => $_getSZ(9);
  @$pb.TagNumber(10)
  set state($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasState() => $_has(9);
  @$pb.TagNumber(10)
  void clearState() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get nation => $_getSZ(10);
  @$pb.TagNumber(11)
  set nation($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasNation() => $_has(10);
  @$pb.TagNumber(11)
  void clearNation() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get addressText => $_getSZ(11);
  @$pb.TagNumber(12)
  set addressText($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasAddressText() => $_has(11);
  @$pb.TagNumber(12)
  void clearAddressText() => $_clearField(12);
}

/// SearchTherapists — full-text search across verified therapists.
class SearchTherapistsRequest extends $pb.GeneratedMessage {
  factory SearchTherapistsRequest({
    $core.String? query,
    $core.String? sessionType,
    $core.int? page,
    $core.int? pageSize,
  }) {
    final result = create();
    if (query != null) result.query = query;
    if (sessionType != null) result.sessionType = sessionType;
    if (page != null) result.page = page;
    if (pageSize != null) result.pageSize = pageSize;
    return result;
  }

  SearchTherapistsRequest._();

  factory SearchTherapistsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SearchTherapistsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SearchTherapistsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'therapist'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'query')
    ..aOS(2, _omitFieldNames ? '' : 'sessionType')
    ..aI(3, _omitFieldNames ? '' : 'page')
    ..aI(4, _omitFieldNames ? '' : 'pageSize')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchTherapistsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchTherapistsRequest copyWith(
          void Function(SearchTherapistsRequest) updates) =>
      super.copyWith((message) => updates(message as SearchTherapistsRequest))
          as SearchTherapistsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SearchTherapistsRequest create() => SearchTherapistsRequest._();
  @$core.override
  SearchTherapistsRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SearchTherapistsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SearchTherapistsRequest>(create);
  static SearchTherapistsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get query => $_getSZ(0);
  @$pb.TagNumber(1)
  set query($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasQuery() => $_has(0);
  @$pb.TagNumber(1)
  void clearQuery() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get sessionType => $_getSZ(1);
  @$pb.TagNumber(2)
  set sessionType($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSessionType() => $_has(1);
  @$pb.TagNumber(2)
  void clearSessionType() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get page => $_getIZ(2);
  @$pb.TagNumber(3)
  set page($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPage() => $_has(2);
  @$pb.TagNumber(3)
  void clearPage() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get pageSize => $_getIZ(3);
  @$pb.TagNumber(4)
  set pageSize($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPageSize() => $_has(3);
  @$pb.TagNumber(4)
  void clearPageSize() => $_clearField(4);
}

class SearchTherapistsResponse extends $pb.GeneratedMessage {
  factory SearchTherapistsResponse({
    $core.Iterable<TherapistCard>? therapists,
    $fixnum.Int64? total,
  }) {
    final result = create();
    if (therapists != null) result.therapists.addAll(therapists);
    if (total != null) result.total = total;
    return result;
  }

  SearchTherapistsResponse._();

  factory SearchTherapistsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SearchTherapistsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SearchTherapistsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'therapist'),
      createEmptyInstance: create)
    ..pPM<TherapistCard>(1, _omitFieldNames ? '' : 'therapists',
        subBuilder: TherapistCard.create)
    ..aInt64(2, _omitFieldNames ? '' : 'total')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchTherapistsResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchTherapistsResponse copyWith(
          void Function(SearchTherapistsResponse) updates) =>
      super.copyWith((message) => updates(message as SearchTherapistsResponse))
          as SearchTherapistsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SearchTherapistsResponse create() => SearchTherapistsResponse._();
  @$core.override
  SearchTherapistsResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SearchTherapistsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SearchTherapistsResponse>(create);
  static SearchTherapistsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<TherapistCard> get therapists => $_getList(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get total => $_getI64(1);
  @$pb.TagNumber(2)
  set total($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);
}

/// GetRecommendedTherapists — location + rating-based recommendations.
class GetRecommendedTherapistsRequest extends $pb.GeneratedMessage {
  factory GetRecommendedTherapistsRequest({
    $core.String? state,
    $core.String? nation,
    $core.int? page,
    $core.int? pageSize,
  }) {
    final result = create();
    if (state != null) result.state = state;
    if (nation != null) result.nation = nation;
    if (page != null) result.page = page;
    if (pageSize != null) result.pageSize = pageSize;
    return result;
  }

  GetRecommendedTherapistsRequest._();

  factory GetRecommendedTherapistsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetRecommendedTherapistsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetRecommendedTherapistsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'therapist'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'state')
    ..aOS(2, _omitFieldNames ? '' : 'nation')
    ..aI(3, _omitFieldNames ? '' : 'page')
    ..aI(4, _omitFieldNames ? '' : 'pageSize')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetRecommendedTherapistsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetRecommendedTherapistsRequest copyWith(
          void Function(GetRecommendedTherapistsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetRecommendedTherapistsRequest))
          as GetRecommendedTherapistsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetRecommendedTherapistsRequest create() =>
      GetRecommendedTherapistsRequest._();
  @$core.override
  GetRecommendedTherapistsRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetRecommendedTherapistsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetRecommendedTherapistsRequest>(
          create);
  static GetRecommendedTherapistsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get state => $_getSZ(0);
  @$pb.TagNumber(1)
  set state($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasState() => $_has(0);
  @$pb.TagNumber(1)
  void clearState() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get nation => $_getSZ(1);
  @$pb.TagNumber(2)
  set nation($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNation() => $_has(1);
  @$pb.TagNumber(2)
  void clearNation() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get page => $_getIZ(2);
  @$pb.TagNumber(3)
  set page($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPage() => $_has(2);
  @$pb.TagNumber(3)
  void clearPage() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get pageSize => $_getIZ(3);
  @$pb.TagNumber(4)
  set pageSize($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPageSize() => $_has(3);
  @$pb.TagNumber(4)
  void clearPageSize() => $_clearField(4);
}

class GetRecommendedTherapistsResponse extends $pb.GeneratedMessage {
  factory GetRecommendedTherapistsResponse({
    $core.Iterable<TherapistCard>? therapists,
  }) {
    final result = create();
    if (therapists != null) result.therapists.addAll(therapists);
    return result;
  }

  GetRecommendedTherapistsResponse._();

  factory GetRecommendedTherapistsResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetRecommendedTherapistsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetRecommendedTherapistsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'therapist'),
      createEmptyInstance: create)
    ..pPM<TherapistCard>(1, _omitFieldNames ? '' : 'therapists',
        subBuilder: TherapistCard.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetRecommendedTherapistsResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetRecommendedTherapistsResponse copyWith(
          void Function(GetRecommendedTherapistsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetRecommendedTherapistsResponse))
          as GetRecommendedTherapistsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetRecommendedTherapistsResponse create() =>
      GetRecommendedTherapistsResponse._();
  @$core.override
  GetRecommendedTherapistsResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetRecommendedTherapistsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetRecommendedTherapistsResponse>(
          create);
  static GetRecommendedTherapistsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<TherapistCard> get therapists => $_getList(0);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
