import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:therapist/core/di/injection.dart';
import 'package:therapist/features/blog/data/blog_repository.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  BlogBloc() : super(BlogInitial()) {
    on<BlogListRequested>(_onListRequested);
    on<BlogLoadMoreRequested>(_onLoadMoreRequested);
    on<MyBlogListRequested>(_onMyListRequested);
    on<MyBlogLoadMoreRequested>(_onMyLoadMoreRequested);
    on<BlogDetailRequested>(_onDetailRequested);
    on<BlogSubmitted>(_onSubmitted);
    on<BlogPublishRequested>(_onPublishRequested);
    on<BlogDeleteRequested>(_onDeleteRequested);
    on<BlogLikeToggled>(_onLikeToggled);
    on<BlogImageUploadRequested>(_onImageUploadRequested);
  }

  final _repo = sl<BlogRepository>();

  // ── List ──────────────────────────────────────────────────────────────────

  Future<void> _onListRequested(BlogListRequested e, Emitter<BlogState> emit) async {
    emit(BlogLoading());
    final result = await _repo.listBlogs(
      therapistId: e.therapistId,
      viewerId: e.viewerId,
      page: e.page,
    );
    result.fold(
      (f) => emit(BlogError(f.message)),
      (data) => emit(BlogListLoaded(
        blogs: data.blogs,
        total: data.total,
        page: e.page,
        hasMore: data.blogs.length < data.total,
      )),
    );
  }

  Future<void> _onLoadMoreRequested(BlogLoadMoreRequested e, Emitter<BlogState> emit) async {
    final current = state;
    if (current is! BlogListLoaded || !current.hasMore) return;

    emit(BlogListLoadingMore(currentBlogs: current.blogs));
    final nextPage = current.page + 1;
    final result = await _repo.listBlogs(
      therapistId: e.therapistId,
      viewerId: e.viewerId,
      page: nextPage,
    );
    result.fold(
      (f) => emit(BlogError(f.message)),
      (data) {
        final all = [...current.blogs, ...data.blogs];
        emit(BlogListLoaded(
          blogs: all,
          total: data.total,
          page: nextPage,
          hasMore: all.length < data.total,
        ));
      },
    );
  }

  // ── My blogs ──────────────────────────────────────────────────────────────

  Future<void> _onMyListRequested(MyBlogListRequested e, Emitter<BlogState> emit) async {
    emit(BlogLoading());
    final result = await _repo.listMyBlogs(therapistId: e.therapistId, page: e.page);
    result.fold(
      (f) => emit(BlogError(f.message)),
      (data) => emit(MyBlogListLoaded(
        blogs: data.blogs,
        total: data.total,
        page: e.page,
        hasMore: data.blogs.length < data.total,
      )),
    );
  }

  Future<void> _onMyLoadMoreRequested(MyBlogLoadMoreRequested e, Emitter<BlogState> emit) async {
    final current = state;
    if (current is! MyBlogListLoaded || !current.hasMore) return;

    emit(MyBlogListLoadingMore(currentBlogs: current.blogs));
    final nextPage = current.page + 1;
    final result = await _repo.listMyBlogs(therapistId: e.therapistId, page: nextPage);
    result.fold(
      (f) => emit(BlogError(f.message)),
      (data) {
        final all = [...current.blogs, ...data.blogs];
        emit(MyBlogListLoaded(
          blogs: all,
          total: data.total,
          page: nextPage,
          hasMore: all.length < data.total,
        ));
      },
    );
  }

  // ── Detail ────────────────────────────────────────────────────────────────

  Future<void> _onDetailRequested(BlogDetailRequested e, Emitter<BlogState> emit) async {
    emit(BlogLoading());
    final result = await _repo.getBlog(blogId: e.blogId, viewerId: e.viewerId);
    result.fold(
      (f) => emit(BlogError(f.message)),
      (blog) => emit(BlogDetailLoaded(blog)),
    );
  }

  // ── Create / Update ───────────────────────────────────────────────────────

  Future<void> _onSubmitted(BlogSubmitted e, Emitter<BlogState> emit) async {
    emit(BlogLoading());
    final isUpdate = e.blogId != null;
    final result = isUpdate
        ? await _repo.updateBlog(
            therapistId: e.therapistId,
            blogId: e.blogId!,
            title: e.title,
            content: e.content,
            coverImageUrl: e.coverImageUrl,
            imageUrls: e.imageUrls,
            tags: e.tags,
          )
        : await _repo.createBlog(
            therapistId: e.therapistId,
            title: e.title,
            content: e.content,
            coverImageUrl: e.coverImageUrl,
            imageUrls: e.imageUrls,
            tags: e.tags,
          );
    result.fold(
      (f) => emit(BlogError(f.message)),
      (blog) => emit(BlogSaved(blog)),
    );
  }

  // ── Publish ───────────────────────────────────────────────────────────────

  Future<void> _onPublishRequested(BlogPublishRequested e, Emitter<BlogState> emit) async {
    emit(BlogLoading());
    final result = await _repo.publishBlog(therapistId: e.therapistId, blogId: e.blogId);
    result.fold(
      (f) => emit(BlogError(f.message)),
      (blog) => emit(BlogPublished(blog)),
    );
  }

  // ── Delete ────────────────────────────────────────────────────────────────

  Future<void> _onDeleteRequested(BlogDeleteRequested e, Emitter<BlogState> emit) async {
    emit(BlogLoading());
    final result = await _repo.deleteBlog(therapistId: e.therapistId, blogId: e.blogId);
    result.fold(
      (f) => emit(BlogError(f.message)),
      (_) => emit(BlogDeleted()),
    );
  }

  // ── Like ──────────────────────────────────────────────────────────────────

  Future<void> _onLikeToggled(BlogLikeToggled e, Emitter<BlogState> emit) async {
    final result = await _repo.toggleLike(therapistId: e.therapistId, blogId: e.blogId);
    result.fold(
      (f) => emit(BlogError(f.message)),
      (data) => emit(BlogLikeUpdated(liked: data.liked, likes: data.likes, blogId: e.blogId)),
    );
  }

  // ── Image upload ──────────────────────────────────────────────────────────

  Future<void> _onImageUploadRequested(BlogImageUploadRequested e, Emitter<BlogState> emit) async {
    emit(BlogLoading());
    final result = await _repo.uploadBlogImage(
      therapistId: e.therapistId,
      fileName: e.fileName,
      contentType: e.contentType,
      data: e.data,
    );
    result.fold(
      (f) => emit(BlogError(f.message)),
      (url) => emit(BlogImageUploaded(url)),
    );
  }
}
