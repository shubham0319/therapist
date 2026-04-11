part of 'blog_bloc.dart';

abstract class BlogState {}

class BlogInitial extends BlogState {}

class BlogLoading extends BlogState {}

class BlogListLoaded extends BlogState {
  BlogListLoaded({
    required this.blogs,
    required this.total,
    this.page = 1,
    this.hasMore = false,
  });
  final List<BlogModel> blogs;
  final int total;
  final int page;
  final bool hasMore;
}

class BlogListLoadingMore extends BlogState {
  BlogListLoadingMore({required this.currentBlogs});
  final List<BlogModel> currentBlogs;
}

class BlogDetailLoaded extends BlogState {
  BlogDetailLoaded(this.blog);
  final BlogModel blog;
}

class BlogSaved extends BlogState {
  BlogSaved(this.blog);
  final BlogModel blog;
}

class BlogPublished extends BlogState {
  BlogPublished(this.blog);
  final BlogModel blog;
}

class BlogDeleted extends BlogState {}

class BlogLikeUpdated extends BlogState {
  BlogLikeUpdated({required this.liked, required this.likes, required this.blogId});
  final bool liked;
  final int likes;
  final String blogId;
}

class BlogImageUploaded extends BlogState {
  BlogImageUploaded(this.url);
  final String url;
}

class BlogError extends BlogState {
  BlogError(this.message);
  final String message;
}
