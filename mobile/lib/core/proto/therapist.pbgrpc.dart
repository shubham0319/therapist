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

  /// ── Therapist auth / onboarding ───────────────────────────────────────────
  /// Called after Supabase auth. Upserts the therapist and returns their state + tokens.
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

  /// Exchange a valid refresh token for a new access + refresh token pair.
  $grpc.ResponseFuture<$0.RefreshSessionResponse> refreshSession(
    $0.RefreshSessionRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$refreshSession, request, options: options);
  }

  /// Invalidate the refresh token (log out this device).
  $grpc.ResponseFuture<$0.LogoutResponse> logout(
    $0.LogoutRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$logout, request, options: options);
  }

  /// ── User (client/patient) auth / onboarding ───────────────────────────────
  /// Called after Supabase auth for users (clients looking for a therapist).
  $grpc.ResponseFuture<$0.UserAuthCallbackResponse> userAuthCallback(
    $0.UserAuthCallbackRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$userAuthCallback, request, options: options);
  }

  /// Saves the user onboarding form.
  $grpc.ResponseFuture<$0.CompleteUserOnboardingResponse>
      completeUserOnboarding(
    $0.CompleteUserOnboardingRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$completeUserOnboarding, request,
        options: options);
  }

  /// Fetch the authenticated user's own profile.
  $grpc.ResponseFuture<$0.GetUserProfileResponse> getUserProfile(
    $0.GetUserProfileRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getUserProfile, request, options: options);
  }

  /// Exchange a user refresh token for a new access + refresh token pair.
  $grpc.ResponseFuture<$0.UserRefreshSessionResponse> userRefreshSession(
    $0.UserRefreshSessionRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$userRefreshSession, request, options: options);
  }

  /// Invalidate the user refresh token (log out this device).
  $grpc.ResponseFuture<$0.UserLogoutResponse> userLogout(
    $0.UserLogoutRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$userLogout, request, options: options);
  }

  /// ── Discovery (user-facing) ───────────────────────────────────────────────
  /// Full-text search across verified therapists.
  $grpc.ResponseFuture<$0.SearchTherapistsResponse> searchTherapists(
    $0.SearchTherapistsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$searchTherapists, request, options: options);
  }

  /// Location + rating-based recommendations for a user.
  $grpc.ResponseFuture<$0.GetRecommendedTherapistsResponse>
      getRecommendedTherapists(
    $0.GetRecommendedTherapistsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getRecommendedTherapists, request,
        options: options);
  }

  /// ── Blog ──────────────────────────────────────────────────────────────────
  /// Create a draft blog (verified therapists only).
  $grpc.ResponseFuture<$0.CreateBlogResponse> createBlog(
    $0.CreateBlogRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$createBlog, request, options: options);
  }

  /// Update a draft blog (owner only).
  $grpc.ResponseFuture<$0.UpdateBlogResponse> updateBlog(
    $0.UpdateBlogRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$updateBlog, request, options: options);
  }

  /// Publish a draft blog (owner only).
  $grpc.ResponseFuture<$0.PublishBlogResponse> publishBlog(
    $0.PublishBlogRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$publishBlog, request, options: options);
  }

  /// Delete a blog (owner only).
  $grpc.ResponseFuture<$0.DeleteBlogResponse> deleteBlog(
    $0.DeleteBlogRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$deleteBlog, request, options: options);
  }

  /// Fetch a single blog; increments view count for published blogs.
  $grpc.ResponseFuture<$0.GetBlogResponse> getBlog(
    $0.GetBlogRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getBlog, request, options: options);
  }

  /// List published blogs (optionally filtered by therapist).
  $grpc.ResponseFuture<$0.ListBlogsResponse> listBlogs(
    $0.ListBlogsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$listBlogs, request, options: options);
  }

  /// List all blogs (draft + published) for the authenticated therapist.
  $grpc.ResponseFuture<$0.ListMyBlogsResponse> listMyBlogs(
    $0.ListMyBlogsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$listMyBlogs, request, options: options);
  }

  /// Toggle like on a published blog.
  $grpc.ResponseFuture<$0.ToggleLikeBlogResponse> toggleLikeBlog(
    $0.ToggleLikeBlogRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$toggleLikeBlog, request, options: options);
  }

  /// Upload a single inline blog image (max 2 MB).
  $grpc.ResponseFuture<$0.UploadBlogImageResponse> uploadBlogImage(
    $0.UploadBlogImageRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$uploadBlogImage, request, options: options);
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
  static final _$refreshSession =
      $grpc.ClientMethod<$0.RefreshSessionRequest, $0.RefreshSessionResponse>(
          '/therapist.TherapistService/RefreshSession',
          ($0.RefreshSessionRequest value) => value.writeToBuffer(),
          $0.RefreshSessionResponse.fromBuffer);
  static final _$logout =
      $grpc.ClientMethod<$0.LogoutRequest, $0.LogoutResponse>(
          '/therapist.TherapistService/Logout',
          ($0.LogoutRequest value) => value.writeToBuffer(),
          $0.LogoutResponse.fromBuffer);
  static final _$userAuthCallback = $grpc.ClientMethod<
          $0.UserAuthCallbackRequest, $0.UserAuthCallbackResponse>(
      '/therapist.TherapistService/UserAuthCallback',
      ($0.UserAuthCallbackRequest value) => value.writeToBuffer(),
      $0.UserAuthCallbackResponse.fromBuffer);
  static final _$completeUserOnboarding = $grpc.ClientMethod<
          $0.CompleteUserOnboardingRequest, $0.CompleteUserOnboardingResponse>(
      '/therapist.TherapistService/CompleteUserOnboarding',
      ($0.CompleteUserOnboardingRequest value) => value.writeToBuffer(),
      $0.CompleteUserOnboardingResponse.fromBuffer);
  static final _$getUserProfile =
      $grpc.ClientMethod<$0.GetUserProfileRequest, $0.GetUserProfileResponse>(
          '/therapist.TherapistService/GetUserProfile',
          ($0.GetUserProfileRequest value) => value.writeToBuffer(),
          $0.GetUserProfileResponse.fromBuffer);
  static final _$userRefreshSession = $grpc.ClientMethod<
          $0.UserRefreshSessionRequest, $0.UserRefreshSessionResponse>(
      '/therapist.TherapistService/UserRefreshSession',
      ($0.UserRefreshSessionRequest value) => value.writeToBuffer(),
      $0.UserRefreshSessionResponse.fromBuffer);
  static final _$userLogout =
      $grpc.ClientMethod<$0.UserLogoutRequest, $0.UserLogoutResponse>(
          '/therapist.TherapistService/UserLogout',
          ($0.UserLogoutRequest value) => value.writeToBuffer(),
          $0.UserLogoutResponse.fromBuffer);
  static final _$searchTherapists = $grpc.ClientMethod<
          $0.SearchTherapistsRequest, $0.SearchTherapistsResponse>(
      '/therapist.TherapistService/SearchTherapists',
      ($0.SearchTherapistsRequest value) => value.writeToBuffer(),
      $0.SearchTherapistsResponse.fromBuffer);
  static final _$getRecommendedTherapists = $grpc.ClientMethod<
          $0.GetRecommendedTherapistsRequest,
          $0.GetRecommendedTherapistsResponse>(
      '/therapist.TherapistService/GetRecommendedTherapists',
      ($0.GetRecommendedTherapistsRequest value) => value.writeToBuffer(),
      $0.GetRecommendedTherapistsResponse.fromBuffer);
  static final _$createBlog =
      $grpc.ClientMethod<$0.CreateBlogRequest, $0.CreateBlogResponse>(
          '/therapist.TherapistService/CreateBlog',
          ($0.CreateBlogRequest value) => value.writeToBuffer(),
          $0.CreateBlogResponse.fromBuffer);
  static final _$updateBlog =
      $grpc.ClientMethod<$0.UpdateBlogRequest, $0.UpdateBlogResponse>(
          '/therapist.TherapistService/UpdateBlog',
          ($0.UpdateBlogRequest value) => value.writeToBuffer(),
          $0.UpdateBlogResponse.fromBuffer);
  static final _$publishBlog =
      $grpc.ClientMethod<$0.PublishBlogRequest, $0.PublishBlogResponse>(
          '/therapist.TherapistService/PublishBlog',
          ($0.PublishBlogRequest value) => value.writeToBuffer(),
          $0.PublishBlogResponse.fromBuffer);
  static final _$deleteBlog =
      $grpc.ClientMethod<$0.DeleteBlogRequest, $0.DeleteBlogResponse>(
          '/therapist.TherapistService/DeleteBlog',
          ($0.DeleteBlogRequest value) => value.writeToBuffer(),
          $0.DeleteBlogResponse.fromBuffer);
  static final _$getBlog =
      $grpc.ClientMethod<$0.GetBlogRequest, $0.GetBlogResponse>(
          '/therapist.TherapistService/GetBlog',
          ($0.GetBlogRequest value) => value.writeToBuffer(),
          $0.GetBlogResponse.fromBuffer);
  static final _$listBlogs =
      $grpc.ClientMethod<$0.ListBlogsRequest, $0.ListBlogsResponse>(
          '/therapist.TherapistService/ListBlogs',
          ($0.ListBlogsRequest value) => value.writeToBuffer(),
          $0.ListBlogsResponse.fromBuffer);
  static final _$listMyBlogs =
      $grpc.ClientMethod<$0.ListMyBlogsRequest, $0.ListMyBlogsResponse>(
          '/therapist.TherapistService/ListMyBlogs',
          ($0.ListMyBlogsRequest value) => value.writeToBuffer(),
          $0.ListMyBlogsResponse.fromBuffer);
  static final _$toggleLikeBlog =
      $grpc.ClientMethod<$0.ToggleLikeBlogRequest, $0.ToggleLikeBlogResponse>(
          '/therapist.TherapistService/ToggleLikeBlog',
          ($0.ToggleLikeBlogRequest value) => value.writeToBuffer(),
          $0.ToggleLikeBlogResponse.fromBuffer);
  static final _$uploadBlogImage =
      $grpc.ClientMethod<$0.UploadBlogImageRequest, $0.UploadBlogImageResponse>(
          '/therapist.TherapistService/UploadBlogImage',
          ($0.UploadBlogImageRequest value) => value.writeToBuffer(),
          $0.UploadBlogImageResponse.fromBuffer);
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
    $addMethod($grpc.ServiceMethod<$0.RefreshSessionRequest,
            $0.RefreshSessionResponse>(
        'RefreshSession',
        refreshSession_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.RefreshSessionRequest.fromBuffer(value),
        ($0.RefreshSessionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.LogoutRequest, $0.LogoutResponse>(
        'Logout',
        logout_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.LogoutRequest.fromBuffer(value),
        ($0.LogoutResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UserAuthCallbackRequest,
            $0.UserAuthCallbackResponse>(
        'UserAuthCallback',
        userAuthCallback_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UserAuthCallbackRequest.fromBuffer(value),
        ($0.UserAuthCallbackResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CompleteUserOnboardingRequest,
            $0.CompleteUserOnboardingResponse>(
        'CompleteUserOnboarding',
        completeUserOnboarding_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CompleteUserOnboardingRequest.fromBuffer(value),
        ($0.CompleteUserOnboardingResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetUserProfileRequest,
            $0.GetUserProfileResponse>(
        'GetUserProfile',
        getUserProfile_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetUserProfileRequest.fromBuffer(value),
        ($0.GetUserProfileResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UserRefreshSessionRequest,
            $0.UserRefreshSessionResponse>(
        'UserRefreshSession',
        userRefreshSession_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UserRefreshSessionRequest.fromBuffer(value),
        ($0.UserRefreshSessionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UserLogoutRequest, $0.UserLogoutResponse>(
        'UserLogout',
        userLogout_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UserLogoutRequest.fromBuffer(value),
        ($0.UserLogoutResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SearchTherapistsRequest,
            $0.SearchTherapistsResponse>(
        'SearchTherapists',
        searchTherapists_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.SearchTherapistsRequest.fromBuffer(value),
        ($0.SearchTherapistsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetRecommendedTherapistsRequest,
            $0.GetRecommendedTherapistsResponse>(
        'GetRecommendedTherapists',
        getRecommendedTherapists_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetRecommendedTherapistsRequest.fromBuffer(value),
        ($0.GetRecommendedTherapistsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateBlogRequest, $0.CreateBlogResponse>(
        'CreateBlog',
        createBlog_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CreateBlogRequest.fromBuffer(value),
        ($0.CreateBlogResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateBlogRequest, $0.UpdateBlogResponse>(
        'UpdateBlog',
        updateBlog_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UpdateBlogRequest.fromBuffer(value),
        ($0.UpdateBlogResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.PublishBlogRequest, $0.PublishBlogResponse>(
            'PublishBlog',
            publishBlog_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.PublishBlogRequest.fromBuffer(value),
            ($0.PublishBlogResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeleteBlogRequest, $0.DeleteBlogResponse>(
        'DeleteBlog',
        deleteBlog_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.DeleteBlogRequest.fromBuffer(value),
        ($0.DeleteBlogResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetBlogRequest, $0.GetBlogResponse>(
        'GetBlog',
        getBlog_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetBlogRequest.fromBuffer(value),
        ($0.GetBlogResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListBlogsRequest, $0.ListBlogsResponse>(
        'ListBlogs',
        listBlogs_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ListBlogsRequest.fromBuffer(value),
        ($0.ListBlogsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.ListMyBlogsRequest, $0.ListMyBlogsResponse>(
            'ListMyBlogs',
            listMyBlogs_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.ListMyBlogsRequest.fromBuffer(value),
            ($0.ListMyBlogsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ToggleLikeBlogRequest,
            $0.ToggleLikeBlogResponse>(
        'ToggleLikeBlog',
        toggleLikeBlog_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ToggleLikeBlogRequest.fromBuffer(value),
        ($0.ToggleLikeBlogResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UploadBlogImageRequest,
            $0.UploadBlogImageResponse>(
        'UploadBlogImage',
        uploadBlogImage_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UploadBlogImageRequest.fromBuffer(value),
        ($0.UploadBlogImageResponse value) => value.writeToBuffer()));
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

  $async.Future<$0.RefreshSessionResponse> refreshSession_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.RefreshSessionRequest> $request) async {
    return refreshSession($call, await $request);
  }

  $async.Future<$0.RefreshSessionResponse> refreshSession(
      $grpc.ServiceCall call, $0.RefreshSessionRequest request);

  $async.Future<$0.LogoutResponse> logout_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.LogoutRequest> $request) async {
    return logout($call, await $request);
  }

  $async.Future<$0.LogoutResponse> logout(
      $grpc.ServiceCall call, $0.LogoutRequest request);

  $async.Future<$0.UserAuthCallbackResponse> userAuthCallback_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.UserAuthCallbackRequest> $request) async {
    return userAuthCallback($call, await $request);
  }

  $async.Future<$0.UserAuthCallbackResponse> userAuthCallback(
      $grpc.ServiceCall call, $0.UserAuthCallbackRequest request);

  $async.Future<$0.CompleteUserOnboardingResponse> completeUserOnboarding_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.CompleteUserOnboardingRequest> $request) async {
    return completeUserOnboarding($call, await $request);
  }

  $async.Future<$0.CompleteUserOnboardingResponse> completeUserOnboarding(
      $grpc.ServiceCall call, $0.CompleteUserOnboardingRequest request);

  $async.Future<$0.GetUserProfileResponse> getUserProfile_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetUserProfileRequest> $request) async {
    return getUserProfile($call, await $request);
  }

  $async.Future<$0.GetUserProfileResponse> getUserProfile(
      $grpc.ServiceCall call, $0.GetUserProfileRequest request);

  $async.Future<$0.UserRefreshSessionResponse> userRefreshSession_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.UserRefreshSessionRequest> $request) async {
    return userRefreshSession($call, await $request);
  }

  $async.Future<$0.UserRefreshSessionResponse> userRefreshSession(
      $grpc.ServiceCall call, $0.UserRefreshSessionRequest request);

  $async.Future<$0.UserLogoutResponse> userLogout_Pre($grpc.ServiceCall $call,
      $async.Future<$0.UserLogoutRequest> $request) async {
    return userLogout($call, await $request);
  }

  $async.Future<$0.UserLogoutResponse> userLogout(
      $grpc.ServiceCall call, $0.UserLogoutRequest request);

  $async.Future<$0.SearchTherapistsResponse> searchTherapists_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.SearchTherapistsRequest> $request) async {
    return searchTherapists($call, await $request);
  }

  $async.Future<$0.SearchTherapistsResponse> searchTherapists(
      $grpc.ServiceCall call, $0.SearchTherapistsRequest request);

  $async.Future<$0.GetRecommendedTherapistsResponse>
      getRecommendedTherapists_Pre($grpc.ServiceCall $call,
          $async.Future<$0.GetRecommendedTherapistsRequest> $request) async {
    return getRecommendedTherapists($call, await $request);
  }

  $async.Future<$0.GetRecommendedTherapistsResponse> getRecommendedTherapists(
      $grpc.ServiceCall call, $0.GetRecommendedTherapistsRequest request);

  $async.Future<$0.CreateBlogResponse> createBlog_Pre($grpc.ServiceCall $call,
      $async.Future<$0.CreateBlogRequest> $request) async {
    return createBlog($call, await $request);
  }

  $async.Future<$0.CreateBlogResponse> createBlog(
      $grpc.ServiceCall call, $0.CreateBlogRequest request);

  $async.Future<$0.UpdateBlogResponse> updateBlog_Pre($grpc.ServiceCall $call,
      $async.Future<$0.UpdateBlogRequest> $request) async {
    return updateBlog($call, await $request);
  }

  $async.Future<$0.UpdateBlogResponse> updateBlog(
      $grpc.ServiceCall call, $0.UpdateBlogRequest request);

  $async.Future<$0.PublishBlogResponse> publishBlog_Pre($grpc.ServiceCall $call,
      $async.Future<$0.PublishBlogRequest> $request) async {
    return publishBlog($call, await $request);
  }

  $async.Future<$0.PublishBlogResponse> publishBlog(
      $grpc.ServiceCall call, $0.PublishBlogRequest request);

  $async.Future<$0.DeleteBlogResponse> deleteBlog_Pre($grpc.ServiceCall $call,
      $async.Future<$0.DeleteBlogRequest> $request) async {
    return deleteBlog($call, await $request);
  }

  $async.Future<$0.DeleteBlogResponse> deleteBlog(
      $grpc.ServiceCall call, $0.DeleteBlogRequest request);

  $async.Future<$0.GetBlogResponse> getBlog_Pre($grpc.ServiceCall $call,
      $async.Future<$0.GetBlogRequest> $request) async {
    return getBlog($call, await $request);
  }

  $async.Future<$0.GetBlogResponse> getBlog(
      $grpc.ServiceCall call, $0.GetBlogRequest request);

  $async.Future<$0.ListBlogsResponse> listBlogs_Pre($grpc.ServiceCall $call,
      $async.Future<$0.ListBlogsRequest> $request) async {
    return listBlogs($call, await $request);
  }

  $async.Future<$0.ListBlogsResponse> listBlogs(
      $grpc.ServiceCall call, $0.ListBlogsRequest request);

  $async.Future<$0.ListMyBlogsResponse> listMyBlogs_Pre($grpc.ServiceCall $call,
      $async.Future<$0.ListMyBlogsRequest> $request) async {
    return listMyBlogs($call, await $request);
  }

  $async.Future<$0.ListMyBlogsResponse> listMyBlogs(
      $grpc.ServiceCall call, $0.ListMyBlogsRequest request);

  $async.Future<$0.ToggleLikeBlogResponse> toggleLikeBlog_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ToggleLikeBlogRequest> $request) async {
    return toggleLikeBlog($call, await $request);
  }

  $async.Future<$0.ToggleLikeBlogResponse> toggleLikeBlog(
      $grpc.ServiceCall call, $0.ToggleLikeBlogRequest request);

  $async.Future<$0.UploadBlogImageResponse> uploadBlogImage_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.UploadBlogImageRequest> $request) async {
    return uploadBlogImage($call, await $request);
  }

  $async.Future<$0.UploadBlogImageResponse> uploadBlogImage(
      $grpc.ServiceCall call, $0.UploadBlogImageRequest request);
}
