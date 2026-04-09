// This is a generated file - do not edit.
//
// Generated from therapist.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'therapist.pb.dart' as $0;

export 'therapist.pb.dart';

@$pb.GrpcServiceName('therapist.TherapistService')
class TherapistServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  TherapistServiceClient(super.channel, {super.options, super.interceptors});

  /// Called after Supabase auth. Upserts the therapist and returns their state.
  $grpc.ResponseFuture<$0.AuthCallbackResponse> authCallback(
    $0.AuthCallbackRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$authCallback, request, options: options);
  }

  /// Returns the current state for an already-authenticated therapist.
  $grpc.ResponseFuture<$0.GetStatusResponse> getStatus(
    $0.GetStatusRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getStatus, request, options: options);
  }

  /// Saves the full onboarding form (sets status = pending).
  $grpc.ResponseFuture<$0.CompleteOnboardingResponse> completeOnboarding(
    $0.CompleteOnboardingRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$completeOnboarding, request, options: options);
  }

  /// Admin: approve a therapist (generates referral ID, sets status = verified).
  $grpc.ResponseFuture<$0.ApproveTherapistResponse> approveTherapist(
    $0.ApproveTherapistRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$approveTherapist, request, options: options);
  }

  /// Admin: reject a therapist with an optional reason.
  $grpc.ResponseFuture<$0.RejectTherapistResponse> rejectTherapist(
    $0.RejectTherapistRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$rejectTherapist, request, options: options);
  }

  /// Upload a file (profile photo, degree certificate, government ID).
  /// Returns a URL string. Max 3 MB enforced server-side.
  $grpc.ResponseFuture<$0.UploadFileResponse> uploadFile(
    $0.UploadFileRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$uploadFile, request, options: options);
  }

  // method descriptors

  static final _$authCallback =
      $grpc.ClientMethod<$0.AuthCallbackRequest, $0.AuthCallbackResponse>(
          '/therapist.TherapistService/AuthCallback',
          ($0.AuthCallbackRequest value) => value.writeToBuffer(),
          $0.AuthCallbackResponse.fromBuffer);
  static final _$getStatus =
      $grpc.ClientMethod<$0.GetStatusRequest, $0.GetStatusResponse>(
          '/therapist.TherapistService/GetStatus',
          ($0.GetStatusRequest value) => value.writeToBuffer(),
          $0.GetStatusResponse.fromBuffer);
  static final _$completeOnboarding = $grpc.ClientMethod<
          $0.CompleteOnboardingRequest, $0.CompleteOnboardingResponse>(
      '/therapist.TherapistService/CompleteOnboarding',
      ($0.CompleteOnboardingRequest value) => value.writeToBuffer(),
      $0.CompleteOnboardingResponse.fromBuffer);
  static final _$approveTherapist = $grpc.ClientMethod<
          $0.ApproveTherapistRequest, $0.ApproveTherapistResponse>(
      '/therapist.TherapistService/ApproveTherapist',
      ($0.ApproveTherapistRequest value) => value.writeToBuffer(),
      $0.ApproveTherapistResponse.fromBuffer);
  static final _$rejectTherapist =
      $grpc.ClientMethod<$0.RejectTherapistRequest, $0.RejectTherapistResponse>(
          '/therapist.TherapistService/RejectTherapist',
          ($0.RejectTherapistRequest value) => value.writeToBuffer(),
          $0.RejectTherapistResponse.fromBuffer);
  static final _$uploadFile =
      $grpc.ClientMethod<$0.UploadFileRequest, $0.UploadFileResponse>(
          '/therapist.TherapistService/UploadFile',
          ($0.UploadFileRequest value) => value.writeToBuffer(),
          $0.UploadFileResponse.fromBuffer);
}

@$pb.GrpcServiceName('therapist.TherapistService')
abstract class TherapistServiceBase extends $grpc.Service {
  $core.String get $name => 'therapist.TherapistService';

  TherapistServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$0.AuthCallbackRequest, $0.AuthCallbackResponse>(
            'AuthCallback',
            authCallback_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.AuthCallbackRequest.fromBuffer(value),
            ($0.AuthCallbackResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetStatusRequest, $0.GetStatusResponse>(
        'GetStatus',
        getStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetStatusRequest.fromBuffer(value),
        ($0.GetStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CompleteOnboardingRequest,
            $0.CompleteOnboardingResponse>(
        'CompleteOnboarding',
        completeOnboarding_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CompleteOnboardingRequest.fromBuffer(value),
        ($0.CompleteOnboardingResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ApproveTherapistRequest,
            $0.ApproveTherapistResponse>(
        'ApproveTherapist',
        approveTherapist_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ApproveTherapistRequest.fromBuffer(value),
        ($0.ApproveTherapistResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RejectTherapistRequest,
            $0.RejectTherapistResponse>(
        'RejectTherapist',
        rejectTherapist_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.RejectTherapistRequest.fromBuffer(value),
        ($0.RejectTherapistResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UploadFileRequest, $0.UploadFileResponse>(
        'UploadFile',
        uploadFile_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UploadFileRequest.fromBuffer(value),
        ($0.UploadFileResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.AuthCallbackResponse> authCallback_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.AuthCallbackRequest> $request) async {
    return authCallback($call, await $request);
  }

  $async.Future<$0.AuthCallbackResponse> authCallback(
      $grpc.ServiceCall call, $0.AuthCallbackRequest request);

  $async.Future<$0.GetStatusResponse> getStatus_Pre($grpc.ServiceCall $call,
      $async.Future<$0.GetStatusRequest> $request) async {
    return getStatus($call, await $request);
  }

  $async.Future<$0.GetStatusResponse> getStatus(
      $grpc.ServiceCall call, $0.GetStatusRequest request);

  $async.Future<$0.CompleteOnboardingResponse> completeOnboarding_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.CompleteOnboardingRequest> $request) async {
    return completeOnboarding($call, await $request);
  }

  $async.Future<$0.CompleteOnboardingResponse> completeOnboarding(
      $grpc.ServiceCall call, $0.CompleteOnboardingRequest request);

  $async.Future<$0.ApproveTherapistResponse> approveTherapist_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ApproveTherapistRequest> $request) async {
    return approveTherapist($call, await $request);
  }

  $async.Future<$0.ApproveTherapistResponse> approveTherapist(
      $grpc.ServiceCall call, $0.ApproveTherapistRequest request);

  $async.Future<$0.RejectTherapistResponse> rejectTherapist_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.RejectTherapistRequest> $request) async {
    return rejectTherapist($call, await $request);
  }

  $async.Future<$0.RejectTherapistResponse> rejectTherapist(
      $grpc.ServiceCall call, $0.RejectTherapistRequest request);

  $async.Future<$0.UploadFileResponse> uploadFile_Pre($grpc.ServiceCall $call,
      $async.Future<$0.UploadFileRequest> $request) async {
    return uploadFile($call, await $request);
  }

  $async.Future<$0.UploadFileResponse> uploadFile(
      $grpc.ServiceCall call, $0.UploadFileRequest request);
}
