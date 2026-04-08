import 'package:flutter/material.dart';

/// Primary filled button used across the app.
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.loading = false,
    this.icon,
  });

  /// Outlined variant — for secondary actions like Google sign-in.
  const AppButton.outlined({
    super.key,
    required this.label,
    this.onPressed,
    this.loading = false,
    this.icon,
  }) : _outlined = true;

  final String label;
  final VoidCallback? onPressed;
  final bool loading;
  final IconData? icon;
  // ignore: prefer_final_fields
  bool _outlined = false;

  @override
  Widget build(BuildContext context) {
    final child = loading
        ? const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[Icon(icon, size: 20), const SizedBox(width: 8)],
              Text(label),
            ],
          );

    if (_outlined) {
      return OutlinedButton(
        onPressed: loading ? null : onPressed,
        child: child,
      );
    }
    return ElevatedButton(
      onPressed: loading ? null : onPressed,
      child: child,
    );
  }
}
