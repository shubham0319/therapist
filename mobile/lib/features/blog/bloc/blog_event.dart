part of 'blog_bloc.dart';

abstract class BlogEvent {}

// List / load
class BlogListRequested extends BlogEvent {
  BlogListRequested({this.therapistId = '', required this.viewerId, this.page = 1});
  final String therapistId;
  final String viewerId;
  final int page;
}

class BlogLoadMoreRequested extends BlogEvent {
  BlogLoadMoreRequested({this.therapistId = '', required this.viewerId});
  final String therapistId;
  final String viewerId;
}

// Detail
class BlogDetailRequested extends BlogEvent {
  BlogDetailRequested({required this.blogId, this.viewerId = ''});
  final String blogId;
  final String viewerId;
}

// Create / Edit
class BlogCreateStarted extends BlogEvent {}

class BlogSubmitted extends BlogEvent {
  BlogSubmitted({
    required this.therapistId,
    required this.title,
    required this.content,
    this.coverImageUrl = '',
    this.imageUrls = const [],
    this.blogId, // non-null = update
  });
  final String therapistId;
  final String title;
  final String content;
  final String coverImageUrl;
  final List<String> imageUrls;
  final String? blogId;
}

class BlogPublishRequested extends BlogEvent {
  BlogPublishRequested({required this.therapistId, required this.blogId});
  final String therapistId;
  final String blogId;
}

class BlogDeleteRequested extends BlogEvent {
  BlogDeleteRequested({required this.therapistId, required this.blogId});
  final String therapistId;
  final String blogId;
}

class BlogLikeToggled extends BlogEvent {
  BlogLikeToggled({required this.therapistId, required this.blogId});
  final String therapistId;
  final String blogId;
}

class BlogImageUploadRequested extends BlogEvent {
  BlogImageUploadRequested({
    required this.therapistId,
    required this.fileName,
    required this.contentType,
    required this.data,
  });
  final String therapistId;
  final String fileName;
  final String contentType;
  final Uint8List data;
}
