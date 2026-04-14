// This is a generated file - do not edit.
//
// Generated from proto/blog.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'blog.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'blog.pbenum.dart';

class Blog extends $pb.GeneratedMessage {
  factory Blog({
    $core.String? id,
    $core.String? therapistId,
    $core.String? title,
    $core.String? slug,
    $core.String? coverImageUrl,
    $core.String? content,
    $core.Iterable<$core.String>? imageUrls,
    BlogStatus? status,
    $fixnum.Int64? views,
    $fixnum.Int64? likes,
    $core.bool? likedByMe,
    $core.String? createdAt,
    $core.String? updatedAt,
    $core.String? publishedAt,
    $core.Iterable<$core.String>? tags,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (therapistId != null) result.therapistId = therapistId;
    if (title != null) result.title = title;
    if (slug != null) result.slug = slug;
    if (coverImageUrl != null) result.coverImageUrl = coverImageUrl;
    if (content != null) result.content = content;
    if (imageUrls != null) result.imageUrls.addAll(imageUrls);
    if (status != null) result.status = status;
    if (views != null) result.views = views;
    if (likes != null) result.likes = likes;
    if (likedByMe != null) result.likedByMe = likedByMe;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    if (publishedAt != null) result.publishedAt = publishedAt;
    if (tags != null) result.tags.addAll(tags);
    return result;
  }

  Blog._();

  factory Blog.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Blog.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Blog',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'therapist'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'therapistId')
    ..aOS(3, _omitFieldNames ? '' : 'title')
    ..aOS(4, _omitFieldNames ? '' : 'slug')
    ..aOS(5, _omitFieldNames ? '' : 'coverImageUrl')
    ..aOS(6, _omitFieldNames ? '' : 'content')
    ..pPS(7, _omitFieldNames ? '' : 'imageUrls')
    ..aE<BlogStatus>(8, _omitFieldNames ? '' : 'status',
        enumValues: BlogStatus.values)
    ..aInt64(9, _omitFieldNames ? '' : 'views')
    ..aInt64(10, _omitFieldNames ? '' : 'likes')
    ..aOB(11, _omitFieldNames ? '' : 'likedByMe')
    ..aOS(12, _omitFieldNames ? '' : 'createdAt')
    ..aOS(13, _omitFieldNames ? '' : 'updatedAt')
    ..aOS(14, _omitFieldNames ? '' : 'publishedAt')
    ..pPS(15, _omitFieldNames ? '' : 'tags')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Blog clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Blog copyWith(void Function(Blog) updates) =>
      super.copyWith((message) => updates(message as Blog)) as Blog;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Blog create() => Blog._();
  @$core.override
  Blog createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Blog getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Blog>(create);
  static Blog? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get therapistId => $_getSZ(1);
  @$pb.TagNumber(2)
  set therapistId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTherapistId() => $_has(1);
  @$pb.TagNumber(2)
  void clearTherapistId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get title => $_getSZ(2);
  @$pb.TagNumber(3)
  set title($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTitle() => $_has(2);
  @$pb.TagNumber(3)
  void clearTitle() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get slug => $_getSZ(3);
  @$pb.TagNumber(4)
  set slug($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSlug() => $_has(3);
  @$pb.TagNumber(4)
  void clearSlug() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get coverImageUrl => $_getSZ(4);
  @$pb.TagNumber(5)
  set coverImageUrl($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCoverImageUrl() => $_has(4);
  @$pb.TagNumber(5)
  void clearCoverImageUrl() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get content => $_getSZ(5);
  @$pb.TagNumber(6)
  set content($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasContent() => $_has(5);
  @$pb.TagNumber(6)
  void clearContent() => $_clearField(6);

  @$pb.TagNumber(7)
  $pb.PbList<$core.String> get imageUrls => $_getList(6);

  @$pb.TagNumber(8)
  BlogStatus get status => $_getN(7);
  @$pb.TagNumber(8)
  set status(BlogStatus value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasStatus() => $_has(7);
  @$pb.TagNumber(8)
  void clearStatus() => $_clearField(8);

  @$pb.TagNumber(9)
  $fixnum.Int64 get views => $_getI64(8);
  @$pb.TagNumber(9)
  set views($fixnum.Int64 value) => $_setInt64(8, value);
  @$pb.TagNumber(9)
  $core.bool hasViews() => $_has(8);
  @$pb.TagNumber(9)
  void clearViews() => $_clearField(9);

  @$pb.TagNumber(10)
  $fixnum.Int64 get likes => $_getI64(9);
  @$pb.TagNumber(10)
  set likes($fixnum.Int64 value) => $_setInt64(9, value);
  @$pb.TagNumber(10)
  $core.bool hasLikes() => $_has(9);
  @$pb.TagNumber(10)
  void clearLikes() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.bool get likedByMe => $_getBF(10);
  @$pb.TagNumber(11)
  set likedByMe($core.bool value) => $_setBool(10, value);
  @$pb.TagNumber(11)
  $core.bool hasLikedByMe() => $_has(10);
  @$pb.TagNumber(11)
  void clearLikedByMe() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get createdAt => $_getSZ(11);
  @$pb.TagNumber(12)
  set createdAt($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasCreatedAt() => $_has(11);
  @$pb.TagNumber(12)
  void clearCreatedAt() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get updatedAt => $_getSZ(12);
  @$pb.TagNumber(13)
  set updatedAt($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasUpdatedAt() => $_has(12);
  @$pb.TagNumber(13)
  void clearUpdatedAt() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get publishedAt => $_getSZ(13);
  @$pb.TagNumber(14)
  set publishedAt($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasPublishedAt() => $_has(13);
  @$pb.TagNumber(14)
  void clearPublishedAt() => $_clearField(14);

  @$pb.TagNumber(15)
  $pb.PbList<$core.String> get tags => $_getList(14);
}

/// CreateBlog — verified therapists only; creates a draft.
class CreateBlogRequest extends $pb.GeneratedMessage {
  factory CreateBlogRequest({
    $core.String? therapistId,
    $core.String? title,
    $core.String? content,
    $core.String? coverImageUrl,
    $core.Iterable<$core.String>? imageUrls,
    $core.Iterable<$core.String>? tags,
  }) {
    final result = create();
    if (therapistId != null) result.therapistId = therapistId;
    if (title != null) result.title = title;
    if (content != null) result.content = content;
    if (coverImageUrl != null) result.coverImageUrl = coverImageUrl;
    if (imageUrls != null) result.imageUrls.addAll(imageUrls);
    if (tags != null) result.tags.addAll(tags);
    return result;
  }

  CreateBlogRequest._();

  factory CreateBlogRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateBlogRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateBlogRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'therapist'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'therapistId')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..aOS(3, _omitFieldNames ? '' : 'content')
    ..aOS(4, _omitFieldNames ? '' : 'coverImageUrl')
    ..pPS(5, _omitFieldNames ? '' : 'imageUrls')
    ..pPS(6, _omitFieldNames ? '' : 'tags')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateBlogRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateBlogRequest copyWith(void Function(CreateBlogRequest) updates) =>
      super.copyWith((message) => updates(message as CreateBlogRequest))
          as CreateBlogRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateBlogRequest create() => CreateBlogRequest._();
  @$core.override
  CreateBlogRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CreateBlogRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateBlogRequest>(create);
  static CreateBlogRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get therapistId => $_getSZ(0);
  @$pb.TagNumber(1)
  set therapistId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTherapistId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTherapistId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get content => $_getSZ(2);
  @$pb.TagNumber(3)
  set content($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasContent() => $_has(2);
  @$pb.TagNumber(3)
  void clearContent() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get coverImageUrl => $_getSZ(3);
  @$pb.TagNumber(4)
  set coverImageUrl($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCoverImageUrl() => $_has(3);
  @$pb.TagNumber(4)
  void clearCoverImageUrl() => $_clearField(4);

  @$pb.TagNumber(5)
  $pb.PbList<$core.String> get imageUrls => $_getList(4);

  @$pb.TagNumber(6)
  $pb.PbList<$core.String> get tags => $_getList(5);
}

class CreateBlogResponse extends $pb.GeneratedMessage {
  factory CreateBlogResponse({
    Blog? blog,
  }) {
    final result = create();
    if (blog != null) result.blog = blog;
    return result;
  }

  CreateBlogResponse._();

  factory CreateBlogResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateBlogResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateBlogResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'therapist'),
      createEmptyInstance: create)
    ..aOM<Blog>(1, _omitFieldNames ? '' : 'blog', subBuilder: Blog.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateBlogResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateBlogResponse copyWith(void Function(CreateBlogResponse) updates) =>
      super.copyWith((message) => updates(message as CreateBlogResponse))
          as CreateBlogResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateBlogResponse create() => CreateBlogResponse._();
  @$core.override
  CreateBlogResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CreateBlogResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateBlogResponse>(create);
  static CreateBlogResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Blog get blog => $_getN(0);
  @$pb.TagNumber(1)
  set blog(Blog value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasBlog() => $_has(0);
  @$pb.TagNumber(1)
  void clearBlog() => $_clearField(1);
  @$pb.TagNumber(1)
  Blog ensureBlog() => $_ensure(0);
}

/// UpdateBlog — own draft only.
class UpdateBlogRequest extends $pb.GeneratedMessage {
  factory UpdateBlogRequest({
    $core.String? therapistId,
    $core.String? blogId,
    $core.String? title,
    $core.String? content,
    $core.String? coverImageUrl,
    $core.Iterable<$core.String>? imageUrls,
    $core.Iterable<$core.String>? tags,
  }) {
    final result = create();
    if (therapistId != null) result.therapistId = therapistId;
    if (blogId != null) result.blogId = blogId;
    if (title != null) result.title = title;
    if (content != null) result.content = content;
    if (coverImageUrl != null) result.coverImageUrl = coverImageUrl;
    if (imageUrls != null) result.imageUrls.addAll(imageUrls);
    if (tags != null) result.tags.addAll(tags);
    return result;
  }

  UpdateBlogRequest._();

  factory UpdateBlogRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateBlogRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateBlogRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'therapist'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'therapistId')
    ..aOS(2, _omitFieldNames ? '' : 'blogId')
    ..aOS(3, _omitFieldNames ? '' : 'title')
    ..aOS(4, _omitFieldNames ? '' : 'content')
    ..aOS(5, _omitFieldNames ? '' : 'coverImageUrl')
    ..pPS(6, _omitFieldNames ? '' : 'imageUrls')
    ..pPS(7, _omitFieldNames ? '' : 'tags')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateBlogRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateBlogRequest copyWith(void Function(UpdateBlogRequest) updates) =>
      super.copyWith((message) => updates(message as UpdateBlogRequest))
          as UpdateBlogRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateBlogRequest create() => UpdateBlogRequest._();
  @$core.override
  UpdateBlogRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UpdateBlogRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateBlogRequest>(create);
  static UpdateBlogRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get therapistId => $_getSZ(0);
  @$pb.TagNumber(1)
  set therapistId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTherapistId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTherapistId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get blogId => $_getSZ(1);
  @$pb.TagNumber(2)
  set blogId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBlogId() => $_has(1);
  @$pb.TagNumber(2)
  void clearBlogId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get title => $_getSZ(2);
  @$pb.TagNumber(3)
  set title($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTitle() => $_has(2);
  @$pb.TagNumber(3)
  void clearTitle() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get content => $_getSZ(3);
  @$pb.TagNumber(4)
  set content($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasContent() => $_has(3);
  @$pb.TagNumber(4)
  void clearContent() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get coverImageUrl => $_getSZ(4);
  @$pb.TagNumber(5)
  set coverImageUrl($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCoverImageUrl() => $_has(4);
  @$pb.TagNumber(5)
  void clearCoverImageUrl() => $_clearField(5);

  @$pb.TagNumber(6)
  $pb.PbList<$core.String> get imageUrls => $_getList(5);

  @$pb.TagNumber(7)
  $pb.PbList<$core.String> get tags => $_getList(6);
}

class UpdateBlogResponse extends $pb.GeneratedMessage {
  factory UpdateBlogResponse({
    Blog? blog,
  }) {
    final result = create();
    if (blog != null) result.blog = blog;
    return result;
  }

  UpdateBlogResponse._();

  factory UpdateBlogResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateBlogResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateBlogResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'therapist'),
      createEmptyInstance: create)
    ..aOM<Blog>(1, _omitFieldNames ? '' : 'blog', subBuilder: Blog.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateBlogResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateBlogResponse copyWith(void Function(UpdateBlogResponse) updates) =>
      super.copyWith((message) => updates(message as UpdateBlogResponse))
          as UpdateBlogResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateBlogResponse create() => UpdateBlogResponse._();
  @$core.override
  UpdateBlogResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UpdateBlogResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateBlogResponse>(create);
  static UpdateBlogResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Blog get blog => $_getN(0);
  @$pb.TagNumber(1)
  set blog(Blog value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasBlog() => $_has(0);
  @$pb.TagNumber(1)
  void clearBlog() => $_clearField(1);
  @$pb.TagNumber(1)
  Blog ensureBlog() => $_ensure(0);
}

/// PublishBlog — move draft → published.
class PublishBlogRequest extends $pb.GeneratedMessage {
  factory PublishBlogRequest({
    $core.String? therapistId,
    $core.String? blogId,
  }) {
    final result = create();
    if (therapistId != null) result.therapistId = therapistId;
    if (blogId != null) result.blogId = blogId;
    return result;
  }

  PublishBlogRequest._();

  factory PublishBlogRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PublishBlogRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PublishBlogRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'therapist'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'therapistId')
    ..aOS(2, _omitFieldNames ? '' : 'blogId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PublishBlogRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PublishBlogRequest copyWith(void Function(PublishBlogRequest) updates) =>
      super.copyWith((message) => updates(message as PublishBlogRequest))
          as PublishBlogRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PublishBlogRequest create() => PublishBlogRequest._();
  @$core.override
  PublishBlogRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static PublishBlogRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PublishBlogRequest>(create);
  static PublishBlogRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get therapistId => $_getSZ(0);
  @$pb.TagNumber(1)
  set therapistId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTherapistId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTherapistId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get blogId => $_getSZ(1);
  @$pb.TagNumber(2)
  set blogId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBlogId() => $_has(1);
  @$pb.TagNumber(2)
  void clearBlogId() => $_clearField(2);
}

class PublishBlogResponse extends $pb.GeneratedMessage {
  factory PublishBlogResponse({
    Blog? blog,
  }) {
    final result = create();
    if (blog != null) result.blog = blog;
    return result;
  }

  PublishBlogResponse._();

  factory PublishBlogResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PublishBlogResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PublishBlogResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'therapist'),
      createEmptyInstance: create)
    ..aOM<Blog>(1, _omitFieldNames ? '' : 'blog', subBuilder: Blog.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PublishBlogResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PublishBlogResponse copyWith(void Function(PublishBlogResponse) updates) =>
      super.copyWith((message) => updates(message as PublishBlogResponse))
          as PublishBlogResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PublishBlogResponse create() => PublishBlogResponse._();
  @$core.override
  PublishBlogResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static PublishBlogResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PublishBlogResponse>(create);
  static PublishBlogResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Blog get blog => $_getN(0);
  @$pb.TagNumber(1)
  set blog(Blog value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasBlog() => $_has(0);
  @$pb.TagNumber(1)
  void clearBlog() => $_clearField(1);
  @$pb.TagNumber(1)
  Blog ensureBlog() => $_ensure(0);
}

/// DeleteBlog — own blog (any status).
class DeleteBlogRequest extends $pb.GeneratedMessage {
  factory DeleteBlogRequest({
    $core.String? therapistId,
    $core.String? blogId,
  }) {
    final result = create();
    if (therapistId != null) result.therapistId = therapistId;
    if (blogId != null) result.blogId = blogId;
    return result;
  }

  DeleteBlogRequest._();

  factory DeleteBlogRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteBlogRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteBlogRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'therapist'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'therapistId')
    ..aOS(2, _omitFieldNames ? '' : 'blogId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteBlogRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteBlogRequest copyWith(void Function(DeleteBlogRequest) updates) =>
      super.copyWith((message) => updates(message as DeleteBlogRequest))
          as DeleteBlogRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteBlogRequest create() => DeleteBlogRequest._();
  @$core.override
  DeleteBlogRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeleteBlogRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteBlogRequest>(create);
  static DeleteBlogRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get therapistId => $_getSZ(0);
  @$pb.TagNumber(1)
  set therapistId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTherapistId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTherapistId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get blogId => $_getSZ(1);
  @$pb.TagNumber(2)
  set blogId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBlogId() => $_has(1);
  @$pb.TagNumber(2)
  void clearBlogId() => $_clearField(2);
}

class DeleteBlogResponse extends $pb.GeneratedMessage {
  factory DeleteBlogResponse({
    $core.bool? success,
  }) {
    final result = create();
    if (success != null) result.success = success;
    return result;
  }

  DeleteBlogResponse._();

  factory DeleteBlogResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteBlogResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteBlogResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'therapist'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteBlogResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteBlogResponse copyWith(void Function(DeleteBlogResponse) updates) =>
      super.copyWith((message) => updates(message as DeleteBlogResponse))
          as DeleteBlogResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteBlogResponse create() => DeleteBlogResponse._();
  @$core.override
  DeleteBlogResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeleteBlogResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteBlogResponse>(create);
  static DeleteBlogResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);
}

/// GetBlog — fetch one blog; increments views when published.
class GetBlogRequest extends $pb.GeneratedMessage {
  factory GetBlogRequest({
    $core.String? blogId,
    $core.String? viewerId,
  }) {
    final result = create();
    if (blogId != null) result.blogId = blogId;
    if (viewerId != null) result.viewerId = viewerId;
    return result;
  }

  GetBlogRequest._();

  factory GetBlogRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetBlogRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetBlogRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'therapist'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'blogId')
    ..aOS(2, _omitFieldNames ? '' : 'viewerId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetBlogRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetBlogRequest copyWith(void Function(GetBlogRequest) updates) =>
      super.copyWith((message) => updates(message as GetBlogRequest))
          as GetBlogRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetBlogRequest create() => GetBlogRequest._();
  @$core.override
  GetBlogRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetBlogRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetBlogRequest>(create);
  static GetBlogRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get blogId => $_getSZ(0);
  @$pb.TagNumber(1)
  set blogId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasBlogId() => $_has(0);
  @$pb.TagNumber(1)
  void clearBlogId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get viewerId => $_getSZ(1);
  @$pb.TagNumber(2)
  set viewerId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasViewerId() => $_has(1);
  @$pb.TagNumber(2)
  void clearViewerId() => $_clearField(2);
}

class GetBlogResponse extends $pb.GeneratedMessage {
  factory GetBlogResponse({
    Blog? blog,
  }) {
    final result = create();
    if (blog != null) result.blog = blog;
    return result;
  }

  GetBlogResponse._();

  factory GetBlogResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetBlogResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetBlogResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'therapist'),
      createEmptyInstance: create)
    ..aOM<Blog>(1, _omitFieldNames ? '' : 'blog', subBuilder: Blog.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetBlogResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetBlogResponse copyWith(void Function(GetBlogResponse) updates) =>
      super.copyWith((message) => updates(message as GetBlogResponse))
          as GetBlogResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetBlogResponse create() => GetBlogResponse._();
  @$core.override
  GetBlogResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetBlogResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetBlogResponse>(create);
  static GetBlogResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Blog get blog => $_getN(0);
  @$pb.TagNumber(1)
  set blog(Blog value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasBlog() => $_has(0);
  @$pb.TagNumber(1)
  void clearBlog() => $_clearField(1);
  @$pb.TagNumber(1)
  Blog ensureBlog() => $_ensure(0);
}

/// ListBlogs — paginated list of published blogs (optionally filtered by therapist).
class ListBlogsRequest extends $pb.GeneratedMessage {
  factory ListBlogsRequest({
    $core.String? therapistId,
    $core.String? viewerId,
    $core.int? page,
    $core.int? pageSize,
  }) {
    final result = create();
    if (therapistId != null) result.therapistId = therapistId;
    if (viewerId != null) result.viewerId = viewerId;
    if (page != null) result.page = page;
    if (pageSize != null) result.pageSize = pageSize;
    return result;
  }

  ListBlogsRequest._();

  factory ListBlogsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListBlogsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListBlogsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'therapist'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'therapistId')
    ..aOS(2, _omitFieldNames ? '' : 'viewerId')
    ..aI(3, _omitFieldNames ? '' : 'page')
    ..aI(4, _omitFieldNames ? '' : 'pageSize')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListBlogsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListBlogsRequest copyWith(void Function(ListBlogsRequest) updates) =>
      super.copyWith((message) => updates(message as ListBlogsRequest))
          as ListBlogsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListBlogsRequest create() => ListBlogsRequest._();
  @$core.override
  ListBlogsRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListBlogsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListBlogsRequest>(create);
  static ListBlogsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get therapistId => $_getSZ(0);
  @$pb.TagNumber(1)
  set therapistId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTherapistId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTherapistId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get viewerId => $_getSZ(1);
  @$pb.TagNumber(2)
  set viewerId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasViewerId() => $_has(1);
  @$pb.TagNumber(2)
  void clearViewerId() => $_clearField(2);

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

class ListBlogsResponse extends $pb.GeneratedMessage {
  factory ListBlogsResponse({
    $core.Iterable<Blog>? blogs,
    $core.int? total,
  }) {
    final result = create();
    if (blogs != null) result.blogs.addAll(blogs);
    if (total != null) result.total = total;
    return result;
  }

  ListBlogsResponse._();

  factory ListBlogsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListBlogsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListBlogsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'therapist'),
      createEmptyInstance: create)
    ..pPM<Blog>(1, _omitFieldNames ? '' : 'blogs', subBuilder: Blog.create)
    ..aI(2, _omitFieldNames ? '' : 'total')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListBlogsResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListBlogsResponse copyWith(void Function(ListBlogsResponse) updates) =>
      super.copyWith((message) => updates(message as ListBlogsResponse))
          as ListBlogsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListBlogsResponse create() => ListBlogsResponse._();
  @$core.override
  ListBlogsResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListBlogsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListBlogsResponse>(create);
  static ListBlogsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Blog> get blogs => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);
}

/// ListMyBlogs — all blogs (draft + published) for the authenticated therapist.
class ListMyBlogsRequest extends $pb.GeneratedMessage {
  factory ListMyBlogsRequest({
    $core.String? therapistId,
    $core.int? page,
    $core.int? pageSize,
  }) {
    final result = create();
    if (therapistId != null) result.therapistId = therapistId;
    if (page != null) result.page = page;
    if (pageSize != null) result.pageSize = pageSize;
    return result;
  }

  ListMyBlogsRequest._();

  factory ListMyBlogsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListMyBlogsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListMyBlogsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'therapist'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'therapistId')
    ..aI(2, _omitFieldNames ? '' : 'page')
    ..aI(3, _omitFieldNames ? '' : 'pageSize')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListMyBlogsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListMyBlogsRequest copyWith(void Function(ListMyBlogsRequest) updates) =>
      super.copyWith((message) => updates(message as ListMyBlogsRequest))
          as ListMyBlogsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListMyBlogsRequest create() => ListMyBlogsRequest._();
  @$core.override
  ListMyBlogsRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListMyBlogsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListMyBlogsRequest>(create);
  static ListMyBlogsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get therapistId => $_getSZ(0);
  @$pb.TagNumber(1)
  set therapistId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTherapistId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTherapistId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get page => $_getIZ(1);
  @$pb.TagNumber(2)
  set page($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPage() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get pageSize => $_getIZ(2);
  @$pb.TagNumber(3)
  set pageSize($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPageSize() => $_has(2);
  @$pb.TagNumber(3)
  void clearPageSize() => $_clearField(3);
}

class ListMyBlogsResponse extends $pb.GeneratedMessage {
  factory ListMyBlogsResponse({
    $core.Iterable<Blog>? blogs,
    $core.int? total,
  }) {
    final result = create();
    if (blogs != null) result.blogs.addAll(blogs);
    if (total != null) result.total = total;
    return result;
  }

  ListMyBlogsResponse._();

  factory ListMyBlogsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListMyBlogsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListMyBlogsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'therapist'),
      createEmptyInstance: create)
    ..pPM<Blog>(1, _omitFieldNames ? '' : 'blogs', subBuilder: Blog.create)
    ..aI(2, _omitFieldNames ? '' : 'total')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListMyBlogsResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListMyBlogsResponse copyWith(void Function(ListMyBlogsResponse) updates) =>
      super.copyWith((message) => updates(message as ListMyBlogsResponse))
          as ListMyBlogsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListMyBlogsResponse create() => ListMyBlogsResponse._();
  @$core.override
  ListMyBlogsResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListMyBlogsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListMyBlogsResponse>(create);
  static ListMyBlogsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Blog> get blogs => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);
}

/// ToggleLikeBlog — like or unlike a published blog.
class ToggleLikeBlogRequest extends $pb.GeneratedMessage {
  factory ToggleLikeBlogRequest({
    $core.String? therapistId,
    $core.String? blogId,
  }) {
    final result = create();
    if (therapistId != null) result.therapistId = therapistId;
    if (blogId != null) result.blogId = blogId;
    return result;
  }

  ToggleLikeBlogRequest._();

  factory ToggleLikeBlogRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ToggleLikeBlogRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ToggleLikeBlogRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'therapist'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'therapistId')
    ..aOS(2, _omitFieldNames ? '' : 'blogId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ToggleLikeBlogRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ToggleLikeBlogRequest copyWith(
          void Function(ToggleLikeBlogRequest) updates) =>
      super.copyWith((message) => updates(message as ToggleLikeBlogRequest))
          as ToggleLikeBlogRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ToggleLikeBlogRequest create() => ToggleLikeBlogRequest._();
  @$core.override
  ToggleLikeBlogRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ToggleLikeBlogRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ToggleLikeBlogRequest>(create);
  static ToggleLikeBlogRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get therapistId => $_getSZ(0);
  @$pb.TagNumber(1)
  set therapistId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTherapistId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTherapistId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get blogId => $_getSZ(1);
  @$pb.TagNumber(2)
  set blogId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBlogId() => $_has(1);
  @$pb.TagNumber(2)
  void clearBlogId() => $_clearField(2);
}

class ToggleLikeBlogResponse extends $pb.GeneratedMessage {
  factory ToggleLikeBlogResponse({
    $core.bool? liked,
    $fixnum.Int64? likes,
  }) {
    final result = create();
    if (liked != null) result.liked = liked;
    if (likes != null) result.likes = likes;
    return result;
  }

  ToggleLikeBlogResponse._();

  factory ToggleLikeBlogResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ToggleLikeBlogResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ToggleLikeBlogResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'therapist'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'liked')
    ..aInt64(2, _omitFieldNames ? '' : 'likes')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ToggleLikeBlogResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ToggleLikeBlogResponse copyWith(
          void Function(ToggleLikeBlogResponse) updates) =>
      super.copyWith((message) => updates(message as ToggleLikeBlogResponse))
          as ToggleLikeBlogResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ToggleLikeBlogResponse create() => ToggleLikeBlogResponse._();
  @$core.override
  ToggleLikeBlogResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ToggleLikeBlogResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ToggleLikeBlogResponse>(create);
  static ToggleLikeBlogResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get liked => $_getBF(0);
  @$pb.TagNumber(1)
  set liked($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLiked() => $_has(0);
  @$pb.TagNumber(1)
  void clearLiked() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get likes => $_getI64(1);
  @$pb.TagNumber(2)
  set likes($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLikes() => $_has(1);
  @$pb.TagNumber(2)
  void clearLikes() => $_clearField(2);
}

/// UploadBlogImage — upload one inline blog image (max 2 MB).
class UploadBlogImageRequest extends $pb.GeneratedMessage {
  factory UploadBlogImageRequest({
    $core.String? therapistId,
    $core.List<$core.int>? data,
    $core.String? fileName,
    $core.String? contentType,
  }) {
    final result = create();
    if (therapistId != null) result.therapistId = therapistId;
    if (data != null) result.data = data;
    if (fileName != null) result.fileName = fileName;
    if (contentType != null) result.contentType = contentType;
    return result;
  }

  UploadBlogImageRequest._();

  factory UploadBlogImageRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UploadBlogImageRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UploadBlogImageRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'therapist'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'therapistId')
    ..a<$core.List<$core.int>>(
        2, _omitFieldNames ? '' : 'data', $pb.PbFieldType.OY)
    ..aOS(3, _omitFieldNames ? '' : 'fileName')
    ..aOS(4, _omitFieldNames ? '' : 'contentType')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadBlogImageRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadBlogImageRequest copyWith(
          void Function(UploadBlogImageRequest) updates) =>
      super.copyWith((message) => updates(message as UploadBlogImageRequest))
          as UploadBlogImageRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UploadBlogImageRequest create() => UploadBlogImageRequest._();
  @$core.override
  UploadBlogImageRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UploadBlogImageRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UploadBlogImageRequest>(create);
  static UploadBlogImageRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get therapistId => $_getSZ(0);
  @$pb.TagNumber(1)
  set therapistId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTherapistId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTherapistId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get data => $_getN(1);
  @$pb.TagNumber(2)
  set data($core.List<$core.int> value) => $_setBytes(1, value);
  @$pb.TagNumber(2)
  $core.bool hasData() => $_has(1);
  @$pb.TagNumber(2)
  void clearData() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get fileName => $_getSZ(2);
  @$pb.TagNumber(3)
  set fileName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasFileName() => $_has(2);
  @$pb.TagNumber(3)
  void clearFileName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get contentType => $_getSZ(3);
  @$pb.TagNumber(4)
  set contentType($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasContentType() => $_has(3);
  @$pb.TagNumber(4)
  void clearContentType() => $_clearField(4);
}

class UploadBlogImageResponse extends $pb.GeneratedMessage {
  factory UploadBlogImageResponse({
    $core.String? url,
  }) {
    final result = create();
    if (url != null) result.url = url;
    return result;
  }

  UploadBlogImageResponse._();

  factory UploadBlogImageResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UploadBlogImageResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UploadBlogImageResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'therapist'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'url')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadBlogImageResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadBlogImageResponse copyWith(
          void Function(UploadBlogImageResponse) updates) =>
      super.copyWith((message) => updates(message as UploadBlogImageResponse))
          as UploadBlogImageResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UploadBlogImageResponse create() => UploadBlogImageResponse._();
  @$core.override
  UploadBlogImageResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UploadBlogImageResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UploadBlogImageResponse>(create);
  static UploadBlogImageResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get url => $_getSZ(0);
  @$pb.TagNumber(1)
  set url($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUrl() => $_has(0);
  @$pb.TagNumber(1)
  void clearUrl() => $_clearField(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
