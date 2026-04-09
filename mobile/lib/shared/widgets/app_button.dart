import 'package:flutter/material.dart';

enum _AppButtonStyle { filled, outlined }

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.loading = false,
    this.icon,
  }) : _style = _AppButtonStyle.filled;

  const AppButton.outlined({
    super.key,
    required this.label,
    this.onPressed,
    this.loading = false,
    this.icon,
  }) : _style = _AppButtonStyle.outlined;

  final String label;
  final VoidCallback? onPressed;
  final bool loading;
  final IconData? icon;
  final _AppButtonStyle _style;

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

    if (_style == _AppButtonStyle.outlined) {
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
