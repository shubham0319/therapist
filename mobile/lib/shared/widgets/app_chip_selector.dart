import 'package:flutter/material.dart';
import 'package:therapist/core/theme/app_theme.dart';

/// A scrollable wrap of filter chips for multi-selection.
/// Reusable for specializations, languages, session types, etc.
class AppChipSelector extends StatelessWidget {
  const AppChipSelector({
    super.key,
    required this.label,
    required this.options,
    required this.selected,
    required this.onChanged,
    this.errorText,
  });

  final String label;
  final List<String> options;
  final List<String> selected;
  final ValueChanged<List<String>> onChanged;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.subtle)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: options.map((opt) {
            final isSelected = selected.contains(opt);
            return FilterChip(
              label: Text(opt),
              selected: isSelected,
              onSelected: (_) {
                final next = List<String>.from(selected);
                isSelected ? next.remove(opt) : next.add(opt);
                onChanged(next);
              },
              selectedColor: AppColors.primary.withValues(alpha: 0.15),
              checkmarkColor: AppColors.primary,
            );
          }).toList(),
        ),
        if (errorText != null) ...[
          const SizedBox(height: 4),
          Text(errorText!, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.error)),
        ],
      ],
    );
  }
}
