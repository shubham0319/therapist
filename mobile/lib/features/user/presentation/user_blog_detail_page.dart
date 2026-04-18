import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:therapist/core/di/injection.dart';
import 'package:therapist/core/router/app_router.dart';
import 'package:therapist/core/theme/app_theme.dart';
import 'package:therapist/features/auth/bloc/auth_bloc.dart';
import 'package:therapist/features/blog/bloc/blog_bloc.dart';
import 'package:therapist/features/blog/data/blog_repository.dart';
import 'package:therapist/features/discovery/data/discovery_repository.dart';

/// User-facing (patient) blog detail — read-only with like + therapist card.
class UserBlogDetailPage extends StatefulWidget {
  const UserBlogDetailPage({super.key, required this.blogId});
  final String blogId;

  @override
  State<UserBlogDetailPage> createState() => _UserBlogDetailPageState();
}

class _UserBlogDetailPageState extends State<UserBlogDetailPage> {
  late final BlogBloc _bloc;
  BlogModel? _lastBlog;
  bool _loaded = false;

  String get _userId {
    final s = context.read<AuthBloc>().state;
    return s is AuthAuthenticated ? s.userId : '';
  }

  @override
  void initState() {
    super.initState();
    _bloc = BlogBloc();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_loaded) {
      _loaded = true;
      _bloc.add(BlogDetailRequested(
          blogId: widget.blogId, viewerId: _userId));
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
          if (state is BlogError) {
            ScaffoldMessenger.of(ctx).showSnackBar(
              SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red),
            );
          }
        },
        builder: (ctx, state) {
          if (state is BlogDetailLoaded) _lastBlog = state.blog;
          if (state is BlogLikeUpdated) {
            final prev = _lastBlog;
            if (prev != null && state.blogId == prev.id) {
              _lastBlog = BlogModel(
                id: prev.id,
                therapistId: prev.therapistId,
                title: prev.title,
                slug: prev.slug,
                coverImageUrl: prev.coverImageUrl,
                content: prev.content,
                imageUrls: prev.imageUrls,
                tags: prev.tags,
                status: prev.status,
                views: prev.views,
                likes: state.likes,
                likedByMe: state.liked,
                createdAt: prev.createdAt,
                updatedAt: prev.updatedAt,
                publishedAt: prev.publishedAt,
              );
            }
          }

          final blog = _lastBlog;

          if (blog == null) {
            return Scaffold(
              appBar: AppBar(),
              body: const Center(child: CircularProgressIndicator()),
            );
          }

          return _BlogDetailView(
            blog: blog,
            userId: _userId,
            bloc: _bloc,
          );
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _BlogDetailView extends StatelessWidget {
  const _BlogDetailView({
    required this.blog,
    required this.userId,
    required this.bloc,
  });
  final BlogModel blog;
  final String userId;
  final BlogBloc bloc;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(blog.title, overflow: TextOverflow.ellipsis),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Cover image ────────────────────────────────────────────────
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

            // ── Title ──────────────────────────────────────────────────────
            Text(
              blog.title,
              style: theme.textTheme.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            // ── Meta row ───────────────────────────────────────────────────
            Row(
              children: [
                Icon(Icons.remove_red_eye_outlined,
                    size: 16, color: cs.outline),
                const SizedBox(width: 4),
                Text('${blog.views}',
                    style: theme.textTheme.labelMedium),
                const SizedBox(width: 16),
                // Like button
                GestureDetector(
                  onTap: userId.isNotEmpty
                      ? () => bloc.add(UserBlogLikeToggled(
                            userId: userId,
                            blogId: blog.id,
                          ))
                      : null,
                  child: Row(
                    children: [
                      Icon(
                        blog.likedByMe
                            ? Icons.favorite
                            : Icons.favorite_border,
                        size: 18,
                        color: blog.likedByMe ? cs.error : cs.outline,
                      ),
                      const SizedBox(width: 4),
                      Text('${blog.likes}',
                          style: theme.textTheme.labelMedium),
                    ],
                  ),
                ),
                const Spacer(),
                if (blog.publishedAt.isNotEmpty)
                  Text(
                    _formatDate(blog.publishedAt),
                    style: theme.textTheme.labelSmall
                        ?.copyWith(color: cs.outline),
                  ),
              ],
            ),

            const Divider(height: 32),

            // ── Content ────────────────────────────────────────────────────
            Text(
              blog.content,
              style:
                  theme.textTheme.bodyMedium?.copyWith(height: 1.6),
            ),

            // ── Tags ───────────────────────────────────────────────────────
            if (blog.tags.isNotEmpty) ...[
              const SizedBox(height: 20),
              Wrap(
                spacing: 6,
                runSpacing: 4,
                children: blog.tags
                    .map((t) => Chip(
                          label: Text(t,
                              style: theme.textTheme.labelSmall),
                          padding: EdgeInsets.zero,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          backgroundColor: cs.secondaryContainer,
                          side: BorderSide.none,
                        ))
                    .toList(),
              ),
            ],

            // ── Inline images ──────────────────────────────────────────────
            if (blog.imageUrls.isNotEmpty) ...[
              const SizedBox(height: 24),
              ...blog.imageUrls.map(
                (url) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(url,
                        fit: BoxFit.cover,
                        width: double.infinity),
                  ),
                ),
              ),
            ],

            const SizedBox(height: 32),
            const Divider(),
            const SizedBox(height: 16),

            // ── Therapist profile card ─────────────────────────────────────
            _TherapistCard(therapistId: blog.therapistId),

            const SizedBox(height: 40),
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
// Therapist card at bottom of blog — fetches profile lazily
// ─────────────────────────────────────────────────────────────────────────────

class _TherapistCard extends StatefulWidget {
  const _TherapistCard({required this.therapistId});
  final String therapistId;

  @override
  State<_TherapistCard> createState() => _TherapistCardState();
}

class _TherapistCardState extends State<_TherapistCard> {
  TherapistCardModel? _card;
  bool _loading = true;
  bool _loaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_loaded) {
      _loaded = true;
      _fetchProfile();
    }
  }

  Future<void> _fetchProfile() async {
    final repo = sl<DiscoveryRepository>();
    final result = await repo.getTherapistProfile(
        therapistId: widget.therapistId);
    if (!mounted) return;
    result.fold(
      (_) => setState(() => _loading = false),
      (card) => setState(() {
        _card = card;
        _loading = false;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    if (_loading) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (_card == null) return const SizedBox.shrink();

    final card = _card!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About the author',
          style: theme.textTheme.titleSmall?.copyWith(
            color: cs.outline,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: () => context.push(AppRoutes.therapistProfile, extra: card),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: cs.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.divider),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: card.profilePhoto.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: card.profilePhoto,
                          width: 64,
                          height: 64,
                          fit: BoxFit.cover,
                          errorWidget: (_, __, ___) => _avatarFallback(),
                        )
                      : _avatarFallback(),
                ),
                const SizedBox(width: 14),

                // Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        card.fullName,
                        style: theme.textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (card.specializations.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          card.specializations.take(3).join(' · '),
                          style: theme.textTheme.bodySmall
                              ?.copyWith(color: AppColors.subtle),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                      if (card.bio.isNotEmpty) ...[
                        const SizedBox(height: 6),
                        Text(
                          card.bio,
                          style: theme.textTheme.bodySmall
                              ?.copyWith(color: cs.onSurfaceVariant),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),

                const SizedBox(width: 4),
                Icon(Icons.chevron_right, color: AppColors.subtle),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _avatarFallback() => Container(
        width: 64,
        height: 64,
        color: AppColors.divider,
        child: const Icon(Icons.person, size: 32, color: AppColors.subtle),
      );
}
