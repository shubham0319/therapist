import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:therapist/core/router/app_router.dart';
import 'package:therapist/features/auth/bloc/auth_bloc.dart';
import 'package:therapist/features/blog/bloc/blog_bloc.dart';

class BlogListPage extends StatefulWidget {
  const BlogListPage({super.key, this.therapistIdFilter = ''});

  /// When non-empty, shows only that therapist's blogs.
  final String therapistIdFilter;

  @override
  State<BlogListPage> createState() => _BlogListPageState();
}

class _BlogListPageState extends State<BlogListPage> {
  late final BlogBloc _bloc;
  final _scroll = ScrollController();

  String get _viewerId {
    final s = context.read<AuthBloc>().state;
    return s is AuthAuthenticated ? s.therapistId : '';
  }

  @override
  void initState() {
    super.initState();
    _bloc = BlogBloc();
    _scroll.addListener(_onScroll);
  }

  bool _loaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_loaded) {
      _loaded = true;
      _bloc.add(BlogListRequested(
        therapistId: widget.therapistIdFilter,
        viewerId: _viewerId,
      ));
    }
  }

  void _onScroll() {
    if (_scroll.position.pixels >= _scroll.position.maxScrollExtent - 200) {
      _bloc.add(BlogLoadMoreRequested(therapistId: widget.therapistIdFilter, viewerId: _viewerId));
    }
  }

  @override
  void dispose() {
    _bloc.close();
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider.value(
      value: _bloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Blog'),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              tooltip: 'Write a blog',
              onPressed: () => context.push(AppRoutes.blogCreate),
            ),
          ],
        ),
        body: BlocBuilder<BlogBloc, BlogState>(
          builder: (ctx, state) {
            if (state is BlogLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is BlogError) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(state.message, textAlign: TextAlign.center),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: () => _bloc.add(
                        BlogListRequested(therapistId: widget.therapistIdFilter, viewerId: _viewerId),
                      ),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            final blogs = switch (state) {
              BlogListLoaded(blogs: final b) => b,
              BlogListLoadingMore(currentBlogs: final b) => b,
              _ => <dynamic>[],
            };

            if (blogs.isEmpty) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.article_outlined, size: 64, color: theme.colorScheme.outline),
                    const SizedBox(height: 16),
                    Text('No blogs yet', style: theme.textTheme.titleMedium),
                    const SizedBox(height: 8),
                    const Text('Be the first to write one!'),
                  ],
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () async => _bloc.add(
                BlogListRequested(therapistId: widget.therapistIdFilter, viewerId: _viewerId),
              ),
              child: ListView.separated(
                controller: _scroll,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                itemCount: blogs.length + (state is BlogListLoadingMore ? 1 : 0),
                separatorBuilder: (context2, index2) => const SizedBox(height: 12),
                itemBuilder: (ctx, i) {
                  if (i >= blogs.length) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  final blog = blogs[i];
                  return _BlogCard(blog: blog, viewerId: _viewerId);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Blog card widget
// ─────────────────────────────────────────────────────────────────────────────

class _BlogCard extends StatelessWidget {
  const _BlogCard({required this.blog, required this.viewerId});
  final dynamic blog;
  final String viewerId;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () => context.push(AppRoutes.blogDetail, extra: blog.id),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (blog.coverImageUrl.isNotEmpty)
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(
                  blog.coverImageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (errCtx, err, stack) => Container(
                    color: cs.surfaceContainerHighest,
                    child: Icon(Icons.image_not_supported, color: cs.outline),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    blog.title,
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (blog.content.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Text(
                      blog.content,
                      style: theme.textTheme.bodySmall?.copyWith(color: cs.onSurfaceVariant),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.remove_red_eye_outlined, size: 16, color: cs.outline),
                      const SizedBox(width: 4),
                      Text('${blog.views}', style: theme.textTheme.labelSmall),
                      const SizedBox(width: 16),
                      Icon(
                        blog.likedByMe ? Icons.favorite : Icons.favorite_border,
                        size: 16,
                        color: blog.likedByMe ? cs.error : cs.outline,
                      ),
                      const SizedBox(width: 4),
                      Text('${blog.likes}', style: theme.textTheme.labelSmall),
                      const Spacer(),
                      if (blog.publishedAt.isNotEmpty)
                        Text(
                          _formatDate(blog.publishedAt),
                          style: theme.textTheme.labelSmall?.copyWith(color: cs.outline),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
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
