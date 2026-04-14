import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:therapist/core/theme/app_theme.dart';
import 'package:therapist/features/discovery/data/discovery_repository.dart';

class TherapistProfilePage extends StatelessWidget {
  const TherapistProfilePage({super.key, required this.card});

  final TherapistCardModel card;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs    = theme.colorScheme;

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: CustomScrollView(
        slivers: [
          // ── Hero header ──────────────────────────────────────────────────
          SliverAppBar(
            expandedHeight: 240,
            pinned: true,
            backgroundColor: cs.surface,
            foregroundColor: AppColors.onSurface,
            flexibleSpace: FlexibleSpaceBar(
              background: card.profilePhoto.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: card.profilePhoto,
                      fit: BoxFit.cover,
                      errorWidget: (_, _, _) => _photoFallback(),
                    )
                  : _photoFallback(),
            ),
          ),

          // ── Content ──────────────────────────────────────────────────────
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Name + rating
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        card.fullName,
                        style: theme.textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    if (card.rating > 0) ...[
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.star_rounded,
                                  size: 20, color: Color(0xFFFFC107)),
                              const SizedBox(width: 4),
                              Text(
                                card.rating.toStringAsFixed(1),
                                style: theme.textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Text(
                            '${card.totalSessions} sessions',
                            style: theme.textTheme.bodySmall
                                ?.copyWith(color: AppColors.subtle),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),

                const SizedBox(height: 16),

                // Session types + fee row
                _InfoRow(
                  icon: Icons.payments_outlined,
                  child: card.sessionFee > 0
                      ? Text(
                          '₹${card.sessionFee.toStringAsFixed(0)} per session',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        )
                      : Text('Fee not listed',
                          style: theme.textTheme.bodyMedium),
                ),
                const SizedBox(height: 10),
                _InfoRow(
                  icon: Icons.video_call_outlined,
                  child: Wrap(
                    spacing: 8,
                    children: card.sessionTypes
                        .map((t) => _Chip(
                              label: t == 'video' ? 'Video' : 'In-person',
                              icon: t == 'video'
                                  ? Icons.videocam_outlined
                                  : Icons.place_outlined,
                            ))
                        .toList(),
                  ),
                ),
                if (card.addressText.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  _InfoRow(
                    icon: Icons.location_on_outlined,
                    child: Text(card.addressText,
                        style: theme.textTheme.bodyMedium),
                  ),
                ],

                const SizedBox(height: 20),
                _Divider(),

                // Bio
                if (card.bio.isNotEmpty) ...[
                  const SizedBox(height: 20),
                  Text('About',
                      style: theme.textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(card.bio,
                      style: theme.textTheme.bodyMedium?.copyWith(
                          height: 1.6, color: AppColors.onSurface)),
                  const SizedBox(height: 20),
                  _Divider(),
                ],

                // Specializations
                if (card.specializations.isNotEmpty) ...[
                  const SizedBox(height: 20),
                  Text('Specializations',
                      style: theme.textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: card.specializations
                        .map((s) => _Chip(label: s))
                        .toList(),
                  ),
                  const SizedBox(height: 20),
                ],

                // Book CTA
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    icon: const Icon(Icons.calendar_today_outlined, size: 18),
                    label: const Text('Book a session'),
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      // TODO: booking flow
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Booking coming soon!')),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 32),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _photoFallback() => Container(
        color: AppColors.divider,
        child: const Center(
          child: Icon(Icons.person, size: 80, color: AppColors.subtle),
        ),
      );
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.child});
  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: AppColors.subtle),
          const SizedBox(width: 10),
          Expanded(child: child),
        ],
      );
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label, this.icon});
  final String label;
  final IconData? icon;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 13, color: AppColors.primary),
              const SizedBox(width: 4),
            ],
            Text(
              label,
              style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      );
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Divider(color: AppColors.divider, height: 1);
}
