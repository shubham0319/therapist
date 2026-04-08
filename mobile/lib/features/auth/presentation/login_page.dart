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
  bool _useEmail = true;

  @override
  void dispose() {
    _emailCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (ctx, state) {
        if (state is AuthOtpSent) {
          ctx.push('/otp', extra: state.contact);
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
            SnackBar(content: Text(state.message), backgroundColor: AppColors.error),
          );
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(),
                Text('Welcome back',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        )),
                const SizedBox(height: 8),
                Text('Sign in to continue',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: AppColors.subtle)),
                const SizedBox(height: 40),

                // Google sign-in
                BlocBuilder<AuthBloc, AuthState>(builder: (ctx, state) {
                  return AppButton.outlined(
                    label: 'Continue with Google',
                    icon: Icons.g_mobiledata,
                    loading: state is AuthLoading,
                    onPressed: () =>
                        ctx.read<AuthBloc>().add(const AuthGoogleSignInRequested()),
                  );
                }),

                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 16),

                // Email OTP
                AppTextField(
                  controller: _emailCtrl,
                  label: 'Email address',
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                BlocBuilder<AuthBloc, AuthState>(builder: (ctx, state) {
                  return AppButton(
                    label: 'Send OTP',
                    loading: state is AuthLoading,
                    onPressed: () => ctx.read<AuthBloc>().add(
                          AuthEmailOtpRequested(email: _emailCtrl.text.trim()),
                        ),
                  );
                }),

                const Spacer(flex: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
