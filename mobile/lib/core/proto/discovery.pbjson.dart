// This is a generated file - do not edit.
//
// Generated from proto/discovery.proto.

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

@$core.Deprecated('Use getTherapistProfileRequestDescriptor instead')
const GetTherapistProfileRequest$json = {
  '1': 'GetTherapistProfileRequest',
  '2': [
    {'1': 'therapist_id', '3': 1, '4': 1, '5': 9, '10': 'therapistId'},
  ],
};

/// Descriptor for `GetTherapistProfileRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTherapistProfileRequestDescriptor =
    $convert.base64Decode(
        'ChpHZXRUaGVyYXBpc3RQcm9maWxlUmVxdWVzdBIhCgx0aGVyYXBpc3RfaWQYASABKAlSC3RoZX'
        'JhcGlzdElk');

@$core.Deprecated('Use getTherapistProfileResponseDescriptor instead')
const GetTherapistProfileResponse$json = {
  '1': 'GetTherapistProfileResponse',
  '2': [
    {
      '1': 'therapist',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.therapist.TherapistCard',
      '10': 'therapist'
    },
  ],
};

/// Descriptor for `GetTherapistProfileResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTherapistProfileResponseDescriptor =
    $convert.base64Decode(
        'ChtHZXRUaGVyYXBpc3RQcm9maWxlUmVzcG9uc2USNgoJdGhlcmFwaXN0GAEgASgLMhgudGhlcm'
        'FwaXN0LlRoZXJhcGlzdENhcmRSCXRoZXJhcGlzdA==');
