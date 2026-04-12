import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:therapist/core/router/app_router.dart';
import 'package:therapist/features/auth/bloc/auth_bloc.dart';
import 'package:therapist/features/blog/bloc/blog_bloc.dart';
import 'package:therapist/features/blog/data/blog_repository.dart';

class BlogListPage extends StatefulWidget {
  const BlogListPage({super.key, this.therapistIdFilter = ''});

  /// When non-empty, shows only that therapist's published blogs (no tabs).
  final String therapistIdFilter;

  @override
  State<BlogListPage> createState() => _BlogListPageState();
}

class _BlogListPageState extends State<BlogListPage>
    with SingleTickerProviderStateMixin {
  late final BlogBloc _bloc;
  late final TabController _tabs;
  final _exploreScroll = ScrollController();
  final _myScroll = ScrollController();

  bool get _showTabs => widget.therapistIdFilter.isEmpty;

  String get _viewerId {
    final s = context.read<AuthBloc>().state;
    return s is AuthAuthenticated ? s.therapistId : '';
  }

  bool _exploreLoaded = false;
  bool _myLoaded = false;

  @override
  void initState() {
    super.initState();
    _bloc = BlogBloc();
    _tabs = TabController(length: 2, vsync: this);
    _exploreScroll.addListener(_onExploreScroll);
    _myScroll.addListener(_onMyScroll);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_exploreLoaded) {
      _exploreLoaded = true;
      _bloc.add(BlogListRequested(
        therapistId: widget.therapistIdFilter,
        viewerId: _viewerId,
      ));
    }
  }

  void _onExploreScroll() {
    if (_exploreScroll.position.pixels >=
        _exploreScroll.position.maxScrollExtent - 200) {
      _bloc.add(BlogLoadMoreRequested(
          therapistId: widget.therapistIdFilter, viewerId: _viewerId));
    }
  }

  void _onMyScroll() {
    if (_myScroll.position.pixels >= _myScroll.position.maxScrollExtent - 200) {
      _bloc.add(MyBlogLoadMoreRequested(therapistId: _viewerId));
    }
  }

  void _loadMyBlogs() {
    if (!_myLoaded) {
      _myLoaded = true;
      _bloc.add(MyBlogListRequested(therapistId: _viewerId));
    }
  }

  @override
  void dispose() {
    _bloc.close();
    _tabs.dispose();
    _exploreScroll.dispose();
    _myScroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          bottom: _showTabs
              ? TabBar(
                  controller: _tabs,
                  onTap: (i) {
                    if (i == 1) _loadMyBlogs();
                  },
                  tabs: const [
                    Tab(text: 'Explore'),
                    Tab(text: 'My Blogs'),
                  ],
                )
              : null,
        ),
        body: _showTabs
            ? TabBarView(
                controller: _tabs,
                children: [
                  _ExploreTab(
                    bloc: _bloc,
                    scroll: _exploreScroll,
                    therapistIdFilter: widget.therapistIdFilter,
                    viewerId: _viewerId,
                  ),
                  _MyBlogsTab(
                    bloc: _bloc,
                    scroll: _myScroll,
                    therapistId: _viewerId,
                  ),
                ],
              )
            : _ExploreTab(
                bloc: _bloc,
                scroll: _exploreScroll,
                therapistIdFilter: widget.therapistIdFilter,
                viewerId: _viewerId,
              ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Explore tab — published blogs
// ─────────────────────────────────────────────────────────────────────────────

class _ExploreTab extends StatelessWidget {
  const _ExploreTab({
    required this.bloc,
    required this.scroll,
    required this.therapistIdFilter,
    required this.viewerId,
  });
  final BlogBloc bloc;
  final ScrollController scroll;
  final String therapistIdFilter;
  final String viewerId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlogBloc, BlogState>(
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
            onRetry: () => bloc.add(BlogListRequested(
                therapistId: therapistIdFilter, viewerId: viewerId)),
          );
        }
        final blogs = switch (state) {
          BlogListLoaded(blogs: final b) => b,
          BlogListLoadingMore(currentBlogs: final b) => b,
          _ => <BlogModel>[],
        };
        if (blogs.isEmpty) {
          return _EmptyView(
            icon: Icons.article_outlined,
            message: 'No blogs yet',
            sub: 'Be the first to write one!',
          );
        }
        return RefreshIndicator(
          onRefresh: () async => bloc.add(
              BlogListRequested(therapistId: therapistIdFilter, viewerId: viewerId)),
          child: ListView.separated(
            controller: scroll,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            itemCount: blogs.length + (state is BlogListLoadingMore ? 1 : 0),
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (ctx, i) {
              if (i >= blogs.length) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              return _BlogCard(blog: blogs[i], viewerId: viewerId);
            },
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// My Blogs tab — drafts + published for the owner
// ─────────────────────────────────────────────────────────────────────────────

class _MyBlogsTab extends StatelessWidget {
  const _MyBlogsTab({
    required this.bloc,
    required this.scroll,
    required this.therapistId,
  });
  final BlogBloc bloc;
  final ScrollController scroll;
  final String therapistId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BlogBloc, BlogState>(
      listenWhen: (_, s) => s is BlogPublished || s is BlogDeleted,
      listener: (ctx, state) {
        // After publish/delete, refresh the list.
        bloc.add(MyBlogListRequested(therapistId: therapistId));
      },
      buildWhen: (_, s) =>
          s is BlogLoading ||
          s is MyBlogListLoaded ||
          s is MyBlogListLoadingMore ||
          s is BlogError,
      builder: (ctx, state) {
        if (state is BlogLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is BlogError) {
          return _ErrorView(
            message: state.message,
            onRetry: () =>
                bloc.add(MyBlogListRequested(therapistId: therapistId)),
          );
        }
        final blogs = switch (state) {
          MyBlogListLoaded(blogs: final b) => b,
          MyBlogListLoadingMore(currentBlogs: final b) => b,
          _ => <BlogModel>[],
        };
        if (blogs.isEmpty) {
          return _EmptyView(
            icon: Icons.edit_note,
            message: 'No blogs yet',
            sub: 'Tap + to write your first blog.',
          );
        }
        return RefreshIndicator(
          onRefresh: () async =>
              bloc.add(MyBlogListRequested(therapistId: therapistId)),
          child: ListView.separated(
            controller: scroll,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            itemCount:
                blogs.length + (state is MyBlogListLoadingMore ? 1 : 0),
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (ctx, i) {
              if (i >= blogs.length) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              return _MyBlogCard(blog: blogs[i], bloc: bloc, therapistId: therapistId);
            },
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// My Blog card — shows draft badge + quick publish/edit/delete actions
// ─────────────────────────────────────────────────────────────────────────────

class _MyBlogCard extends StatefulWidget {
  const _MyBlogCard({
    required this.blog,
    required this.bloc,
    required this.therapistId,
  });
  final BlogModel blog;
  final BlogBloc bloc;
  final String therapistId;

  @override
  State<_MyBlogCard> createState() => _MyBlogCardState();
}

class _MyBlogCardState extends State<_MyBlogCard> {
  bool _publishing = false;

  BlogModel get blog => widget.blog;
  BlogBloc get bloc => widget.bloc;
  String get therapistId => widget.therapistId;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () => context.push(AppRoutes.blogDetail, extra: blog.id),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title row with draft badge
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      blog.title,
                      style: theme.textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (blog.isDraft)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: cs.tertiaryContainer,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Draft',
                        style: theme.textTheme.labelSmall
                            ?.copyWith(color: cs.onTertiaryContainer),
                      ),
                    ),
                ],
              ),

              if (blog.content.isNotEmpty) ...[
                const SizedBox(height: 6),
                Text(
                  blog.content,
                  style: theme.textTheme.bodySmall
                      ?.copyWith(color: cs.onSurfaceVariant),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],

              if (blog.tags.isNotEmpty) ...[
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: (blog.tags).take(3).map((t) => Chip(
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

              // Action row
              Row(
                children: [
                  if (!blog.isDraft) ...[
                    Icon(Icons.remove_red_eye_outlined,
                        size: 14, color: cs.outline),
                    const SizedBox(width: 4),
                    Text('${blog.views}',
                        style: theme.textTheme.labelSmall),
                    const SizedBox(width: 12),
                    Icon(Icons.favorite_border, size: 14, color: cs.outline),
                    const SizedBox(width: 4),
                    Text('${blog.likes}',
                        style: theme.textTheme.labelSmall),
                  ],
                  const Spacer(),
                  // Edit — drafts only
                  if (blog.isDraft)
                    TextButton.icon(
                      onPressed: () =>
                          context.push(AppRoutes.blogEdit, extra: blog),
                      icon: const Icon(Icons.edit_outlined, size: 16),
                      label: const Text('Edit'),
                      style: TextButton.styleFrom(
                          visualDensity: VisualDensity.compact),
                    ),
                  // Publish — drafts only
                  if (blog.isDraft)
                    FilledButton.tonalIcon(
                      onPressed: _publishing
                          ? null
                          : () => _confirmPublish(context, blog.id),
                      icon: _publishing
                          ? const SizedBox(
                              width: 14,
                              height: 14,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.publish, size: 16),
                      label: const Text('Publish'),
                      style: FilledButton.styleFrom(
                          visualDensity: VisualDensity.compact),
                    ),
                  if (!blog.isDraft)
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
      ),
    );
  }

  void _confirmPublish(BuildContext ctx, String blogId) {
    showDialog(
      context: ctx,
      builder: (dialogCtx) => AlertDialog(
        title: const Text('Publish blog?'),
        content: const Text(
            'Once published, readers can see your blog. You can still delete it later.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(dialogCtx),
              child: const Text('Cancel')),
          FilledButton(
            onPressed: () {
              Navigator.pop(dialogCtx);
              setState(() => _publishing = true);
              bloc.add(BlogPublishRequested(
                  therapistId: therapistId, blogId: blogId));
            },
            child: const Text('Publish'),
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

// ─────────────────────────────────────────────────────────────────────────────
// Explore blog card
// ─────────────────────────────────────────────────────────────────────────────

class _BlogCard extends StatelessWidget {
  const _BlogCard({required this.blog, required this.viewerId});
  final BlogModel blog;
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
// Shared helpers
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
  const _EmptyView(
      {required this.icon, required this.message, required this.sub});
  final IconData icon;
  final String message;
  final String sub;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 64, color: theme.colorScheme.outline),
          const SizedBox(height: 16),
          Text(message, style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(sub,
              style: theme.textTheme.bodySmall
                  ?.copyWith(color: theme.colorScheme.outline)),
        ],
      ),
    );
  }
}
