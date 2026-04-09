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
  ],
};

/// Descriptor for `AuthCallbackResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List authCallbackResponseDescriptor = $convert.base64Decode(
    'ChRBdXRoQ2FsbGJhY2tSZXNwb25zZRIhCgx0aGVyYXBpc3RfaWQYASABKAlSC3RoZXJhcGlzdE'
    'lkEhYKBnN0YXR1cxgCIAEoCVIGc3RhdHVzEjEKFG9uYm9hcmRpbmdfY29tcGxldGVkGAMgASgI'
    'UhNvbmJvYXJkaW5nQ29tcGxldGVkEh8KC3JlZmVycmFsX2lkGAQgASgJUgpyZWZlcnJhbElkEi'
    'kKEHJlamVjdGlvbl9yZWFzb24YBSABKAlSD3JlamVjdGlvblJlYXNvbg==');

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
    'ZBgPIAEoCVIMZ292ZXJubWVudElk');

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
