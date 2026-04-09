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
          if (state.status == 'needs_onboarding') {
            ctx.go(AppRoutes.onboarding);
          } else {
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
                const SizedBox(height: 40),

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
                              contact: _emailCtrl.text.trim(),
                              otp: _otpCtrl.text.trim(),
                              isEmail: true,
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
