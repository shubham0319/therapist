// This is a generated file - do not edit.
//
// Generated from proto/therapist.proto.

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

import 'blog.pb.dart' as $3;
import 'discovery.pb.dart' as $2;
import 'therapist.pb.dart' as $0;
import 'user.pb.dart' as $1;

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
  $grpc.ResponseFuture<$1.UserAuthCallbackResponse> userAuthCallback(
    $1.UserAuthCallbackRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$userAuthCallback, request, options: options);
  }

  /// Saves the user onboarding form.
  $grpc.ResponseFuture<$1.CompleteUserOnboardingResponse>
      completeUserOnboarding(
    $1.CompleteUserOnboardingRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$completeUserOnboarding, request,
        options: options);
  }

  /// Fetch the authenticated user's own profile.
  $grpc.ResponseFuture<$1.GetUserProfileResponse> getUserProfile(
    $1.GetUserProfileRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getUserProfile, request, options: options);
  }

  /// Exchange a user refresh token for a new access + refresh token pair.
  $grpc.ResponseFuture<$1.UserRefreshSessionResponse> userRefreshSession(
    $1.UserRefreshSessionRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$userRefreshSession, request, options: options);
  }

  /// Invalidate the user refresh token (log out this device).
  $grpc.ResponseFuture<$1.UserLogoutResponse> userLogout(
    $1.UserLogoutRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$userLogout, request, options: options);
  }

  /// ── Discovery (user-facing) ───────────────────────────────────────────────
  /// Full-text search across verified therapists.
  $grpc.ResponseFuture<$2.SearchTherapistsResponse> searchTherapists(
    $2.SearchTherapistsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$searchTherapists, request, options: options);
  }

  /// Location + rating-based recommendations for a user.
  $grpc.ResponseFuture<$2.GetRecommendedTherapistsResponse>
      getRecommendedTherapists(
    $2.GetRecommendedTherapistsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getRecommendedTherapists, request,
        options: options);
  }

  /// ── Blog ──────────────────────────────────────────────────────────────────
  /// Create a draft blog (verified therapists only).
  $grpc.ResponseFuture<$3.CreateBlogResponse> createBlog(
    $3.CreateBlogRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$createBlog, request, options: options);
  }

  /// Update a draft blog (owner only).
  $grpc.ResponseFuture<$3.UpdateBlogResponse> updateBlog(
    $3.UpdateBlogRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$updateBlog, request, options: options);
  }

  /// Publish a draft blog (owner only).
  $grpc.ResponseFuture<$3.PublishBlogResponse> publishBlog(
    $3.PublishBlogRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$publishBlog, request, options: options);
  }

  /// Delete a blog (owner only).
  $grpc.ResponseFuture<$3.DeleteBlogResponse> deleteBlog(
    $3.DeleteBlogRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$deleteBlog, request, options: options);
  }

  /// Fetch a single blog; increments view count for published blogs.
  $grpc.ResponseFuture<$3.GetBlogResponse> getBlog(
    $3.GetBlogRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getBlog, request, options: options);
  }

  /// List published blogs (optionally filtered by therapist).
  $grpc.ResponseFuture<$3.ListBlogsResponse> listBlogs(
    $3.ListBlogsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$listBlogs, request, options: options);
  }

  /// List all blogs (draft + published) for the authenticated therapist.
  $grpc.ResponseFuture<$3.ListMyBlogsResponse> listMyBlogs(
    $3.ListMyBlogsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$listMyBlogs, request, options: options);
  }

  /// Toggle like on a published blog.
  $grpc.ResponseFuture<$3.ToggleLikeBlogResponse> toggleLikeBlog(
    $3.ToggleLikeBlogRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$toggleLikeBlog, request, options: options);
  }

  /// Upload a single inline blog image (max 2 MB).
  $grpc.ResponseFuture<$3.UploadBlogImageResponse> uploadBlogImage(
    $3.UploadBlogImageRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$uploadBlogImage, request, options: options);
  }

  /// Toggle like on a published blog (user/client accounts).
  $grpc.ResponseFuture<$3.UserToggleLikeBlogResponse> userToggleLikeBlog(
    $3.UserToggleLikeBlogRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$userToggleLikeBlog, request, options: options);
  }

  /// ── Therapist profile (public) ────────────────────────────────────────────
  /// Fetch a single verified therapist's public profile card.
  $grpc.ResponseFuture<$2.GetTherapistProfileResponse> getTherapistProfile(
    $2.GetTherapistProfileRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getTherapistProfile, request, options: options);
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
          $1.UserAuthCallbackRequest, $1.UserAuthCallbackResponse>(
      '/therapist.TherapistService/UserAuthCallback',
      ($1.UserAuthCallbackRequest value) => value.writeToBuffer(),
      $1.UserAuthCallbackResponse.fromBuffer);
  static final _$completeUserOnboarding = $grpc.ClientMethod<
          $1.CompleteUserOnboardingRequest, $1.CompleteUserOnboardingResponse>(
      '/therapist.TherapistService/CompleteUserOnboarding',
      ($1.CompleteUserOnboardingRequest value) => value.writeToBuffer(),
      $1.CompleteUserOnboardingResponse.fromBuffer);
  static final _$getUserProfile =
      $grpc.ClientMethod<$1.GetUserProfileRequest, $1.GetUserProfileResponse>(
          '/therapist.TherapistService/GetUserProfile',
          ($1.GetUserProfileRequest value) => value.writeToBuffer(),
          $1.GetUserProfileResponse.fromBuffer);
  static final _$userRefreshSession = $grpc.ClientMethod<
          $1.UserRefreshSessionRequest, $1.UserRefreshSessionResponse>(
      '/therapist.TherapistService/UserRefreshSession',
      ($1.UserRefreshSessionRequest value) => value.writeToBuffer(),
      $1.UserRefreshSessionResponse.fromBuffer);
  static final _$userLogout =
      $grpc.ClientMethod<$1.UserLogoutRequest, $1.UserLogoutResponse>(
          '/therapist.TherapistService/UserLogout',
          ($1.UserLogoutRequest value) => value.writeToBuffer(),
          $1.UserLogoutResponse.fromBuffer);
  static final _$searchTherapists = $grpc.ClientMethod<
          $2.SearchTherapistsRequest, $2.SearchTherapistsResponse>(
      '/therapist.TherapistService/SearchTherapists',
      ($2.SearchTherapistsRequest value) => value.writeToBuffer(),
      $2.SearchTherapistsResponse.fromBuffer);
  static final _$getRecommendedTherapists = $grpc.ClientMethod<
          $2.GetRecommendedTherapistsRequest,
          $2.GetRecommendedTherapistsResponse>(
      '/therapist.TherapistService/GetRecommendedTherapists',
      ($2.GetRecommendedTherapistsRequest value) => value.writeToBuffer(),
      $2.GetRecommendedTherapistsResponse.fromBuffer);
  static final _$createBlog =
      $grpc.ClientMethod<$3.CreateBlogRequest, $3.CreateBlogResponse>(
          '/therapist.TherapistService/CreateBlog',
          ($3.CreateBlogRequest value) => value.writeToBuffer(),
          $3.CreateBlogResponse.fromBuffer);
  static final _$updateBlog =
      $grpc.ClientMethod<$3.UpdateBlogRequest, $3.UpdateBlogResponse>(
          '/therapist.TherapistService/UpdateBlog',
          ($3.UpdateBlogRequest value) => value.writeToBuffer(),
          $3.UpdateBlogResponse.fromBuffer);
  static final _$publishBlog =
      $grpc.ClientMethod<$3.PublishBlogRequest, $3.PublishBlogResponse>(
          '/therapist.TherapistService/PublishBlog',
          ($3.PublishBlogRequest value) => value.writeToBuffer(),
          $3.PublishBlogResponse.fromBuffer);
  static final _$deleteBlog =
      $grpc.ClientMethod<$3.DeleteBlogRequest, $3.DeleteBlogResponse>(
          '/therapist.TherapistService/DeleteBlog',
          ($3.DeleteBlogRequest value) => value.writeToBuffer(),
          $3.DeleteBlogResponse.fromBuffer);
  static final _$getBlog =
      $grpc.ClientMethod<$3.GetBlogRequest, $3.GetBlogResponse>(
          '/therapist.TherapistService/GetBlog',
          ($3.GetBlogRequest value) => value.writeToBuffer(),
          $3.GetBlogResponse.fromBuffer);
  static final _$listBlogs =
      $grpc.ClientMethod<$3.ListBlogsRequest, $3.ListBlogsResponse>(
          '/therapist.TherapistService/ListBlogs',
          ($3.ListBlogsRequest value) => value.writeToBuffer(),
          $3.ListBlogsResponse.fromBuffer);
  static final _$listMyBlogs =
      $grpc.ClientMethod<$3.ListMyBlogsRequest, $3.ListMyBlogsResponse>(
          '/therapist.TherapistService/ListMyBlogs',
          ($3.ListMyBlogsRequest value) => value.writeToBuffer(),
          $3.ListMyBlogsResponse.fromBuffer);
  static final _$toggleLikeBlog =
      $grpc.ClientMethod<$3.ToggleLikeBlogRequest, $3.ToggleLikeBlogResponse>(
          '/therapist.TherapistService/ToggleLikeBlog',
          ($3.ToggleLikeBlogRequest value) => value.writeToBuffer(),
          $3.ToggleLikeBlogResponse.fromBuffer);
  static final _$uploadBlogImage =
      $grpc.ClientMethod<$3.UploadBlogImageRequest, $3.UploadBlogImageResponse>(
          '/therapist.TherapistService/UploadBlogImage',
          ($3.UploadBlogImageRequest value) => value.writeToBuffer(),
          $3.UploadBlogImageResponse.fromBuffer);
  static final _$userToggleLikeBlog = $grpc.ClientMethod<
          $3.UserToggleLikeBlogRequest, $3.UserToggleLikeBlogResponse>(
      '/therapist.TherapistService/UserToggleLikeBlog',
      ($3.UserToggleLikeBlogRequest value) => value.writeToBuffer(),
      $3.UserToggleLikeBlogResponse.fromBuffer);
  static final _$getTherapistProfile = $grpc.ClientMethod<
          $2.GetTherapistProfileRequest, $2.GetTherapistProfileResponse>(
      '/therapist.TherapistService/GetTherapistProfile',
      ($2.GetTherapistProfileRequest value) => value.writeToBuffer(),
      $2.GetTherapistProfileResponse.fromBuffer);
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
    $addMethod($grpc.ServiceMethod<$1.UserAuthCallbackRequest,
            $1.UserAuthCallbackResponse>(
        'UserAuthCallback',
        userAuthCallback_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.UserAuthCallbackRequest.fromBuffer(value),
        ($1.UserAuthCallbackResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.CompleteUserOnboardingRequest,
            $1.CompleteUserOnboardingResponse>(
        'CompleteUserOnboarding',
        completeUserOnboarding_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.CompleteUserOnboardingRequest.fromBuffer(value),
        ($1.CompleteUserOnboardingResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetUserProfileRequest,
            $1.GetUserProfileResponse>(
        'GetUserProfile',
        getUserProfile_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetUserProfileRequest.fromBuffer(value),
        ($1.GetUserProfileResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.UserRefreshSessionRequest,
            $1.UserRefreshSessionResponse>(
        'UserRefreshSession',
        userRefreshSession_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.UserRefreshSessionRequest.fromBuffer(value),
        ($1.UserRefreshSessionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.UserLogoutRequest, $1.UserLogoutResponse>(
        'UserLogout',
        userLogout_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.UserLogoutRequest.fromBuffer(value),
        ($1.UserLogoutResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.SearchTherapistsRequest,
            $2.SearchTherapistsResponse>(
        'SearchTherapists',
        searchTherapists_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $2.SearchTherapistsRequest.fromBuffer(value),
        ($2.SearchTherapistsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.GetRecommendedTherapistsRequest,
            $2.GetRecommendedTherapistsResponse>(
        'GetRecommendedTherapists',
        getRecommendedTherapists_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $2.GetRecommendedTherapistsRequest.fromBuffer(value),
        ($2.GetRecommendedTherapistsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.CreateBlogRequest, $3.CreateBlogResponse>(
        'CreateBlog',
        createBlog_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $3.CreateBlogRequest.fromBuffer(value),
        ($3.CreateBlogResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.UpdateBlogRequest, $3.UpdateBlogResponse>(
        'UpdateBlog',
        updateBlog_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $3.UpdateBlogRequest.fromBuffer(value),
        ($3.UpdateBlogResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$3.PublishBlogRequest, $3.PublishBlogResponse>(
            'PublishBlog',
            publishBlog_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $3.PublishBlogRequest.fromBuffer(value),
            ($3.PublishBlogResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.DeleteBlogRequest, $3.DeleteBlogResponse>(
        'DeleteBlog',
        deleteBlog_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $3.DeleteBlogRequest.fromBuffer(value),
        ($3.DeleteBlogResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.GetBlogRequest, $3.GetBlogResponse>(
        'GetBlog',
        getBlog_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $3.GetBlogRequest.fromBuffer(value),
        ($3.GetBlogResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.ListBlogsRequest, $3.ListBlogsResponse>(
        'ListBlogs',
        listBlogs_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $3.ListBlogsRequest.fromBuffer(value),
        ($3.ListBlogsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$3.ListMyBlogsRequest, $3.ListMyBlogsResponse>(
            'ListMyBlogs',
            listMyBlogs_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $3.ListMyBlogsRequest.fromBuffer(value),
            ($3.ListMyBlogsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.ToggleLikeBlogRequest,
            $3.ToggleLikeBlogResponse>(
        'ToggleLikeBlog',
        toggleLikeBlog_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $3.ToggleLikeBlogRequest.fromBuffer(value),
        ($3.ToggleLikeBlogResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.UploadBlogImageRequest,
            $3.UploadBlogImageResponse>(
        'UploadBlogImage',
        uploadBlogImage_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $3.UploadBlogImageRequest.fromBuffer(value),
        ($3.UploadBlogImageResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.UserToggleLikeBlogRequest,
            $3.UserToggleLikeBlogResponse>(
        'UserToggleLikeBlog',
        userToggleLikeBlog_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $3.UserToggleLikeBlogRequest.fromBuffer(value),
        ($3.UserToggleLikeBlogResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.GetTherapistProfileRequest,
            $2.GetTherapistProfileResponse>(
        'GetTherapistProfile',
        getTherapistProfile_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $2.GetTherapistProfileRequest.fromBuffer(value),
        ($2.GetTherapistProfileResponse value) => value.writeToBuffer()));
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

  $async.Future<$1.UserAuthCallbackResponse> userAuthCallback_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$1.UserAuthCallbackRequest> $request) async {
    return userAuthCallback($call, await $request);
  }

  $async.Future<$1.UserAuthCallbackResponse> userAuthCallback(
      $grpc.ServiceCall call, $1.UserAuthCallbackRequest request);

  $async.Future<$1.CompleteUserOnboardingResponse> completeUserOnboarding_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$1.CompleteUserOnboardingRequest> $request) async {
    return completeUserOnboarding($call, await $request);
  }

  $async.Future<$1.CompleteUserOnboardingResponse> completeUserOnboarding(
      $grpc.ServiceCall call, $1.CompleteUserOnboardingRequest request);

  $async.Future<$1.GetUserProfileResponse> getUserProfile_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$1.GetUserProfileRequest> $request) async {
    return getUserProfile($call, await $request);
  }

  $async.Future<$1.GetUserProfileResponse> getUserProfile(
      $grpc.ServiceCall call, $1.GetUserProfileRequest request);

  $async.Future<$1.UserRefreshSessionResponse> userRefreshSession_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$1.UserRefreshSessionRequest> $request) async {
    return userRefreshSession($call, await $request);
  }

  $async.Future<$1.UserRefreshSessionResponse> userRefreshSession(
      $grpc.ServiceCall call, $1.UserRefreshSessionRequest request);

  $async.Future<$1.UserLogoutResponse> userLogout_Pre($grpc.ServiceCall $call,
      $async.Future<$1.UserLogoutRequest> $request) async {
    return userLogout($call, await $request);
  }

  $async.Future<$1.UserLogoutResponse> userLogout(
      $grpc.ServiceCall call, $1.UserLogoutRequest request);

  $async.Future<$2.SearchTherapistsResponse> searchTherapists_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$2.SearchTherapistsRequest> $request) async {
    return searchTherapists($call, await $request);
  }

  $async.Future<$2.SearchTherapistsResponse> searchTherapists(
      $grpc.ServiceCall call, $2.SearchTherapistsRequest request);

  $async.Future<$2.GetRecommendedTherapistsResponse>
      getRecommendedTherapists_Pre($grpc.ServiceCall $call,
          $async.Future<$2.GetRecommendedTherapistsRequest> $request) async {
    return getRecommendedTherapists($call, await $request);
  }

  $async.Future<$2.GetRecommendedTherapistsResponse> getRecommendedTherapists(
      $grpc.ServiceCall call, $2.GetRecommendedTherapistsRequest request);

  $async.Future<$3.CreateBlogResponse> createBlog_Pre($grpc.ServiceCall $call,
      $async.Future<$3.CreateBlogRequest> $request) async {
    return createBlog($call, await $request);
  }

  $async.Future<$3.CreateBlogResponse> createBlog(
      $grpc.ServiceCall call, $3.CreateBlogRequest request);

  $async.Future<$3.UpdateBlogResponse> updateBlog_Pre($grpc.ServiceCall $call,
      $async.Future<$3.UpdateBlogRequest> $request) async {
    return updateBlog($call, await $request);
  }

  $async.Future<$3.UpdateBlogResponse> updateBlog(
      $grpc.ServiceCall call, $3.UpdateBlogRequest request);

  $async.Future<$3.PublishBlogResponse> publishBlog_Pre($grpc.ServiceCall $call,
      $async.Future<$3.PublishBlogRequest> $request) async {
    return publishBlog($call, await $request);
  }

  $async.Future<$3.PublishBlogResponse> publishBlog(
      $grpc.ServiceCall call, $3.PublishBlogRequest request);

  $async.Future<$3.DeleteBlogResponse> deleteBlog_Pre($grpc.ServiceCall $call,
      $async.Future<$3.DeleteBlogRequest> $request) async {
    return deleteBlog($call, await $request);
  }

  $async.Future<$3.DeleteBlogResponse> deleteBlog(
      $grpc.ServiceCall call, $3.DeleteBlogRequest request);

  $async.Future<$3.GetBlogResponse> getBlog_Pre($grpc.ServiceCall $call,
      $async.Future<$3.GetBlogRequest> $request) async {
    return getBlog($call, await $request);
  }

  $async.Future<$3.GetBlogResponse> getBlog(
      $grpc.ServiceCall call, $3.GetBlogRequest request);

  $async.Future<$3.ListBlogsResponse> listBlogs_Pre($grpc.ServiceCall $call,
      $async.Future<$3.ListBlogsRequest> $request) async {
    return listBlogs($call, await $request);
  }

  $async.Future<$3.ListBlogsResponse> listBlogs(
      $grpc.ServiceCall call, $3.ListBlogsRequest request);

  $async.Future<$3.ListMyBlogsResponse> listMyBlogs_Pre($grpc.ServiceCall $call,
      $async.Future<$3.ListMyBlogsRequest> $request) async {
    return listMyBlogs($call, await $request);
  }

  $async.Future<$3.ListMyBlogsResponse> listMyBlogs(
      $grpc.ServiceCall call, $3.ListMyBlogsRequest request);

  $async.Future<$3.ToggleLikeBlogResponse> toggleLikeBlog_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$3.ToggleLikeBlogRequest> $request) async {
    return toggleLikeBlog($call, await $request);
  }

  $async.Future<$3.ToggleLikeBlogResponse> toggleLikeBlog(
      $grpc.ServiceCall call, $3.ToggleLikeBlogRequest request);

  $async.Future<$3.UploadBlogImageResponse> uploadBlogImage_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$3.UploadBlogImageRequest> $request) async {
    return uploadBlogImage($call, await $request);
  }

  $async.Future<$3.UploadBlogImageResponse> uploadBlogImage(
      $grpc.ServiceCall call, $3.UploadBlogImageRequest request);

  $async.Future<$3.UserToggleLikeBlogResponse> userToggleLikeBlog_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$3.UserToggleLikeBlogRequest> $request) async {
    return userToggleLikeBlog($call, await $request);
  }

  $async.Future<$3.UserToggleLikeBlogResponse> userToggleLikeBlog(
      $grpc.ServiceCall call, $3.UserToggleLikeBlogRequest request);

  $async.Future<$2.GetTherapistProfileResponse> getTherapistProfile_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$2.GetTherapistProfileRequest> $request) async {
    return getTherapistProfile($call, await $request);
  }

  $async.Future<$2.GetTherapistProfileResponse> getTherapistProfile(
      $grpc.ServiceCall call, $2.GetTherapistProfileRequest request);
}
