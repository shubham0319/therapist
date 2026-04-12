import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:therapist/core/router/app_router.dart';
import 'package:therapist/core/theme/app_theme.dart';
import 'package:therapist/features/auth/bloc/auth_bloc.dart';
import 'package:therapist/shared/widgets/app_button.dart';
import 'package:therapist/shared/widgets/app_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailCtrl = TextEditingController();
  final _otpCtrl = TextEditingController();
  bool _otpSent = false;
  /// 'therapist' | 'user'
  String _accountType = 'therapist';

  @override
  void dispose() {
    _emailCtrl.dispose();
    _otpCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (ctx, state) {
        if (state is AuthOtpSent) {
          setState(() => _otpSent = true);
        }
        if (state is AuthAuthenticated) {
          if (state.isUser) {
            ctx.go(state.status == 'needs_onboarding'
                ? AppRoutes.userOnboarding
                : AppRoutes.userHome);
          } else {
            // Therapist flow — router redirect handles the right destination.
            ctx.go(AppRoutes.home);
          }
        }
        if (state is AuthError) {
          ScaffoldMessenger.of(ctx).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(),

                // Header
                Text(
                  _otpSent ? 'Check your email' : 'Welcome',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  _otpSent
                      ? 'Enter the 6-digit code sent to ${_emailCtrl.text}'
                      : 'Sign in with your email to continue',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: AppColors.subtle),
                ),
                const SizedBox(height: 24),

                // ── Account type toggle ───────────────────────────────────
                if (!_otpSent)
                  _AccountTypeToggle(
                    selected: _accountType,
                    onChanged: (v) => setState(() => _accountType = v),
                  ),
                const SizedBox(height: 24),

                if (!_otpSent) ...[
                  // Google sign-in
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (ctx, state) => AppButton.outlined(
                      label: 'Continue with Google',
                      icon: Icons.g_mobiledata,
                      loading: state is AuthLoading,
                      onPressed: () =>
                          ctx.read<AuthBloc>().add(AuthGoogleSignInRequested()),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Divider
                  Row(
                    children: [
                      const Expanded(child: Divider()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          'or',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: AppColors.subtle),
                        ),
                      ),
                      const Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Email field
                  AppTextField(
                    controller: _emailCtrl,
                    label: 'Email address',
                    keyboardType: TextInputType.emailAddress,
                    hint: 'you@example.com',
                  ),
                  const SizedBox(height: 16),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (ctx, state) => AppButton(
                      label: 'Send OTP',
                      loading: state is AuthLoading,
                      onPressed: () {
                        final email = _emailCtrl.text.trim();
                        if (email.isEmpty) return;
                        ctx.read<AuthBloc>().add(
                              AuthEmailOtpRequested(email: email),
                            );
                      },
                    ),
                  ),
                ] else ...[
                  // OTP input
                  AppTextField(
                    controller: _otpCtrl,
                    label: '6-digit OTP',
                    keyboardType: TextInputType.number,
                    hint: '123456',
                  ),
                  const SizedBox(height: 16),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (ctx, state) => AppButton(
                      label: 'Verify OTP',
                      loading: state is AuthLoading,
                      onPressed: () {
                        ctx.read<AuthBloc>().add(AuthOtpVerified(
                              contact:     _emailCtrl.text.trim(),
                              otp:         _otpCtrl.text.trim(),
                              isEmail:     true,
                              accountType: _accountType,
                            ));
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () => setState(() {
                      _otpSent = false;
                      _otpCtrl.clear();
                    }),
                    child: const Text('Use a different email'),
                  ),
                ],

                const Spacer(flex: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Account type toggle: "I'm a Therapist" / "I'm looking for help"
// ─────────────────────────────────────────────────────────────────────────────

class _AccountTypeToggle extends StatelessWidget {
  const _AccountTypeToggle({
    required this.selected,
    required this.onChanged,
  });

  final String selected;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs    = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('I am a…', style: theme.textTheme.labelMedium),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _ToggleOption(
                label: 'Therapist',
                icon: Icons.psychology_outlined,
                selected: selected == 'therapist',
                onTap: () => onChanged('therapist'),
                cs: cs,
                theme: theme,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _ToggleOption(
                label: 'Looking for help',
                icon: Icons.favorite_border,
                selected: selected == 'user',
                onTap: () => onChanged('user'),
                cs: cs,
                theme: theme,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ToggleOption extends StatelessWidget {
  const _ToggleOption({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
    required this.cs,
    required this.theme,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;
  final ColorScheme cs;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: selected ? cs.primaryContainer : cs.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? cs.primary : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18,
              color: selected ? cs.onPrimaryContainer : cs.onSurfaceVariant,
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                label,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: selected ? cs.onPrimaryContainer : cs.onSurfaceVariant,
                  fontWeight:
                      selected ? FontWeight.bold : FontWeight.normal,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
