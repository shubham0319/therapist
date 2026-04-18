import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:therapist/core/router/app_router.dart';
import 'package:therapist/features/auth/bloc/auth_bloc.dart';
import 'package:therapist/features/blog/bloc/blog_bloc.dart';
import 'package:therapist/features/blog/data/blog_repository.dart';

/// User-facing (patient) blog list — published blogs only, no writing tools.
class UserBlogListPage extends StatefulWidget {
  const UserBlogListPage({super.key});

  @override
  State<UserBlogListPage> createState() => _UserBlogListPageState();
}

class _UserBlogListPageState extends State<UserBlogListPage> {
  late final BlogBloc _bloc;
  final _scroll = ScrollController();
  bool _loaded = false;

  String get _userId {
    final s = context.read<AuthBloc>().state;
    return s is AuthAuthenticated ? s.userId : '';
  }

  @override
  void initState() {
    super.initState();
    _bloc = BlogBloc();
    _scroll.addListener(_onScroll);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_loaded) {
      _loaded = true;
      _bloc.add(BlogListRequested(viewerId: _userId));
    }
  }

  void _onScroll() {
    if (_scroll.position.pixels >= _scroll.position.maxScrollExtent - 200) {
      _bloc.add(BlogLoadMoreRequested(viewerId: _userId));
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
    return BlocProvider.value(
      value: _bloc,
      child: Scaffold(
        appBar: AppBar(title: const Text('Blogs')),
        body: BlocBuilder<BlogBloc, BlogState>(
          buildWhen: (_, s) =>
              s is BlogLoading ||
              s is BlogListLoaded ||
              s is BlogListLoadingMore ||
              s is BlogError,
          builder: (ctx, state) {
            if (state is BlogLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is BlogError) {
              return _ErrorView(
                message: state.message,
                onRetry: () => _bloc.add(BlogListRequested(viewerId: _userId)),
              );
            }
            final blogs = switch (state) {
              BlogListLoaded(blogs: final b) => b,
              BlogListLoadingMore(currentBlogs: final b) => b,
              _ => <BlogModel>[],
            };
            if (blogs.isEmpty) {
              return _EmptyView();
            }
            return RefreshIndicator(
              onRefresh: () async =>
                  _bloc.add(BlogListRequested(viewerId: _userId)),
              child: ListView.separated(
                controller: _scroll,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                itemCount:
                    blogs.length + (state is BlogListLoadingMore ? 1 : 0),
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (ctx, i) {
                  if (i >= blogs.length) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  return _UserBlogCard(blog: blogs[i], userId: _userId);
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
// Blog card (read-only, user facing)
// ─────────────────────────────────────────────────────────────────────────────

class _UserBlogCard extends StatelessWidget {
  const _UserBlogCard({required this.blog, required this.userId});
  final BlogModel blog;
  final String userId;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () => context.push(AppRoutes.userBlogDetail, extra: blog.id),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (blog.coverImageUrl.isNotEmpty)
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(
                  blog.coverImageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
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
                    style: theme.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (blog.content.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Text(
                      blog.content,
                      style: theme.textTheme.bodySmall
                          ?.copyWith(color: cs.onSurfaceVariant),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  if (blog.tags.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      children: blog.tags.take(4).map((t) => Chip(
                        label: Text(t),
                        labelStyle: theme.textTheme.labelSmall
                            ?.copyWith(color: cs.onSecondaryContainer),
                        backgroundColor: cs.secondaryContainer,
                        padding: EdgeInsets.zero,
                        side: BorderSide.none,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      )).toList(),
                    ),
                  ],
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.remove_red_eye_outlined,
                          size: 16, color: cs.outline),
                      const SizedBox(width: 4),
                      Text('${blog.views}',
                          style: theme.textTheme.labelSmall),
                      const SizedBox(width: 16),
                      Icon(
                        blog.likedByMe
                            ? Icons.favorite
                            : Icons.favorite_border,
                        size: 16,
                        color: blog.likedByMe ? cs.error : cs.outline,
                      ),
                      const SizedBox(width: 4),
                      Text('${blog.likes}',
                          style: theme.textTheme.labelSmall),
                      const Spacer(),
                      if (blog.publishedAt.isNotEmpty)
                        Text(
                          _formatDate(blog.publishedAt),
                          style: theme.textTheme.labelSmall
                              ?.copyWith(color: cs.outline),
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

// ─────────────────────────────────────────────────────────────────────────────

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});
  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            FilledButton(onPressed: onRetry, child: const Text('Retry')),
          ],
        ),
      );
}

class _EmptyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.article_outlined,
              size: 64, color: theme.colorScheme.outline),
          const SizedBox(height: 16),
          Text('No blogs yet', style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(
            'Check back soon for articles from therapists.',
            style: theme.textTheme.bodySmall
                ?.copyWith(color: theme.colorScheme.outline),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
