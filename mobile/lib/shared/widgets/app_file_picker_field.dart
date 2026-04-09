import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:therapist/core/theme/app_theme.dart';

enum AppFileType { image, pdf, any }

class PickedFile {
  const PickedFile({required this.name, required this.bytes});
  final String name;
  final Uint8List bytes;
}

/// A tappable card that lets the user pick a file.
/// Enforces a 3 MB size limit and shows the picked file name.
/// Reusable across therapist and future user onboarding flows.
class AppFilePickerField extends StatelessWidget {
  const AppFilePickerField({
    super.key,
    required this.label,
    required this.fileType,
    this.picked,
    this.onPicked,
    this.errorText,
    this.optional = false,
  });

  final String label;
  final AppFileType fileType;
  final PickedFile? picked;
  final ValueChanged<PickedFile>? onPicked;
  final String? errorText;
  final bool optional;

  static const _maxBytes = 3 * 1024 * 1024; // 3 MB

  Future<void> _pick(BuildContext context) async {
    try {
      FilePickerResult? result;
      if (fileType == AppFileType.image) {
        result = await FilePicker.platform.pickFiles(
          type: FileType.image,
          withData: true,
        );
      } else if (fileType == AppFileType.pdf) {
        result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['pdf'],
          withData: true,
        );
      } else {
        result = await FilePicker.platform.pickFiles(
          type: FileType.any,
          withData: true,
        );
      }

      if (result == null || result.files.isEmpty) return;

      final file = result.files.first;
      final bytes = file.bytes;
      if (bytes == null) return;

      if (bytes.lengthInBytes > _maxBytes) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('File is too large. Maximum size is 3 MB.'),
              backgroundColor: AppColors.error,
            ),
          );
        }
        return;
      }

      onPicked?.call(PickedFile(name: file.name, bytes: bytes));
    } catch (_) {
      // User cancelled or permission denied — silently ignore
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasPicked = picked != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(label, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.subtle)),
            if (optional)
              Text(' (optional)',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.subtle)),
          ],
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () => _pick(context),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              border: Border.all(
                color: errorText != null
                    ? AppColors.error
                    : hasPicked
                        ? AppColors.primary
                        : Colors.grey.shade400,
              ),
              borderRadius: BorderRadius.circular(12),
              color: hasPicked ? AppColors.primary.withValues(alpha: 0.05) : null,
            ),
            child: Row(
              children: [
                Icon(
                  hasPicked
                      ? (fileType == AppFileType.image ? Icons.image_rounded : Icons.picture_as_pdf_rounded)
                      : Icons.upload_file_rounded,
                  color: hasPicked ? AppColors.primary : AppColors.subtle,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    hasPicked ? picked!.name : 'Tap to select (max 3 MB)',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: hasPicked ? AppColors.primary : AppColors.subtle,
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (hasPicked)
                  const Icon(Icons.check_circle_rounded, color: AppColors.primary, size: 20),
              ],
            ),
          ),
        ),
        if (errorText != null) ...[
          const SizedBox(height: 4),
          Text(errorText!, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.error)),
        ],
      ],
    );
  }
}
