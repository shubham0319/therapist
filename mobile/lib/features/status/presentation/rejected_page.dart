import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:therapist/core/theme/app_theme.dart';
import 'package:therapist/features/auth/bloc/auth_bloc.dart';
import 'package:therapist/shared/widgets/app_button.dart';

const _supportEmail = 'support@therapist.app';

class RejectedPage extends StatelessWidget {
  const RejectedPage({super.key, this.reason});

  /// Optional rejection reason passed from the auth state.
  final String? reason;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          TextButton.icon(
            icon: const Icon(Icons.logout_outlined, size: 18),
            label: const Text('Sign out'),
            onPressed: () =>
                context.read<AuthBloc>().add(const AuthSignOutRequested()),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: AppColors.error.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.cancel_outlined,
                  size: 56,
                  color: AppColors.error,
                ),
              ),
              const SizedBox(height: 40),

              Text(
                'Application not approved',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              Text(
                'Unfortunately, we were unable to approve your application '
                'at this time.',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: AppColors.subtle, height: 1.6),
                textAlign: TextAlign.center,
              ),

              // Show rejection reason if provided
              if (reason != null && reason!.trim().isNotEmpty) ...[
                const SizedBox(height: 24),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.error.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Reason',
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                              color: AppColors.error,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        reason!,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(height: 1.5),
                      ),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 40),

              Text(
                'If you believe this is a mistake or would like to appeal, '
                'please contact our support team.',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: AppColors.subtle, height: 1.6),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              AppButton(
                label: 'Contact support',
                onPressed: _openEmail,
              ),
              const SizedBox(height: 12),
              AppButton.outlined(
                label: 'Sign out',
                onPressed: () =>
                    context.read<AuthBloc>().add(const AuthSignOutRequested()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _openEmail() async {
    final uri = Uri(
      scheme: 'mailto',
      path: _supportEmail,
      queryParameters: {
        'subject': 'Appeal: Therapist Application Review',
      },
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
