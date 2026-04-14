import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:therapist/core/di/injection.dart';
import 'package:therapist/core/router/app_router.dart';
import 'package:therapist/core/theme/app_theme.dart';
import 'package:therapist/features/auth/bloc/auth_bloc.dart';
import 'package:therapist/features/discovery/bloc/discovery_bloc.dart';
import 'package:therapist/features/discovery/data/discovery_repository.dart';
import 'package:therapist/features/user/bloc/user_profile_cubit.dart';

/// Entry point wired with the required BLoCs/cubits.
class UserHomePage extends StatelessWidget {
  const UserHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = context.read<AuthBloc>().state;
    final userId =
        authState is AuthAuthenticated ? authState.userId : '';

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<UserProfileCubit>()..load(userId),
        ),
        BlocProvider(create: (_) => sl<DiscoveryBloc>()),
      ],
      child: const _UserHomeView(),
    );
  }
}

class _UserHomeView extends StatefulWidget {
  const _UserHomeView();

  @override
  State<_UserHomeView> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<_UserHomeView> {
  final _searchCtrl = TextEditingController();
  Timer? _debounce;
  String _sessionFilter = ''; // '' | 'video' | 'in_person'

  @override
  void initState() {
    super.initState();
    // Load recommendations after the first frame. Profile may already be
    // loaded (cubit.load fired in wrapper); we read it synchronously.
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadRecommendations());
  }

  void _loadRecommendations() {
    final profile = context.read<UserProfileCubit>().profile;
    context.read<DiscoveryBloc>().add(DiscoveryRecommendationsRequested(
          state:  profile?.state  ?? '',
          nation: profile?.nation ?? '',
        ));
  }

  void _initLoad() => _loadRecommendations();

  @override
  void dispose() {
    _searchCtrl.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      if (!mounted) return;
      final trimmed = query.trim();
      if (trimmed.isEmpty) {
        _initLoad();
      } else {
        context.read<DiscoveryBloc>().add(DiscoverySearchChanged(
              query:       trimmed,
              sessionType: _sessionFilter,
            ));
      }
    });
  }

  void _onFilterTap(String filter) {
    setState(() => _sessionFilter = filter == _sessionFilter ? '' : filter);
    final cubit  = context.read<UserProfileCubit>();
    final profile = cubit.profile;
    context.read<DiscoveryBloc>().add(DiscoveryFilterChanged(
          query:       _searchCtrl.text.trim(),
          sessionType: _sessionFilter,
          userState:   profile?.state  ?? '',
          userNation:  profile?.nation ?? '',
        ));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs    = theme.colorScheme;

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ──────────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Find a Therapist',
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.onSurface,
                            )),
                        const SizedBox(height: 2),
                        Text('Verified professionals, ready to help',
                            style: theme.textTheme.bodySmall
                                ?.copyWith(color: AppColors.subtle)),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.logout_outlined),
                    color: AppColors.subtle,
                    tooltip: 'Sign out',
                    onPressed: () =>
                        context.read<AuthBloc>().add(AuthSignOutRequested()),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ── Search bar ──────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _searchCtrl,
                onChanged: _onSearchChanged,
                decoration: InputDecoration(
                  hintText: 'Search by name, topic…',
                  hintStyle: TextStyle(color: AppColors.subtle),
                  prefixIcon:
                      Icon(Icons.search, color: AppColors.subtle, size: 20),
                  suffixIcon: _searchCtrl.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.close, size: 18),
                          color: AppColors.subtle,
                          onPressed: () {
                            _searchCtrl.clear();
                            _onSearchChanged('');
                          },
                        )
                      : null,
                  filled: true,
                  fillColor: cs.surface,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppColors.divider),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppColors.divider),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        BorderSide(color: AppColors.primary, width: 1.5),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // ── Filter chips ─────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  _FilterChip(
                    label: 'All',
                    selected: _sessionFilter == '',
                    onTap: () => _onFilterTap(''),
                  ),
                  const SizedBox(width: 8),
                  _FilterChip(
                    label: 'Video',
                    icon: Icons.videocam_outlined,
                    selected: _sessionFilter == 'video',
                    onTap: () => _onFilterTap('video'),
                  ),
                  const SizedBox(width: 8),
                  _FilterChip(
                    label: 'In-person',
                    icon: Icons.place_outlined,
                    selected: _sessionFilter == 'in_person',
                    onTap: () => _onFilterTap('in_person'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // ── Results ──────────────────────────────────────────────────────
            Expanded(
              child: BlocBuilder<DiscoveryBloc, DiscoveryState>(
                builder: (ctx, state) {
                  if (state is DiscoveryLoading) {
                    return _ShimmerList();
                  }
                  if (state is DiscoveryError) {
                    return _ErrorView(
                      message: state.message,
                      onRetry: _initLoad,
                    );
                  }

                  final List<TherapistCardModel> therapists;
                  final bool isLoadingMore;
                  final bool hasMore;
                  final bool isSearch;

                  if (state is DiscoveryLoaded) {
                    therapists    = state.therapists;
                    isLoadingMore = false;
                    hasMore       = state.hasMore;
                    isSearch      = state.isSearch;
                  } else if (state is DiscoveryLoadingMore) {
                    therapists    = state.therapists;
                    isLoadingMore = true;
                    hasMore       = true;
                    isSearch      = state.isSearch;
                  } else {
                    return _ShimmerList();
                  }

                  if (therapists.isEmpty) {
                    return _EmptyView(
                      isSearch: isSearch,
                      query:    _searchCtrl.text,
                    );
                  }

                  return NotificationListener<ScrollNotification>(
                    onNotification: (n) {
                      if (n is ScrollEndNotification &&
                          n.metrics.extentAfter < 200 &&
                          hasMore &&
                          !isLoadingMore) {
                        ctx
                            .read<DiscoveryBloc>()
                            .add(DiscoveryLoadMoreRequested());
                      }
                      return false;
                    },
                    child: CustomScrollView(
                      slivers: [
                        SliverPadding(
                          padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
                          sliver: SliverToBoxAdapter(
                            child: Text(
                              isSearch ? 'Search results' : 'Recommended for you',
                              style: theme.textTheme.titleSmall?.copyWith(
                                color: AppColors.subtle,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                          sliver: SliverList.separated(
                            separatorBuilder: (_, _) =>
                                const SizedBox(height: 12),
                            itemCount:
                                therapists.length + (isLoadingMore ? 1 : 0),
                            itemBuilder: (ctx, i) {
                              if (i == therapists.length) {
                                return const Center(
                                    child: Padding(
                                  padding: EdgeInsets.all(16),
                                  child: CircularProgressIndicator(),
                                ));
                              }
                              return TherapistCard(
                                model: therapists[i],
                                onTap: () => ctx.push(
                                  AppRoutes.therapistProfile,
                                  extra: therapists[i],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Filter chip ───────────────────────────────────────────────────────────────

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
    this.icon,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : cs.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.divider,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon,
                  size: 14,
                  color: selected ? Colors.white : AppColors.subtle),
              const SizedBox(width: 4),
            ],
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight:
                    selected ? FontWeight.w600 : FontWeight.normal,
                color: selected ? Colors.white : AppColors.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Therapist card ────────────────────────────────────────────────────────────

class TherapistCard extends StatelessWidget {
  const TherapistCard({super.key, required this.model, required this.onTap});

  final TherapistCardModel model;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs    = theme.colorScheme;

    return GestureDetector(
      onTap: onTap,
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
              child: model.profilePhoto.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: model.profilePhoto,
                      width: 72,
                      height: 72,
                      fit: BoxFit.cover,
                      placeholder: (_, _) => _avatarShimmer(),
                      errorWidget: (_, _, _) => _avatarFallback(),
                    )
                  : _avatarFallback(),
            ),
            const SizedBox(width: 14),

            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name + rating row
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          model.fullName,
                          style: theme.textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (model.rating > 0) ...[
                        const Icon(Icons.star_rounded,
                            size: 15, color: Color(0xFFFFC107)),
                        const SizedBox(width: 2),
                        Text(
                          model.rating.toStringAsFixed(1),
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),

                  // Specializations
                  if (model.specializations.isNotEmpty)
                    Text(
                      model.specializations.take(3).join(' · '),
                      style: theme.textTheme.bodySmall
                          ?.copyWith(color: AppColors.subtle),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  const SizedBox(height: 8),

                  // Session type badges + fee
                  Row(
                    children: [
                      if (model.hasVideo)
                        _Badge(
                            label: 'Video', icon: Icons.videocam_outlined),
                      if (model.hasVideo && model.hasInPerson)
                        const SizedBox(width: 6),
                      if (model.hasInPerson)
                        _Badge(
                            label: 'In-person',
                            icon: Icons.place_outlined),
                      const Spacer(),
                      if (model.sessionFee > 0)
                        Text(
                          '₹${model.sessionFee.toStringAsFixed(0)}/session',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),

            // Chevron
            const SizedBox(width: 4),
            Icon(Icons.chevron_right, color: AppColors.subtle),
          ],
        ),
      ),
    );
  }

  Widget _avatarFallback() => Container(
        width: 72,
        height: 72,
        color: AppColors.divider,
        child: const Icon(Icons.person, size: 36, color: AppColors.subtle),
      );

  Widget _avatarShimmer() => Shimmer.fromColors(
        baseColor: AppColors.divider,
        highlightColor: Colors.white,
        child: Container(width: 72, height: 72, color: AppColors.divider),
      );
}

class _Badge extends StatelessWidget {
  const _Badge({required this.label, required this.icon});
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: AppColors.primary),
          const SizedBox(width: 3),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Shimmer skeleton ──────────────────────────────────────────────────────────

class _ShimmerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.divider,
      highlightColor: Colors.white,
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        itemCount: 6,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (_, _) => Container(
          height: 108,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}

// ── Error / empty views ───────────────────────────────────────────────────────

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});
  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 48, color: AppColors.error),
            const SizedBox(height: 16),
            Text('Something went wrong',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(message,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: AppColors.subtle),
                textAlign: TextAlign.center),
            const SizedBox(height: 24),
            FilledButton(onPressed: onRetry, child: const Text('Retry')),
          ],
        ),
      ),
    );
  }
}

class _EmptyView extends StatelessWidget {
  const _EmptyView({required this.isSearch, required this.query});
  final bool isSearch;
  final String query;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.search_off_outlined,
                size: 56, color: AppColors.subtle),
            const SizedBox(height: 16),
            Text(
              isSearch ? 'No therapists found' : 'No therapists available yet',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            if (isSearch) ...[
              const SizedBox(height: 8),
              Text(
                'Try different keywords or remove filters',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: AppColors.subtle),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
