import 'dart:typed_data';

import 'package:grpc/service_api.dart';
import 'package:therapist/core/error/failures.dart';
import 'package:therapist/core/error/result.dart';
import 'package:therapist/core/network/grpc_client.dart';
import 'package:therapist/core/proto/therapist.pbgrpc.dart';
import 'package:therapist/core/proto/blog.pb.dart';

const _kRpcTimeout = Duration(seconds: 15);

/// Lightweight model used inside the app — keeps us decoupled from protobuf.
class BlogModel {
  const BlogModel({
    required this.id,
    required this.therapistId,
    required this.title,
    required this.slug,
    required this.coverImageUrl,
    required this.content,
    required this.imageUrls,
    required this.tags,
    required this.status,
    required this.views,
    required this.likes,
    required this.likedByMe,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
  });

  final String id;
  final String therapistId;
  final String title;
  final String slug;
  final String coverImageUrl;
  final String content;
  final List<String> imageUrls;
  final List<String> tags;
  final String status; // "draft" | "published"
  final int views;
  final int likes;
  final bool likedByMe;
  final String createdAt;
  final String updatedAt;
  final String publishedAt;

  bool get isPublished => status == 'published';
  bool get isDraft => status == 'draft';

  static BlogModel fromProto(Blog pb) => BlogModel(
        id: pb.id,
        therapistId: pb.therapistId,
        title: pb.title,
        slug: pb.slug,
        coverImageUrl: pb.coverImageUrl,
        content: pb.content,
        imageUrls: List.unmodifiable(pb.imageUrls),
        tags: List.unmodifiable(pb.tags),
        status: pb.status == BlogStatus.BLOG_STATUS_PUBLISHED ? 'published' : 'draft',
        views: pb.views.toInt(),
        likes: pb.likes.toInt(),
        likedByMe: pb.likedByMe,
        createdAt: pb.createdAt,
        updatedAt: pb.updatedAt,
        publishedAt: pb.publishedAt,
      );
}

class BlogRepository {
  BlogRepository({required GrpcClient grpc}) : _grpc = grpc;

  final GrpcClient _grpc;

  TherapistServiceClient get _stub => TherapistServiceClient(_grpc.channel);

  // ── Create ────────────────────────────────────────────────────────────────

  Future<Result<BlogModel>> createBlog({
    required String therapistId,
    required String title,
    required String content,
    String coverImageUrl = '',
    List<String> imageUrls = const [],
    List<String> tags = const [],
  }) async {
    try {
      final res = await _stub.createBlog(
        CreateBlogRequest()
          ..therapistId = therapistId
          ..title = title
          ..content = content
          ..coverImageUrl = coverImageUrl
          ..imageUrls.addAll(imageUrls)
          ..tags.addAll(tags),
        options: CallOptions(timeout: _kRpcTimeout),
      );
      return Result.success(BlogModel.fromProto(res.blog));
    } catch (e) {
      return Result.error(ServerFailure(e.toString()));
    }
  }

  // ── Update ────────────────────────────────────────────────────────────────

  Future<Result<BlogModel>> updateBlog({
    required String therapistId,
    required String blogId,
    required String title,
    required String content,
    String coverImageUrl = '',
    List<String> imageUrls = const [],
    List<String> tags = const [],
  }) async {
    try {
      final res = await _stub.updateBlog(
        UpdateBlogRequest()
          ..therapistId = therapistId
          ..blogId = blogId
          ..title = title
          ..content = content
          ..coverImageUrl = coverImageUrl
          ..imageUrls.addAll(imageUrls)
          ..tags.addAll(tags),
        options: CallOptions(timeout: _kRpcTimeout),
      );
      return Result.success(BlogModel.fromProto(res.blog));
    } catch (e) {
      return Result.error(ServerFailure(e.toString()));
    }
  }

  // ── Publish ───────────────────────────────────────────────────────────────

  Future<Result<BlogModel>> publishBlog({
    required String therapistId,
    required String blogId,
  }) async {
    try {
      final res = await _stub.publishBlog(
        PublishBlogRequest()
          ..therapistId = therapistId
          ..blogId = blogId,
        options: CallOptions(timeout: _kRpcTimeout),
      );
      return Result.success(BlogModel.fromProto(res.blog));
    } catch (e) {
      return Result.error(ServerFailure(e.toString()));
    }
  }

  // ── Delete ────────────────────────────────────────────────────────────────

  Future<Result<void>> deleteBlog({
    required String therapistId,
    required String blogId,
  }) async {
    try {
      await _stub.deleteBlog(
        DeleteBlogRequest()
          ..therapistId = therapistId
          ..blogId = blogId,
        options: CallOptions(timeout: _kRpcTimeout),
      );
      return Result.success(null);
    } catch (e) {
      return Result.error(ServerFailure(e.toString()));
    }
  }

  // ── Get ───────────────────────────────────────────────────────────────────

  Future<Result<BlogModel>> getBlog({
    required String blogId,
    String viewerId = '',
  }) async {
    try {
      final res = await _stub.getBlog(
        GetBlogRequest()
          ..blogId = blogId
          ..viewerId = viewerId,
        options: CallOptions(timeout: _kRpcTimeout),
      );
      return Result.success(BlogModel.fromProto(res.blog));
    } catch (e) {
      return Result.error(ServerFailure(e.toString()));
    }
  }

  // ── List ──────────────────────────────────────────────────────────────────

  Future<Result<({List<BlogModel> blogs, int total})>> listBlogs({
    String therapistId = '',
    String viewerId = '',
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      final res = await _stub.listBlogs(
        ListBlogsRequest()
          ..therapistId = therapistId
          ..viewerId = viewerId
          ..page = page
          ..pageSize = pageSize,
        options: CallOptions(timeout: _kRpcTimeout),
      );
      final blogs = res.blogs.map(BlogModel.fromProto).toList();
      return Result.success((blogs: blogs, total: res.total));
    } catch (e) {
      return Result.error(ServerFailure(e.toString()));
    }
  }

  // ── My blogs (draft + published) ─────────────────────────────────────────

  Future<Result<({List<BlogModel> blogs, int total})>> listMyBlogs({
    required String therapistId,
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      final res = await _stub.listMyBlogs(
        ListMyBlogsRequest()
          ..therapistId = therapistId
          ..page = page
          ..pageSize = pageSize,
        options: CallOptions(timeout: _kRpcTimeout),
      );
      final blogs = res.blogs.map(BlogModel.fromProto).toList();
      return Result.success((blogs: blogs, total: res.total));
    } catch (e) {
      return Result.error(ServerFailure(e.toString()));
    }
  }

  // ── Like ──────────────────────────────────────────────────────────────────

  Future<Result<({bool liked, int likes})>> toggleLike({
    required String therapistId,
    required String blogId,
  }) async {
    try {
      final res = await _stub.toggleLikeBlog(
        ToggleLikeBlogRequest()
          ..therapistId = therapistId
          ..blogId = blogId,
        options: CallOptions(timeout: _kRpcTimeout),
      );
      return Result.success((liked: res.liked, likes: res.likes.toInt()));
    } catch (e) {
      return Result.error(ServerFailure(e.toString()));
    }
  }

  // ── User like (user/client accounts) ────────────────────────────────────────

  Future<Result<({bool liked, int likes})>> userToggleLike({
    required String userId,
    required String blogId,
  }) async {
    try {
      final res = await _stub.userToggleLikeBlog(
        UserToggleLikeBlogRequest()
          ..userId = userId
          ..blogId = blogId,
        options: CallOptions(timeout: _kRpcTimeout),
      );
      return Result.success((liked: res.liked, likes: res.likes.toInt()));
    } catch (e) {
      return Result.error(ServerFailure(e.toString()));
    }
  }

  // ── Upload image ──────────────────────────────────────────────────────────

  Future<Result<String>> uploadBlogImage({
    required String therapistId,
    required String fileName,
    required String contentType,
    required Uint8List data,
  }) async {
    try {
      final res = await _stub.uploadBlogImage(
        UploadBlogImageRequest()
          ..therapistId = therapistId
          ..fileName = fileName
          ..contentType = contentType
          ..data = data,
        options: CallOptions(timeout: const Duration(seconds: 30)),
      );
      return Result.success(res.url);
    } catch (e) {
      return Result.error(ServerFailure(e.toString()));
    }
  }
}
