import 'package:flutter/material.dart';
import 'package:therapist/core/theme/app_theme.dart';

/// Horizontal step indicator bar.
/// Reusable for any multi-step flow (therapist onboarding, user onboarding, etc.)
class AppStepIndicator extends StatelessWidget {
  const AppStepIndicator({
    super.key,
    required this.totalSteps,
    required this.currentStep, // 0-indexed
    this.labels,
  });

  final int totalSteps;
  final int currentStep;
  final List<String>? labels;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(totalSteps, (i) {
        final isDone = i < currentStep;
        final isCurrent = i == currentStep;

        return Expanded(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      height: 4,
                      decoration: BoxDecoration(
                        color: isDone || isCurrent ? AppColors.primary : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    if (labels != null && i < labels!.length) ...[
                      const SizedBox(height: 4),
                      Text(
                        labels![i],
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: isCurrent ? AppColors.primary : AppColors.subtle,
                              fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                            ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              if (i < totalSteps - 1) const SizedBox(width: 4),
            ],
          ),
        );
      }),
    );
  }
}
