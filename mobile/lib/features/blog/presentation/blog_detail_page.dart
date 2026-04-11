import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:therapist/core/router/app_router.dart';
import 'package:therapist/features/auth/bloc/auth_bloc.dart';
import 'package:therapist/features/blog/bloc/blog_bloc.dart';
import 'package:therapist/features/blog/data/blog_repository.dart';

class BlogDetailPage extends StatefulWidget {
  const BlogDetailPage({super.key, required this.blogId});
  final String blogId;

  @override
  State<BlogDetailPage> createState() => _BlogDetailPageState();
}

class _BlogDetailPageState extends State<BlogDetailPage> {
  late final BlogBloc _bloc;

  String get _therapistId {
    final s = context.read<AuthBloc>().state;
    return s is AuthAuthenticated ? s.therapistId : '';
  }

  @override
  void initState() {
    super.initState();
    _bloc = BlogBloc();
  }

  bool _loaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_loaded) {
      _loaded = true;
      _bloc.add(BlogDetailRequested(blogId: widget.blogId, viewerId: _therapistId));
    }
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: BlocConsumer<BlogBloc, BlogState>(
        listener: (ctx, state) {
          if (state is BlogLikeUpdated) {
            // Silently update — no snackbar needed; UI rebuilds from state.
          }
          if (state is BlogDeleted) {
            ctx.pop();
          }
          if (state is BlogError) {
            ScaffoldMessenger.of(ctx).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: Colors.red),
            );
          }
        },
        builder: (ctx, state) {
          if (state is BlogDetailLoaded) _lastBlogModel = state.blog;

          final blog = switch (state) {
            BlogDetailLoaded(blog: final b) => b,
            BlogLikeUpdated() => _lastBlogModel,
            BlogPublished(blog: final b) => b,
            _ => _lastBlogModel,
          };

          if (blog == null) {
            return Scaffold(
              appBar: AppBar(),
              body: const Center(child: CircularProgressIndicator()),
            );
          }
          final theme = Theme.of(context);
          final cs = theme.colorScheme;
          final isOwner = blog.therapistId == _therapistId;

          return Scaffold(
            appBar: AppBar(
              title: Text(blog.title, overflow: TextOverflow.ellipsis),
              actions: [
                if (isOwner && blog.isDraft) ...[
                  IconButton(
                    icon: const Icon(Icons.edit_outlined),
                    tooltip: 'Edit',
                    onPressed: () => context.push(AppRoutes.blogEdit, extra: blog),
                  ),
                  IconButton(
                    icon: const Icon(Icons.publish),
                    tooltip: 'Publish',
                    onPressed: () => _confirmPublish(ctx, blog.id),
                  ),
                ],
                if (isOwner)
                  IconButton(
                    icon: const Icon(Icons.delete_outline),
                    tooltip: 'Delete',
                    onPressed: () => _confirmDelete(ctx, blog.id),
                  ),
              ],
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Cover image
                  if (blog.coverImageUrl.isNotEmpty) ...[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Image.network(blog.coverImageUrl, fit: BoxFit.cover),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],

                  // Status badge (for owner viewing a draft)
                  if (blog.isDraft)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: cs.tertiaryContainer,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Draft',
                        style: theme.textTheme.labelSmall?.copyWith(color: cs.onTertiaryContainer),
                      ),
                    ),

                  const SizedBox(height: 8),

                  // Title
                  Text(blog.title, style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),

                  const SizedBox(height: 12),

                  // Meta row
                  Row(
                    children: [
                      Icon(Icons.remove_red_eye_outlined, size: 16, color: cs.outline),
                      const SizedBox(width: 4),
                      Text('${blog.views}', style: theme.textTheme.labelMedium),
                      const SizedBox(width: 16),
                      GestureDetector(
                        onTap: blog.isPublished && _therapistId.isNotEmpty
                            ? () => _bloc.add(BlogLikeToggled(therapistId: _therapistId, blogId: blog.id))
                            : null,
                        child: Row(
                          children: [
                            Icon(
                              blog.likedByMe ? Icons.favorite : Icons.favorite_border,
                              size: 18,
                              color: blog.likedByMe ? cs.error : cs.outline,
                            ),
                            const SizedBox(width: 4),
                            Text('${blog.likes}', style: theme.textTheme.labelMedium),
                          ],
                        ),
                      ),
                      const Spacer(),
                      if (blog.publishedAt.isNotEmpty)
                        Text(
                          _formatDate(blog.publishedAt),
                          style: theme.textTheme.labelSmall?.copyWith(color: cs.outline),
                        ),
                    ],
                  ),

                  const Divider(height: 32),

                  // Content
                  Text(blog.content, style: theme.textTheme.bodyMedium?.copyWith(height: 1.6)),

                  // Inline images
                  if (blog.imageUrls.isNotEmpty) ...[
                    const SizedBox(height: 24),
                    ...blog.imageUrls.map(
                      (url) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(url, fit: BoxFit.cover, width: double.infinity),
                        ),
                      ),
                    ),
                  ],

                  const SizedBox(height: 40),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Caches the last loaded blog so like-updates / publish don't blank the view.
  BlogModel? _lastBlogModel;

  void _confirmPublish(BuildContext ctx, String blogId) {
    showDialog(
      context: ctx,
      builder: (dialogCtx) => AlertDialog(
        title: const Text('Publish blog?'),
        content: const Text('Once published, readers can see your blog. You can still delete it later.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogCtx), child: const Text('Cancel')),
          FilledButton(
            onPressed: () {
              Navigator.pop(dialogCtx);
              _bloc.add(BlogPublishRequested(therapistId: _therapistId, blogId: blogId));
            },
            child: const Text('Publish'),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext ctx, String blogId) {
    showDialog(
      context: ctx,
      builder: (dialogCtx) => AlertDialog(
        title: const Text('Delete blog?'),
        content: const Text('This action cannot be undone.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogCtx), child: const Text('Cancel')),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.pop(dialogCtx);
              _bloc.add(BlogDeleteRequested(therapistId: _therapistId, blogId: blogId));
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  String _formatDate(String iso) {
    try {
      final dt = DateTime.parse(iso);
      return '${dt.day}/${dt.month}/${dt.year}';
    } catch (_) {
      return '';
    }
  }
}
