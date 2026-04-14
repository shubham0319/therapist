// This is a generated file - do not edit.
//
// Generated from therapist.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports
// ignore_for_file: unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use blogStatusDescriptor instead')
const BlogStatus$json = {
  '1': 'BlogStatus',
  '2': [
    {'1': 'BLOG_STATUS_UNSPECIFIED', '2': 0},
    {'1': 'BLOG_STATUS_DRAFT', '2': 1},
    {'1': 'BLOG_STATUS_PUBLISHED', '2': 2},
  ],
};

/// Descriptor for `BlogStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List blogStatusDescriptor = $convert.base64Decode(
    'CgpCbG9nU3RhdHVzEhsKF0JMT0dfU1RBVFVTX1VOU1BFQ0lGSUVEEAASFQoRQkxPR19TVEFUVV'
    'NfRFJBRlQQARIZChVCTE9HX1NUQVRVU19QVUJMSVNIRUQQAg==');

@$core.Deprecated('Use authCallbackRequestDescriptor instead')
const AuthCallbackRequest$json = {
  '1': 'AuthCallbackRequest',
  '2': [
    {'1': 'supabase_token', '3': 1, '4': 1, '5': 9, '10': 'supabaseToken'},
  ],
};

/// Descriptor for `AuthCallbackRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List authCallbackRequestDescriptor = $convert.base64Decode(
    'ChNBdXRoQ2FsbGJhY2tSZXF1ZXN0EiUKDnN1cGFiYXNlX3Rva2VuGAEgASgJUg1zdXBhYmFzZV'
    'Rva2Vu');

@$core.Deprecated('Use authCallbackResponseDescriptor instead')
const AuthCallbackResponse$json = {
  '1': 'AuthCallbackResponse',
  '2': [
    {'1': 'therapist_id', '3': 1, '4': 1, '5': 9, '10': 'therapistId'},
    {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
    {
      '1': 'onboarding_completed',
      '3': 3,
      '4': 1,
      '5': 8,
      '10': 'onboardingCompleted'
    },
    {'1': 'referral_id', '3': 4, '4': 1, '5': 9, '10': 'referralId'},
    {'1': 'rejection_reason', '3': 5, '4': 1, '5': 9, '10': 'rejectionReason'},
    {'1': 'access_token', '3': 6, '4': 1, '5': 9, '10': 'accessToken'},
    {'1': 'refresh_token', '3': 7, '4': 1, '5': 9, '10': 'refreshToken'},
    {'1': 'expires_at', '3': 8, '4': 1, '5': 3, '10': 'expiresAt'},
  ],
};

/// Descriptor for `AuthCallbackResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List authCallbackResponseDescriptor = $convert.base64Decode(
    'ChRBdXRoQ2FsbGJhY2tSZXNwb25zZRIhCgx0aGVyYXBpc3RfaWQYASABKAlSC3RoZXJhcGlzdE'
    'lkEhYKBnN0YXR1cxgCIAEoCVIGc3RhdHVzEjEKFG9uYm9hcmRpbmdfY29tcGxldGVkGAMgASgI'
    'UhNvbmJvYXJkaW5nQ29tcGxldGVkEh8KC3JlZmVycmFsX2lkGAQgASgJUgpyZWZlcnJhbElkEi'
    'kKEHJlamVjdGlvbl9yZWFzb24YBSABKAlSD3JlamVjdGlvblJlYXNvbhIhCgxhY2Nlc3NfdG9r'
    'ZW4YBiABKAlSC2FjY2Vzc1Rva2VuEiMKDXJlZnJlc2hfdG9rZW4YByABKAlSDHJlZnJlc2hUb2'
    'tlbhIdCgpleHBpcmVzX2F0GAggASgDUglleHBpcmVzQXQ=');

@$core.Deprecated('Use getStatusRequestDescriptor instead')
const GetStatusRequest$json = {
  '1': 'GetStatusRequest',
  '2': [
    {'1': 'supabase_token', '3': 1, '4': 1, '5': 9, '10': 'supabaseToken'},
  ],
};

/// Descriptor for `GetStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getStatusRequestDescriptor = $convert.base64Decode(
    'ChBHZXRTdGF0dXNSZXF1ZXN0EiUKDnN1cGFiYXNlX3Rva2VuGAEgASgJUg1zdXBhYmFzZVRva2'
    'Vu');

@$core.Deprecated('Use getStatusResponseDescriptor instead')
const GetStatusResponse$json = {
  '1': 'GetStatusResponse',
  '2': [
    {'1': 'therapist_id', '3': 1, '4': 1, '5': 9, '10': 'therapistId'},
    {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
    {
      '1': 'onboarding_completed',
      '3': 3,
      '4': 1,
      '5': 8,
      '10': 'onboardingCompleted'
    },
    {'1': 'referral_id', '3': 4, '4': 1, '5': 9, '10': 'referralId'},
    {'1': 'rejection_reason', '3': 5, '4': 1, '5': 9, '10': 'rejectionReason'},
  ],
};

/// Descriptor for `GetStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getStatusResponseDescriptor = $convert.base64Decode(
    'ChFHZXRTdGF0dXNSZXNwb25zZRIhCgx0aGVyYXBpc3RfaWQYASABKAlSC3RoZXJhcGlzdElkEh'
    'YKBnN0YXR1cxgCIAEoCVIGc3RhdHVzEjEKFG9uYm9hcmRpbmdfY29tcGxldGVkGAMgASgIUhNv'
    'bmJvYXJkaW5nQ29tcGxldGVkEh8KC3JlZmVycmFsX2lkGAQgASgJUgpyZWZlcnJhbElkEikKEH'
    'JlamVjdGlvbl9yZWFzb24YBSABKAlSD3JlamVjdGlvblJlYXNvbg==');

@$core.Deprecated('Use completeOnboardingRequestDescriptor instead')
const CompleteOnboardingRequest$json = {
  '1': 'CompleteOnboardingRequest',
  '2': [
    {'1': 'therapist_id', '3': 1, '4': 1, '5': 9, '10': 'therapistId'},
    {'1': 'full_name', '3': 2, '4': 1, '5': 9, '10': 'fullName'},
    {'1': 'languages_spoken', '3': 3, '4': 3, '5': 9, '10': 'languagesSpoken'},
    {'1': 'specializations', '3': 4, '4': 3, '5': 9, '10': 'specializations'},
    {
      '1': 'years_of_experience',
      '3': 5,
      '4': 1,
      '5': 5,
      '10': 'yearsOfExperience'
    },
    {'1': 'session_fee', '3': 6, '4': 1, '5': 9, '10': 'sessionFee'},
    {'1': 'session_types', '3': 7, '4': 3, '5': 9, '10': 'sessionTypes'},
    {
      '1': 'degree_certificate',
      '3': 8,
      '4': 1,
      '5': 9,
      '10': 'degreeCertificate'
    },
    {
      '1': 'registration_number',
      '3': 9,
      '4': 1,
      '5': 9,
      '10': 'registrationNumber'
    },
    {'1': 'issuing_body', '3': 10, '4': 1, '5': 9, '10': 'issuingBody'},
    {'1': 'gender', '3': 11, '4': 1, '5': 9, '10': 'gender'},
    {'1': 'bio', '3': 12, '4': 1, '5': 9, '10': 'bio'},
    {'1': 'profile_photo', '3': 13, '4': 1, '5': 9, '10': 'profilePhoto'},
    {'1': 'phone_number', '3': 14, '4': 1, '5': 9, '10': 'phoneNumber'},
    {'1': 'government_id', '3': 15, '4': 1, '5': 9, '10': 'governmentId'},
    {'1': 'address_text', '3': 16, '4': 1, '5': 9, '10': 'addressText'},
    {'1': 'latitude', '3': 17, '4': 1, '5': 1, '10': 'latitude'},
    {'1': 'longitude', '3': 18, '4': 1, '5': 1, '10': 'longitude'},
    {'1': 'place_id', '3': 19, '4': 1, '5': 9, '10': 'placeId'},
    {'1': 'address_state', '3': 20, '4': 1, '5': 9, '10': 'addressState'},
    {'1': 'address_nation', '3': 21, '4': 1, '5': 9, '10': 'addressNation'},
  ],
};

/// Descriptor for `CompleteOnboardingRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List completeOnboardingRequestDescriptor = $convert.base64Decode(
    'ChlDb21wbGV0ZU9uYm9hcmRpbmdSZXF1ZXN0EiEKDHRoZXJhcGlzdF9pZBgBIAEoCVILdGhlcm'
    'FwaXN0SWQSGwoJZnVsbF9uYW1lGAIgASgJUghmdWxsTmFtZRIpChBsYW5ndWFnZXNfc3Bva2Vu'
    'GAMgAygJUg9sYW5ndWFnZXNTcG9rZW4SKAoPc3BlY2lhbGl6YXRpb25zGAQgAygJUg9zcGVjaW'
    'FsaXphdGlvbnMSLgoTeWVhcnNfb2ZfZXhwZXJpZW5jZRgFIAEoBVIReWVhcnNPZkV4cGVyaWVu'
    'Y2USHwoLc2Vzc2lvbl9mZWUYBiABKAlSCnNlc3Npb25GZWUSIwoNc2Vzc2lvbl90eXBlcxgHIA'
    'MoCVIMc2Vzc2lvblR5cGVzEi0KEmRlZ3JlZV9jZXJ0aWZpY2F0ZRgIIAEoCVIRZGVncmVlQ2Vy'
    'dGlmaWNhdGUSLwoTcmVnaXN0cmF0aW9uX251bWJlchgJIAEoCVIScmVnaXN0cmF0aW9uTnVtYm'
    'VyEiEKDGlzc3VpbmdfYm9keRgKIAEoCVILaXNzdWluZ0JvZHkSFgoGZ2VuZGVyGAsgASgJUgZn'
    'ZW5kZXISEAoDYmlvGAwgASgJUgNiaW8SIwoNcHJvZmlsZV9waG90bxgNIAEoCVIMcHJvZmlsZV'
    'Bob3RvEiEKDHBob25lX251bWJlchgOIAEoCVILcGhvbmVOdW1iZXISIwoNZ292ZXJubWVudF9p'
    'ZBgPIAEoCVIMZ292ZXJubWVudElkEiEKDGFkZHJlc3NfdGV4dBgQIAEoCVILYWRkcmVzc1RleH'
    'QSGgoIbGF0aXR1ZGUYESABKAFSCGxhdGl0dWRlEhwKCWxvbmdpdHVkZRgSIAEoAVIJbG9uZ2l0'
    'dWRlEhkKCHBsYWNlX2lkGBMgASgJUgdwbGFjZUlkEiMKDWFkZHJlc3Nfc3RhdGUYFCABKAlSDG'
    'FkZHJlc3NTdGF0ZRIlCg5hZGRyZXNzX25hdGlvbhgVIAEoCVINYWRkcmVzc05hdGlvbg==');

@$core.Deprecated('Use completeOnboardingResponseDescriptor instead')
const CompleteOnboardingResponse$json = {
  '1': 'CompleteOnboardingResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `CompleteOnboardingResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List completeOnboardingResponseDescriptor =
    $convert.base64Decode(
        'ChpDb21wbGV0ZU9uYm9hcmRpbmdSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNz');

@$core.Deprecated('Use approveTherapistRequestDescriptor instead')
const ApproveTherapistRequest$json = {
  '1': 'ApproveTherapistRequest',
  '2': [
    {'1': 'therapist_id', '3': 1, '4': 1, '5': 9, '10': 'therapistId'},
  ],
};

/// Descriptor for `ApproveTherapistRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List approveTherapistRequestDescriptor =
    $convert.base64Decode(
        'ChdBcHByb3ZlVGhlcmFwaXN0UmVxdWVzdBIhCgx0aGVyYXBpc3RfaWQYASABKAlSC3RoZXJhcG'
        'lzdElk');

@$core.Deprecated('Use approveTherapistResponseDescriptor instead')
const ApproveTherapistResponse$json = {
  '1': 'ApproveTherapistResponse',
  '2': [
    {'1': 'referral_id', '3': 1, '4': 1, '5': 9, '10': 'referralId'},
  ],
};

/// Descriptor for `ApproveTherapistResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List approveTherapistResponseDescriptor =
    $convert.base64Decode(
        'ChhBcHByb3ZlVGhlcmFwaXN0UmVzcG9uc2USHwoLcmVmZXJyYWxfaWQYASABKAlSCnJlZmVycm'
        'FsSWQ=');

@$core.Deprecated('Use rejectTherapistRequestDescriptor instead')
const RejectTherapistRequest$json = {
  '1': 'RejectTherapistRequest',
  '2': [
    {'1': 'therapist_id', '3': 1, '4': 1, '5': 9, '10': 'therapistId'},
    {'1': 'reason', '3': 2, '4': 1, '5': 9, '10': 'reason'},
  ],
};

/// Descriptor for `RejectTherapistRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rejectTherapistRequestDescriptor =
    $convert.base64Decode(
        'ChZSZWplY3RUaGVyYXBpc3RSZXF1ZXN0EiEKDHRoZXJhcGlzdF9pZBgBIAEoCVILdGhlcmFwaX'
        'N0SWQSFgoGcmVhc29uGAIgASgJUgZyZWFzb24=');

@$core.Deprecated('Use rejectTherapistResponseDescriptor instead')
const RejectTherapistResponse$json = {
  '1': 'RejectTherapistResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `RejectTherapistResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rejectTherapistResponseDescriptor =
    $convert.base64Decode(
        'ChdSZWplY3RUaGVyYXBpc3RSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNz');

@$core.Deprecated('Use uploadFileRequestDescriptor instead')
const UploadFileRequest$json = {
  '1': 'UploadFileRequest',
  '2': [
    {'1': 'data', '3': 1, '4': 1, '5': 12, '10': 'data'},
    {'1': 'file_name', '3': 2, '4': 1, '5': 9, '10': 'fileName'},
    {'1': 'file_type', '3': 3, '4': 1, '5': 9, '10': 'fileType'},
  ],
};

/// Descriptor for `UploadFileRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List uploadFileRequestDescriptor = $convert.base64Decode(
    'ChFVcGxvYWRGaWxlUmVxdWVzdBISCgRkYXRhGAEgASgMUgRkYXRhEhsKCWZpbGVfbmFtZRgCIA'
    'EoCVIIZmlsZU5hbWUSGwoJZmlsZV90eXBlGAMgASgJUghmaWxlVHlwZQ==');

@$core.Deprecated('Use uploadFileResponseDescriptor instead')
const UploadFileResponse$json = {
  '1': 'UploadFileResponse',
  '2': [
    {'1': 'url', '3': 1, '4': 1, '5': 9, '10': 'url'},
  ],
};

/// Descriptor for `UploadFileResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List uploadFileResponseDescriptor = $convert
    .base64Decode('ChJVcGxvYWRGaWxlUmVzcG9uc2USEAoDdXJsGAEgASgJUgN1cmw=');

@$core.Deprecated('Use refreshSessionRequestDescriptor instead')
const RefreshSessionRequest$json = {
  '1': 'RefreshSessionRequest',
  '2': [
    {'1': 'refresh_token', '3': 1, '4': 1, '5': 9, '10': 'refreshToken'},
  ],
};

/// Descriptor for `RefreshSessionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List refreshSessionRequestDescriptor = $convert.base64Decode(
    'ChVSZWZyZXNoU2Vzc2lvblJlcXVlc3QSIwoNcmVmcmVzaF90b2tlbhgBIAEoCVIMcmVmcmVzaF'
    'Rva2Vu');

@$core.Deprecated('Use refreshSessionResponseDescriptor instead')
const RefreshSessionResponse$json = {
  '1': 'RefreshSessionResponse',
  '2': [
    {'1': 'therapist_id', '3': 1, '4': 1, '5': 9, '10': 'therapistId'},
    {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
    {'1': 'access_token', '3': 3, '4': 1, '5': 9, '10': 'accessToken'},
    {'1': 'refresh_token', '3': 4, '4': 1, '5': 9, '10': 'refreshToken'},
    {'1': 'expires_at', '3': 5, '4': 1, '5': 3, '10': 'expiresAt'},
  ],
};

/// Descriptor for `RefreshSessionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List refreshSessionResponseDescriptor = $convert.base64Decode(
    'ChZSZWZyZXNoU2Vzc2lvblJlc3BvbnNlEiEKDHRoZXJhcGlzdF9pZBgBIAEoCVILdGhlcmFwaX'
    'N0SWQSFgoGc3RhdHVzGAIgASgJUgZzdGF0dXMSIQoMYWNjZXNzX3Rva2VuGAMgASgJUgthY2Nl'
    'c3NUb2tlbhIjCg1yZWZyZXNoX3Rva2VuGAQgASgJUgxyZWZyZXNoVG9rZW4SHQoKZXhwaXJlc1'
    '9hdBgFIAEoA1IJZXhwaXJlc0F0');

@$core.Deprecated('Use logoutRequestDescriptor instead')
const LogoutRequest$json = {
  '1': 'LogoutRequest',
  '2': [
    {'1': 'refresh_token', '3': 1, '4': 1, '5': 9, '10': 'refreshToken'},
  ],
};

/// Descriptor for `LogoutRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List logoutRequestDescriptor = $convert.base64Decode(
    'Cg1Mb2dvdXRSZXF1ZXN0EiMKDXJlZnJlc2hfdG9rZW4YASABKAlSDHJlZnJlc2hUb2tlbg==');

@$core.Deprecated('Use logoutResponseDescriptor instead')
const LogoutResponse$json = {
  '1': 'LogoutResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `LogoutResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List logoutResponseDescriptor = $convert
    .base64Decode('Cg5Mb2dvdXRSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNz');

@$core.Deprecated('Use blogDescriptor instead')
const Blog$json = {
  '1': 'Blog',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'therapist_id', '3': 2, '4': 1, '5': 9, '10': 'therapistId'},
    {'1': 'title', '3': 3, '4': 1, '5': 9, '10': 'title'},
    {'1': 'slug', '3': 4, '4': 1, '5': 9, '10': 'slug'},
    {'1': 'cover_image_url', '3': 5, '4': 1, '5': 9, '10': 'coverImageUrl'},
    {'1': 'content', '3': 6, '4': 1, '5': 9, '10': 'content'},
    {'1': 'image_urls', '3': 7, '4': 3, '5': 9, '10': 'imageUrls'},
    {
      '1': 'status',
      '3': 8,
      '4': 1,
      '5': 14,
      '6': '.therapist.BlogStatus',
      '10': 'status'
    },
    {'1': 'views', '3': 9, '4': 1, '5': 3, '10': 'views'},
    {'1': 'likes', '3': 10, '4': 1, '5': 3, '10': 'likes'},
    {'1': 'liked_by_me', '3': 11, '4': 1, '5': 8, '10': 'likedByMe'},
    {'1': 'created_at', '3': 12, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'updated_at', '3': 13, '4': 1, '5': 9, '10': 'updatedAt'},
    {'1': 'published_at', '3': 14, '4': 1, '5': 9, '10': 'publishedAt'},
    {'1': 'tags', '3': 15, '4': 3, '5': 9, '10': 'tags'},
  ],
};

/// Descriptor for `Blog`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List blogDescriptor = $convert.base64Decode(
    'CgRCbG9nEg4KAmlkGAEgASgJUgJpZBIhCgx0aGVyYXBpc3RfaWQYAiABKAlSC3RoZXJhcGlzdE'
    'lkEhQKBXRpdGxlGAMgASgJUgV0aXRsZRISCgRzbHVnGAQgASgJUgRzbHVnEiYKD2NvdmVyX2lt'
    'YWdlX3VybBgFIAEoCVINY292ZXJJbWFnZVVybBIYCgdjb250ZW50GAYgASgJUgdjb250ZW50Eh'
    '0KCmltYWdlX3VybHMYByADKAlSCWltYWdlVXJscxItCgZzdGF0dXMYCCABKA4yFS50aGVyYXBp'
    'c3QuQmxvZ1N0YXR1c1IGc3RhdHVzEhQKBXZpZXdzGAkgASgDUgV2aWV3cxIUCgVsaWtlcxgKIA'
    'EoA1IFbGlrZXMSHgoLbGlrZWRfYnlfbWUYCyABKAhSCWxpa2VkQnlNZRIdCgpjcmVhdGVkX2F0'
    'GAwgASgJUgljcmVhdGVkQXQSHQoKdXBkYXRlZF9hdBgNIAEoCVIJdXBkYXRlZEF0EiEKDHB1Ym'
    'xpc2hlZF9hdBgOIAEoCVILcHVibGlzaGVkQXQSEgoEdGFncxgPIAMoCVIEdGFncw==');

@$core.Deprecated('Use createBlogRequestDescriptor instead')
const CreateBlogRequest$json = {
  '1': 'CreateBlogRequest',
  '2': [
    {'1': 'therapist_id', '3': 1, '4': 1, '5': 9, '10': 'therapistId'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'content', '3': 3, '4': 1, '5': 9, '10': 'content'},
    {'1': 'cover_image_url', '3': 4, '4': 1, '5': 9, '10': 'coverImageUrl'},
    {'1': 'image_urls', '3': 5, '4': 3, '5': 9, '10': 'imageUrls'},
    {'1': 'tags', '3': 6, '4': 3, '5': 9, '10': 'tags'},
  ],
};

/// Descriptor for `CreateBlogRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createBlogRequestDescriptor = $convert.base64Decode(
    'ChFDcmVhdGVCbG9nUmVxdWVzdBIhCgx0aGVyYXBpc3RfaWQYASABKAlSC3RoZXJhcGlzdElkEh'
    'QKBXRpdGxlGAIgASgJUgV0aXRsZRIYCgdjb250ZW50GAMgASgJUgdjb250ZW50EiYKD2NvdmVy'
    'X2ltYWdlX3VybBgEIAEoCVINY292ZXJJbWFnZVVybBIdCgppbWFnZV91cmxzGAUgAygJUglpbW'
    'FnZVVybHMSEgoEdGFncxgGIAMoCVIEdGFncw==');

@$core.Deprecated('Use createBlogResponseDescriptor instead')
const CreateBlogResponse$json = {
  '1': 'CreateBlogResponse',
  '2': [
    {
      '1': 'blog',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.therapist.Blog',
      '10': 'blog'
    },
  ],
};

/// Descriptor for `CreateBlogResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createBlogResponseDescriptor = $convert.base64Decode(
    'ChJDcmVhdGVCbG9nUmVzcG9uc2USIwoEYmxvZxgBIAEoCzIPLnRoZXJhcGlzdC5CbG9nUgRibG'
    '9n');

@$core.Deprecated('Use updateBlogRequestDescriptor instead')
const UpdateBlogRequest$json = {
  '1': 'UpdateBlogRequest',
  '2': [
    {'1': 'therapist_id', '3': 1, '4': 1, '5': 9, '10': 'therapistId'},
    {'1': 'blog_id', '3': 2, '4': 1, '5': 9, '10': 'blogId'},
    {'1': 'title', '3': 3, '4': 1, '5': 9, '10': 'title'},
    {'1': 'content', '3': 4, '4': 1, '5': 9, '10': 'content'},
    {'1': 'cover_image_url', '3': 5, '4': 1, '5': 9, '10': 'coverImageUrl'},
    {'1': 'image_urls', '3': 6, '4': 3, '5': 9, '10': 'imageUrls'},
    {'1': 'tags', '3': 7, '4': 3, '5': 9, '10': 'tags'},
  ],
};

/// Descriptor for `UpdateBlogRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateBlogRequestDescriptor = $convert.base64Decode(
    'ChFVcGRhdGVCbG9nUmVxdWVzdBIhCgx0aGVyYXBpc3RfaWQYASABKAlSC3RoZXJhcGlzdElkEh'
    'cKB2Jsb2dfaWQYAiABKAlSBmJsb2dJZBIUCgV0aXRsZRgDIAEoCVIFdGl0bGUSGAoHY29udGVu'
    'dBgEIAEoCVIHY29udGVudBImCg9jb3Zlcl9pbWFnZV91cmwYBSABKAlSDWNvdmVySW1hZ2VVcm'
    'wSHQoKaW1hZ2VfdXJscxgGIAMoCVIJaW1hZ2VVcmxzEhIKBHRhZ3MYByADKAlSBHRhZ3M=');

@$core.Deprecated('Use updateBlogResponseDescriptor instead')
const UpdateBlogResponse$json = {
  '1': 'UpdateBlogResponse',
  '2': [
    {
      '1': 'blog',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.therapist.Blog',
      '10': 'blog'
    },
  ],
};

/// Descriptor for `UpdateBlogResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateBlogResponseDescriptor = $convert.base64Decode(
    'ChJVcGRhdGVCbG9nUmVzcG9uc2USIwoEYmxvZxgBIAEoCzIPLnRoZXJhcGlzdC5CbG9nUgRibG'
    '9n');

@$core.Deprecated('Use publishBlogRequestDescriptor instead')
const PublishBlogRequest$json = {
  '1': 'PublishBlogRequest',
  '2': [
    {'1': 'therapist_id', '3': 1, '4': 1, '5': 9, '10': 'therapistId'},
    {'1': 'blog_id', '3': 2, '4': 1, '5': 9, '10': 'blogId'},
  ],
};

/// Descriptor for `PublishBlogRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List publishBlogRequestDescriptor = $convert.base64Decode(
    'ChJQdWJsaXNoQmxvZ1JlcXVlc3QSIQoMdGhlcmFwaXN0X2lkGAEgASgJUgt0aGVyYXBpc3RJZB'
    'IXCgdibG9nX2lkGAIgASgJUgZibG9nSWQ=');

@$core.Deprecated('Use publishBlogResponseDescriptor instead')
const PublishBlogResponse$json = {
  '1': 'PublishBlogResponse',
  '2': [
    {
      '1': 'blog',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.therapist.Blog',
      '10': 'blog'
    },
  ],
};

/// Descriptor for `PublishBlogResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List publishBlogResponseDescriptor = $convert.base64Decode(
    'ChNQdWJsaXNoQmxvZ1Jlc3BvbnNlEiMKBGJsb2cYASABKAsyDy50aGVyYXBpc3QuQmxvZ1IEYm'
    'xvZw==');

@$core.Deprecated('Use deleteBlogRequestDescriptor instead')
const DeleteBlogRequest$json = {
  '1': 'DeleteBlogRequest',
  '2': [
    {'1': 'therapist_id', '3': 1, '4': 1, '5': 9, '10': 'therapistId'},
    {'1': 'blog_id', '3': 2, '4': 1, '5': 9, '10': 'blogId'},
  ],
};

/// Descriptor for `DeleteBlogRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteBlogRequestDescriptor = $convert.base64Decode(
    'ChFEZWxldGVCbG9nUmVxdWVzdBIhCgx0aGVyYXBpc3RfaWQYASABKAlSC3RoZXJhcGlzdElkEh'
    'cKB2Jsb2dfaWQYAiABKAlSBmJsb2dJZA==');

@$core.Deprecated('Use deleteBlogResponseDescriptor instead')
const DeleteBlogResponse$json = {
  '1': 'DeleteBlogResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `DeleteBlogResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteBlogResponseDescriptor =
    $convert.base64Decode(
        'ChJEZWxldGVCbG9nUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2Vzcw==');

@$core.Deprecated('Use getBlogRequestDescriptor instead')
const GetBlogRequest$json = {
  '1': 'GetBlogRequest',
  '2': [
    {'1': 'blog_id', '3': 1, '4': 1, '5': 9, '10': 'blogId'},
    {'1': 'viewer_id', '3': 2, '4': 1, '5': 9, '10': 'viewerId'},
  ],
};

/// Descriptor for `GetBlogRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBlogRequestDescriptor = $convert.base64Decode(
    'Cg5HZXRCbG9nUmVxdWVzdBIXCgdibG9nX2lkGAEgASgJUgZibG9nSWQSGwoJdmlld2VyX2lkGA'
    'IgASgJUgh2aWV3ZXJJZA==');

@$core.Deprecated('Use getBlogResponseDescriptor instead')
const GetBlogResponse$json = {
  '1': 'GetBlogResponse',
  '2': [
    {
      '1': 'blog',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.therapist.Blog',
      '10': 'blog'
    },
  ],
};

/// Descriptor for `GetBlogResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBlogResponseDescriptor = $convert.base64Decode(
    'Cg9HZXRCbG9nUmVzcG9uc2USIwoEYmxvZxgBIAEoCzIPLnRoZXJhcGlzdC5CbG9nUgRibG9n');

@$core.Deprecated('Use listBlogsRequestDescriptor instead')
const ListBlogsRequest$json = {
  '1': 'ListBlogsRequest',
  '2': [
    {'1': 'therapist_id', '3': 1, '4': 1, '5': 9, '10': 'therapistId'},
    {'1': 'viewer_id', '3': 2, '4': 1, '5': 9, '10': 'viewerId'},
    {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    {'1': 'page_size', '3': 4, '4': 1, '5': 5, '10': 'pageSize'},
  ],
};

/// Descriptor for `ListBlogsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listBlogsRequestDescriptor = $convert.base64Decode(
    'ChBMaXN0QmxvZ3NSZXF1ZXN0EiEKDHRoZXJhcGlzdF9pZBgBIAEoCVILdGhlcmFwaXN0SWQSGw'
    'oJdmlld2VyX2lkGAIgASgJUgh2aWV3ZXJJZBISCgRwYWdlGAMgASgFUgRwYWdlEhsKCXBhZ2Vf'
    'c2l6ZRgEIAEoBVIIcGFnZVNpemU=');

@$core.Deprecated('Use listBlogsResponseDescriptor instead')
const ListBlogsResponse$json = {
  '1': 'ListBlogsResponse',
  '2': [
    {
      '1': 'blogs',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.therapist.Blog',
      '10': 'blogs'
    },
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `ListBlogsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listBlogsResponseDescriptor = $convert.base64Decode(
    'ChFMaXN0QmxvZ3NSZXNwb25zZRIlCgVibG9ncxgBIAMoCzIPLnRoZXJhcGlzdC5CbG9nUgVibG'
    '9ncxIUCgV0b3RhbBgCIAEoBVIFdG90YWw=');

@$core.Deprecated('Use listMyBlogsRequestDescriptor instead')
const ListMyBlogsRequest$json = {
  '1': 'ListMyBlogsRequest',
  '2': [
    {'1': 'therapist_id', '3': 1, '4': 1, '5': 9, '10': 'therapistId'},
    {'1': 'page', '3': 2, '4': 1, '5': 5, '10': 'page'},
    {'1': 'page_size', '3': 3, '4': 1, '5': 5, '10': 'pageSize'},
  ],
};

/// Descriptor for `ListMyBlogsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listMyBlogsRequestDescriptor = $convert.base64Decode(
    'ChJMaXN0TXlCbG9nc1JlcXVlc3QSIQoMdGhlcmFwaXN0X2lkGAEgASgJUgt0aGVyYXBpc3RJZB'
    'ISCgRwYWdlGAIgASgFUgRwYWdlEhsKCXBhZ2Vfc2l6ZRgDIAEoBVIIcGFnZVNpemU=');

@$core.Deprecated('Use listMyBlogsResponseDescriptor instead')
const ListMyBlogsResponse$json = {
  '1': 'ListMyBlogsResponse',
  '2': [
    {
      '1': 'blogs',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.therapist.Blog',
      '10': 'blogs'
    },
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `ListMyBlogsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listMyBlogsResponseDescriptor = $convert.base64Decode(
    'ChNMaXN0TXlCbG9nc1Jlc3BvbnNlEiUKBWJsb2dzGAEgAygLMg8udGhlcmFwaXN0LkJsb2dSBW'
    'Jsb2dzEhQKBXRvdGFsGAIgASgFUgV0b3RhbA==');

@$core.Deprecated('Use toggleLikeBlogRequestDescriptor instead')
const ToggleLikeBlogRequest$json = {
  '1': 'ToggleLikeBlogRequest',
  '2': [
    {'1': 'therapist_id', '3': 1, '4': 1, '5': 9, '10': 'therapistId'},
    {'1': 'blog_id', '3': 2, '4': 1, '5': 9, '10': 'blogId'},
  ],
};

/// Descriptor for `ToggleLikeBlogRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List toggleLikeBlogRequestDescriptor = $convert.base64Decode(
    'ChVUb2dnbGVMaWtlQmxvZ1JlcXVlc3QSIQoMdGhlcmFwaXN0X2lkGAEgASgJUgt0aGVyYXBpc3'
    'RJZBIXCgdibG9nX2lkGAIgASgJUgZibG9nSWQ=');

@$core.Deprecated('Use toggleLikeBlogResponseDescriptor instead')
const ToggleLikeBlogResponse$json = {
  '1': 'ToggleLikeBlogResponse',
  '2': [
    {'1': 'liked', '3': 1, '4': 1, '5': 8, '10': 'liked'},
    {'1': 'likes', '3': 2, '4': 1, '5': 3, '10': 'likes'},
  ],
};

/// Descriptor for `ToggleLikeBlogResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List toggleLikeBlogResponseDescriptor =
    $convert.base64Decode(
        'ChZUb2dnbGVMaWtlQmxvZ1Jlc3BvbnNlEhQKBWxpa2VkGAEgASgIUgVsaWtlZBIUCgVsaWtlcx'
        'gCIAEoA1IFbGlrZXM=');

@$core.Deprecated('Use uploadBlogImageRequestDescriptor instead')
const UploadBlogImageRequest$json = {
  '1': 'UploadBlogImageRequest',
  '2': [
    {'1': 'therapist_id', '3': 1, '4': 1, '5': 9, '10': 'therapistId'},
    {'1': 'data', '3': 2, '4': 1, '5': 12, '10': 'data'},
    {'1': 'file_name', '3': 3, '4': 1, '5': 9, '10': 'fileName'},
    {'1': 'content_type', '3': 4, '4': 1, '5': 9, '10': 'contentType'},
  ],
};

/// Descriptor for `UploadBlogImageRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List uploadBlogImageRequestDescriptor = $convert.base64Decode(
    'ChZVcGxvYWRCbG9nSW1hZ2VSZXF1ZXN0EiEKDHRoZXJhcGlzdF9pZBgBIAEoCVILdGhlcmFwaX'
    'N0SWQSEgoEZGF0YRgCIAEoDFIEZGF0YRIbCglmaWxlX25hbWUYAyABKAlSCGZpbGVOYW1lEiEK'
    'DGNvbnRlbnRfdHlwZRgEIAEoCVILY29udGVudFR5cGU=');

@$core.Deprecated('Use uploadBlogImageResponseDescriptor instead')
const UploadBlogImageResponse$json = {
  '1': 'UploadBlogImageResponse',
  '2': [
    {'1': 'url', '3': 1, '4': 1, '5': 9, '10': 'url'},
  ],
};

/// Descriptor for `UploadBlogImageResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List uploadBlogImageResponseDescriptor =
    $convert.base64Decode(
        'ChdVcGxvYWRCbG9nSW1hZ2VSZXNwb25zZRIQCgN1cmwYASABKAlSA3VybA==');

@$core.Deprecated('Use userDescriptor instead')
const User$json = {
  '1': 'User',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'email', '3': 2, '4': 1, '5': 9, '10': 'email'},
    {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    {'1': 'phone', '3': 4, '4': 1, '5': 9, '10': 'phone'},
    {'1': 'state', '3': 5, '4': 1, '5': 9, '10': 'state'},
    {'1': 'nation', '3': 6, '4': 1, '5': 9, '10': 'nation'},
    {'1': 'looking_for', '3': 7, '4': 3, '5': 9, '10': 'lookingFor'},
    {
      '1': 'onboarding_completed',
      '3': 8,
      '4': 1,
      '5': 8,
      '10': 'onboardingCompleted'
    },
    {'1': 'created_at', '3': 9, '4': 1, '5': 9, '10': 'createdAt'},
  ],
};

/// Descriptor for `User`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userDescriptor = $convert.base64Decode(
    'CgRVc2VyEg4KAmlkGAEgASgJUgJpZBIUCgVlbWFpbBgCIAEoCVIFZW1haWwSEgoEbmFtZRgDIA'
    'EoCVIEbmFtZRIUCgVwaG9uZRgEIAEoCVIFcGhvbmUSFAoFc3RhdGUYBSABKAlSBXN0YXRlEhYK'
    'Bm5hdGlvbhgGIAEoCVIGbmF0aW9uEh8KC2xvb2tpbmdfZm9yGAcgAygJUgpsb29raW5nRm9yEj'
    'EKFG9uYm9hcmRpbmdfY29tcGxldGVkGAggASgIUhNvbmJvYXJkaW5nQ29tcGxldGVkEh0KCmNy'
    'ZWF0ZWRfYXQYCSABKAlSCWNyZWF0ZWRBdA==');

@$core.Deprecated('Use userAuthCallbackRequestDescriptor instead')
const UserAuthCallbackRequest$json = {
  '1': 'UserAuthCallbackRequest',
  '2': [
    {'1': 'supabase_token', '3': 1, '4': 1, '5': 9, '10': 'supabaseToken'},
  ],
};

/// Descriptor for `UserAuthCallbackRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userAuthCallbackRequestDescriptor =
    $convert.base64Decode(
        'ChdVc2VyQXV0aENhbGxiYWNrUmVxdWVzdBIlCg5zdXBhYmFzZV90b2tlbhgBIAEoCVINc3VwYW'
        'Jhc2VUb2tlbg==');

@$core.Deprecated('Use userAuthCallbackResponseDescriptor instead')
const UserAuthCallbackResponse$json = {
  '1': 'UserAuthCallbackResponse',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
    {
      '1': 'onboarding_completed',
      '3': 3,
      '4': 1,
      '5': 8,
      '10': 'onboardingCompleted'
    },
    {'1': 'access_token', '3': 4, '4': 1, '5': 9, '10': 'accessToken'},
    {'1': 'refresh_token', '3': 5, '4': 1, '5': 9, '10': 'refreshToken'},
    {'1': 'expires_at', '3': 6, '4': 1, '5': 3, '10': 'expiresAt'},
  ],
};

/// Descriptor for `UserAuthCallbackResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userAuthCallbackResponseDescriptor = $convert.base64Decode(
    'ChhVc2VyQXV0aENhbGxiYWNrUmVzcG9uc2USFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEhYKBn'
    'N0YXR1cxgCIAEoCVIGc3RhdHVzEjEKFG9uYm9hcmRpbmdfY29tcGxldGVkGAMgASgIUhNvbmJv'
    'YXJkaW5nQ29tcGxldGVkEiEKDGFjY2Vzc190b2tlbhgEIAEoCVILYWNjZXNzVG9rZW4SIwoNcm'
    'VmcmVzaF90b2tlbhgFIAEoCVIMcmVmcmVzaFRva2VuEh0KCmV4cGlyZXNfYXQYBiABKANSCWV4'
    'cGlyZXNBdA==');

@$core.Deprecated('Use completeUserOnboardingRequestDescriptor instead')
const CompleteUserOnboardingRequest$json = {
  '1': 'CompleteUserOnboardingRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'phone', '3': 3, '4': 1, '5': 9, '10': 'phone'},
    {'1': 'state', '3': 4, '4': 1, '5': 9, '10': 'state'},
    {'1': 'nation', '3': 5, '4': 1, '5': 9, '10': 'nation'},
    {'1': 'looking_for', '3': 6, '4': 3, '5': 9, '10': 'lookingFor'},
  ],
};

/// Descriptor for `CompleteUserOnboardingRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List completeUserOnboardingRequestDescriptor = $convert.base64Decode(
    'Ch1Db21wbGV0ZVVzZXJPbmJvYXJkaW5nUmVxdWVzdBIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySW'
    'QSEgoEbmFtZRgCIAEoCVIEbmFtZRIUCgVwaG9uZRgDIAEoCVIFcGhvbmUSFAoFc3RhdGUYBCAB'
    'KAlSBXN0YXRlEhYKBm5hdGlvbhgFIAEoCVIGbmF0aW9uEh8KC2xvb2tpbmdfZm9yGAYgAygJUg'
    'psb29raW5nRm9y');

@$core.Deprecated('Use completeUserOnboardingResponseDescriptor instead')
const CompleteUserOnboardingResponse$json = {
  '1': 'CompleteUserOnboardingResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `CompleteUserOnboardingResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List completeUserOnboardingResponseDescriptor =
    $convert.base64Decode(
        'Ch5Db21wbGV0ZVVzZXJPbmJvYXJkaW5nUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2'
        'Vzcw==');

@$core.Deprecated('Use getUserProfileRequestDescriptor instead')
const GetUserProfileRequest$json = {
  '1': 'GetUserProfileRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `GetUserProfileRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserProfileRequestDescriptor =
    $convert.base64Decode(
        'ChVHZXRVc2VyUHJvZmlsZVJlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklk');

@$core.Deprecated('Use getUserProfileResponseDescriptor instead')
const GetUserProfileResponse$json = {
  '1': 'GetUserProfileResponse',
  '2': [
    {
      '1': 'user',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.therapist.User',
      '10': 'user'
    },
  ],
};

/// Descriptor for `GetUserProfileResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserProfileResponseDescriptor =
    $convert.base64Decode(
        'ChZHZXRVc2VyUHJvZmlsZVJlc3BvbnNlEiMKBHVzZXIYASABKAsyDy50aGVyYXBpc3QuVXNlcl'
        'IEdXNlcg==');

@$core.Deprecated('Use userRefreshSessionRequestDescriptor instead')
const UserRefreshSessionRequest$json = {
  '1': 'UserRefreshSessionRequest',
  '2': [
    {'1': 'refresh_token', '3': 1, '4': 1, '5': 9, '10': 'refreshToken'},
  ],
};

/// Descriptor for `UserRefreshSessionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userRefreshSessionRequestDescriptor =
    $convert.base64Decode(
        'ChlVc2VyUmVmcmVzaFNlc3Npb25SZXF1ZXN0EiMKDXJlZnJlc2hfdG9rZW4YASABKAlSDHJlZn'
        'Jlc2hUb2tlbg==');

@$core.Deprecated('Use userRefreshSessionResponseDescriptor instead')
const UserRefreshSessionResponse$json = {
  '1': 'UserRefreshSessionResponse',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
    {'1': 'access_token', '3': 3, '4': 1, '5': 9, '10': 'accessToken'},
    {'1': 'refresh_token', '3': 4, '4': 1, '5': 9, '10': 'refreshToken'},
    {'1': 'expires_at', '3': 5, '4': 1, '5': 3, '10': 'expiresAt'},
  ],
};

/// Descriptor for `UserRefreshSessionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userRefreshSessionResponseDescriptor = $convert.base64Decode(
    'ChpVc2VyUmVmcmVzaFNlc3Npb25SZXNwb25zZRIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSFg'
    'oGc3RhdHVzGAIgASgJUgZzdGF0dXMSIQoMYWNjZXNzX3Rva2VuGAMgASgJUgthY2Nlc3NUb2tl'
    'bhIjCg1yZWZyZXNoX3Rva2VuGAQgASgJUgxyZWZyZXNoVG9rZW4SHQoKZXhwaXJlc19hdBgFIA'
    'EoA1IJZXhwaXJlc0F0');

@$core.Deprecated('Use userLogoutRequestDescriptor instead')
const UserLogoutRequest$json = {
  '1': 'UserLogoutRequest',
  '2': [
    {'1': 'refresh_token', '3': 1, '4': 1, '5': 9, '10': 'refreshToken'},
  ],
};

/// Descriptor for `UserLogoutRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userLogoutRequestDescriptor = $convert.base64Decode(
    'ChFVc2VyTG9nb3V0UmVxdWVzdBIjCg1yZWZyZXNoX3Rva2VuGAEgASgJUgxyZWZyZXNoVG9rZW'
    '4=');

@$core.Deprecated('Use userLogoutResponseDescriptor instead')
const UserLogoutResponse$json = {
  '1': 'UserLogoutResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `UserLogoutResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userLogoutResponseDescriptor =
    $convert.base64Decode(
        'ChJVc2VyTG9nb3V0UmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2Vzcw==');

@$core.Deprecated('Use therapistCardDescriptor instead')
const TherapistCard$json = {
  '1': 'TherapistCard',
  '2': [
    {'1': 'therapist_id', '3': 1, '4': 1, '5': 9, '10': 'therapistId'},
    {'1': 'full_name', '3': 2, '4': 1, '5': 9, '10': 'fullName'},
    {'1': 'bio', '3': 3, '4': 1, '5': 9, '10': 'bio'},
    {'1': 'profile_photo', '3': 4, '4': 1, '5': 9, '10': 'profilePhoto'},
    {'1': 'specializations', '3': 5, '4': 3, '5': 9, '10': 'specializations'},
    {'1': 'session_fee', '3': 6, '4': 1, '5': 1, '10': 'sessionFee'},
    {'1': 'session_types', '3': 7, '4': 3, '5': 9, '10': 'sessionTypes'},
    {'1': 'rating', '3': 8, '4': 1, '5': 1, '10': 'rating'},
    {'1': 'total_sessions', '3': 9, '4': 1, '5': 5, '10': 'totalSessions'},
    {'1': 'state', '3': 10, '4': 1, '5': 9, '10': 'state'},
    {'1': 'nation', '3': 11, '4': 1, '5': 9, '10': 'nation'},
    {'1': 'address_text', '3': 12, '4': 1, '5': 9, '10': 'addressText'},
  ],
};

/// Descriptor for `TherapistCard`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List therapistCardDescriptor = $convert.base64Decode(
    'Cg1UaGVyYXBpc3RDYXJkEiEKDHRoZXJhcGlzdF9pZBgBIAEoCVILdGhlcmFwaXN0SWQSGwoJZn'
    'VsbF9uYW1lGAIgASgJUghmdWxsTmFtZRIQCgNiaW8YAyABKAlSA2JpbxIjCg1wcm9maWxlX3Bo'
    'b3RvGAQgASgJUgxwcm9maWxlUGhvdG8SKAoPc3BlY2lhbGl6YXRpb25zGAUgAygJUg9zcGVjaW'
    'FsaXphdGlvbnMSHwoLc2Vzc2lvbl9mZWUYBiABKAFSCnNlc3Npb25GZWUSIwoNc2Vzc2lvbl90'
    'eXBlcxgHIAMoCVIMc2Vzc2lvblR5cGVzEhYKBnJhdGluZxgIIAEoAVIGcmF0aW5nEiUKDnRvdG'
    'FsX3Nlc3Npb25zGAkgASgFUg10b3RhbFNlc3Npb25zEhQKBXN0YXRlGAogASgJUgVzdGF0ZRIW'
    'CgZuYXRpb24YCyABKAlSBm5hdGlvbhIhCgxhZGRyZXNzX3RleHQYDCABKAlSC2FkZHJlc3NUZX'
    'h0');

@$core.Deprecated('Use searchTherapistsRequestDescriptor instead')
const SearchTherapistsRequest$json = {
  '1': 'SearchTherapistsRequest',
  '2': [
    {'1': 'query', '3': 1, '4': 1, '5': 9, '10': 'query'},
    {'1': 'session_type', '3': 2, '4': 1, '5': 9, '10': 'sessionType'},
    {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    {'1': 'page_size', '3': 4, '4': 1, '5': 5, '10': 'pageSize'},
  ],
};

/// Descriptor for `SearchTherapistsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchTherapistsRequestDescriptor = $convert.base64Decode(
    'ChdTZWFyY2hUaGVyYXBpc3RzUmVxdWVzdBIUCgVxdWVyeRgBIAEoCVIFcXVlcnkSIQoMc2Vzc2'
    'lvbl90eXBlGAIgASgJUgtzZXNzaW9uVHlwZRISCgRwYWdlGAMgASgFUgRwYWdlEhsKCXBhZ2Vf'
    'c2l6ZRgEIAEoBVIIcGFnZVNpemU=');

@$core.Deprecated('Use searchTherapistsResponseDescriptor instead')
const SearchTherapistsResponse$json = {
  '1': 'SearchTherapistsResponse',
  '2': [
    {
      '1': 'therapists',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.therapist.TherapistCard',
      '10': 'therapists'
    },
    {'1': 'total', '3': 2, '4': 1, '5': 3, '10': 'total'},
  ],
};

/// Descriptor for `SearchTherapistsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchTherapistsResponseDescriptor =
    $convert.base64Decode(
        'ChhTZWFyY2hUaGVyYXBpc3RzUmVzcG9uc2USOAoKdGhlcmFwaXN0cxgBIAMoCzIYLnRoZXJhcG'
        'lzdC5UaGVyYXBpc3RDYXJkUgp0aGVyYXBpc3RzEhQKBXRvdGFsGAIgASgDUgV0b3RhbA==');

@$core.Deprecated('Use getRecommendedTherapistsRequestDescriptor instead')
const GetRecommendedTherapistsRequest$json = {
  '1': 'GetRecommendedTherapistsRequest',
  '2': [
    {'1': 'state', '3': 1, '4': 1, '5': 9, '10': 'state'},
    {'1': 'nation', '3': 2, '4': 1, '5': 9, '10': 'nation'},
    {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    {'1': 'page_size', '3': 4, '4': 1, '5': 5, '10': 'pageSize'},
  ],
};

/// Descriptor for `GetRecommendedTherapistsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getRecommendedTherapistsRequestDescriptor =
    $convert.base64Decode(
        'Ch9HZXRSZWNvbW1lbmRlZFRoZXJhcGlzdHNSZXF1ZXN0EhQKBXN0YXRlGAEgASgJUgVzdGF0ZR'
        'IWCgZuYXRpb24YAiABKAlSBm5hdGlvbhISCgRwYWdlGAMgASgFUgRwYWdlEhsKCXBhZ2Vfc2l6'
        'ZRgEIAEoBVIIcGFnZVNpemU=');

@$core.Deprecated('Use getRecommendedTherapistsResponseDescriptor instead')
const GetRecommendedTherapistsResponse$json = {
  '1': 'GetRecommendedTherapistsResponse',
  '2': [
    {
      '1': 'therapists',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.therapist.TherapistCard',
      '10': 'therapists'
    },
  ],
};

/// Descriptor for `GetRecommendedTherapistsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getRecommendedTherapistsResponseDescriptor =
    $convert.base64Decode(
        'CiBHZXRSZWNvbW1lbmRlZFRoZXJhcGlzdHNSZXNwb25zZRI4Cgp0aGVyYXBpc3RzGAEgAygLMh'
        'gudGhlcmFwaXN0LlRoZXJhcGlzdENhcmRSCnRoZXJhcGlzdHM=');
