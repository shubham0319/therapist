import 'package:flutter/material.dart';
import 'package:therapist/core/theme/app_theme.dart';
import 'package:therapist/shared/widgets/app_button.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Complete your profile')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Tell us about yourself',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Fill in your professional details so we can verify your account.',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColors.subtle),
            ),
            const Spacer(),
            // TODO: multi-step form pages (personal info → professional → documents)
            AppButton(
              label: 'Start onboarding',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
