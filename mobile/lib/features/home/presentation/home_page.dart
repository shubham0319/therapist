import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:therapist/core/theme/app_theme.dart';
import 'package:therapist/features/auth/bloc/auth_bloc.dart';
import 'package:therapist/shared/widgets/app_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_outlined),
            onPressed: () =>
                context.read<AuthBloc>().add(const AuthSignOutRequested()),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (ctx, state) {
            if (state is AuthAuthenticated) {
              return _buildStatusBanner(ctx, state.status);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildStatusBanner(BuildContext ctx, String status) {
    return switch (status) {
      'pending' => _Banner(
          icon: Icons.hourglass_top_rounded,
          color: AppColors.primary,
          title: 'Under review',
          body: 'Your profile is being verified. We\'ll notify you shortly.',
        ),
      'rejected' => _Banner(
          icon: Icons.cancel_outlined,
          color: AppColors.error,
          title: 'Application rejected',
          body: 'Please contact support for more information.',
        ),
      'verified' => _Banner(
          icon: Icons.verified_rounded,
          color: AppColors.secondary,
          title: 'Account verified',
          body: 'You\'re all set. Start accepting sessions.',
        ),
      _ => const SizedBox.shrink(),
    };
  }
}

class _Banner extends StatelessWidget {
  const _Banner({
    required this.icon,
    required this.color,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final Color color;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Icon(icon, color: color, size: 40),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(body,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: AppColors.subtle)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
