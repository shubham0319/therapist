// This is a generated file - do not edit.
//
// Generated from proto/user.proto.

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
