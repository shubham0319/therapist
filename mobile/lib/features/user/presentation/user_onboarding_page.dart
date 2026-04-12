import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:therapist/core/router/app_router.dart';
import 'package:therapist/core/theme/app_theme.dart';
import 'package:therapist/features/auth/bloc/auth_bloc.dart';
import 'package:therapist/features/user/bloc/user_onboarding_bloc.dart';
import 'package:therapist/features/user/data/looking_for_options.dart';
import 'package:therapist/shared/widgets/app_button.dart';
import 'package:therapist/shared/widgets/app_text_field.dart';

class UserOnboardingPage extends StatelessWidget {
  const UserOnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UserOnboardingBloc(),
      child: const _UserOnboardingView(),
    );
  }
}

class _UserOnboardingView extends StatefulWidget {
  const _UserOnboardingView();

  @override
  State<_UserOnboardingView> createState() => _UserOnboardingViewState();
}

class _UserOnboardingViewState extends State<_UserOnboardingView> {
  final _formKey      = GlobalKey<FormState>();
  final _nameCtrl     = TextEditingController();
  final _phoneCtrl    = TextEditingController();
  final _stateCtrl    = TextEditingController();
  final _nationCtrl   = TextEditingController();
  final _selectedTopics = <String>{};
  String? _topicsError;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _stateCtrl.dispose();
    _nationCtrl.dispose();
    super.dispose();
  }

  String get _userId {
    final s = context.read<AuthBloc>().state;
    return s is AuthAuthenticated ? s.userId : '';
  }

  void _submit() {
    setState(() {
      _topicsError = _selectedTopics.isEmpty
          ? 'Please select at least one area you\'re looking for help with'
          : null;
    });
    if (!_formKey.currentState!.validate() || _selectedTopics.isEmpty) return;

    context.read<UserOnboardingBloc>().add(UserOnboardingSubmitted(
          userId:     _userId,
          name:       _nameCtrl.text.trim(),
          phone:      _phoneCtrl.text.trim(),
          state:      _stateCtrl.text.trim(),
          nation:     _nationCtrl.text.trim(),
          lookingFor: _selectedTopics.toList(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs    = theme.colorScheme;

    return BlocListener<UserOnboardingBloc, UserOnboardingState>(
      listener: (ctx, state) {
        if (state is UserOnboardingSuccess) {
          ctx.go(AppRoutes.userHome);
        }
        if (state is UserOnboardingFailure) {
          ScaffoldMessenger.of(ctx).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Tell us about yourself')),
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              children: [
                // ── Header ────────────────────────────────────────────────
                Text(
                  'Welcome!',
                  style: theme.textTheme.headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  'A few quick details help us connect you with the right therapist.',
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(color: cs.onSurfaceVariant),
                ),
                const SizedBox(height: 28),

                // ── Personal info ─────────────────────────────────────────
                AppTextField(
                  controller: _nameCtrl,
                  label: 'Your name *',
                  hint: 'Full name',
                  textCapitalization: TextCapitalization.words,
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Name is required' : null,
                ),
                const SizedBox(height: 16),

                AppTextField(
                  controller: _phoneCtrl,
                  label: 'Phone number',
                  hint: '+91 98765 43210',
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 16),

                AppTextField(
                  controller: _stateCtrl,
                  label: 'State / Province',
                  hint: 'e.g. Maharashtra',
                  textCapitalization: TextCapitalization.words,
                ),
                const SizedBox(height: 16),

                AppTextField(
                  controller: _nationCtrl,
                  label: 'Country',
                  hint: 'e.g. India',
                  textCapitalization: TextCapitalization.words,
                ),
                const SizedBox(height: 28),

                // ── Looking for ───────────────────────────────────────────
                Text(
                  'What are you looking for help with? *',
                  style: theme.textTheme.titleSmall
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  'Select all that apply',
                  style: theme.textTheme.bodySmall
                      ?.copyWith(color: cs.onSurfaceVariant),
                ),
                const SizedBox(height: 12),

                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: kLookingForOptions.map((option) {
                    final selected = _selectedTopics.contains(option);
                    return FilterChip(
                      label: Text(option),
                      selected: selected,
                      onSelected: (v) {
                        setState(() {
                          if (v) {
                            _selectedTopics.add(option);
                          } else {
                            _selectedTopics.remove(option);
                          }
                          _topicsError = null;
                        });
                      },
                      selectedColor: cs.primaryContainer,
                      checkmarkColor: cs.onPrimaryContainer,
                      labelStyle: theme.textTheme.labelMedium?.copyWith(
                        color: selected
                            ? cs.onPrimaryContainer
                            : cs.onSurfaceVariant,
                      ),
                    );
                  }).toList(),
                ),

                if (_topicsError != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    _topicsError!,
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: cs.error),
                  ),
                ],

                const SizedBox(height: 32),

                // ── Submit ────────────────────────────────────────────────
                BlocBuilder<UserOnboardingBloc, UserOnboardingState>(
                  builder: (ctx, state) => AppButton(
                    label: 'Get started',
                    loading: state is UserOnboardingSubmitting,
                    onPressed: _submit,
                  ),
                ),

                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
