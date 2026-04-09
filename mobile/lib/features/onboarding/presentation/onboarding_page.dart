import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:therapist/core/router/app_router.dart';
import 'package:therapist/core/theme/app_theme.dart';
import 'package:therapist/features/auth/bloc/auth_bloc.dart';
import 'package:therapist/features/onboarding/bloc/onboarding_bloc.dart';
import 'package:therapist/features/onboarding/data/onboarding_repository.dart';
import 'package:therapist/shared/widgets/app_button.dart';
import 'package:therapist/shared/widgets/app_chip_selector.dart';
import 'package:therapist/shared/widgets/app_file_picker_field.dart';
import 'package:therapist/shared/widgets/app_step_indicator.dart';
import 'package:therapist/shared/widgets/app_text_field.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Data available for specializations, languages, session types
// ─────────────────────────────────────────────────────────────────────────────

const _specializations = [
  'Anxiety', 'Depression', 'Trauma & PTSD', 'Couples Therapy',
  'Child & Adolescent', 'Grief & Loss', 'Addiction', 'OCD',
  'Eating Disorders', 'ADHD', 'Stress Management', 'Career Counselling',
  'Family Therapy', 'Anger Management', 'Sleep Issues',
];

const _languages = [
  'English', 'Hindi', 'Tamil', 'Telugu', 'Kannada',
  'Malayalam', 'Marathi', 'Bengali', 'Gujarati', 'Punjabi',
];

const _sessionTypes = ['chat', 'audio', 'video'];

const _genders = ['Male', 'Female', 'Non-binary', 'Prefer not to say'];

const _stepLabels = ['Personal', 'Professional', 'Sessions', 'Documents'];

// ─────────────────────────────────────────────────────────────────────────────
// OnboardingPage — shell that holds PageView + BLoC listener
// ─────────────────────────────────────────────────────────────────────────────

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _pageCtrl = PageController();
  int _currentStep = 0;

  // ── Accumulated form data ──────────────────────────────────────────────────
  String _fullName = '';
  String _phone = '';
  String _gender = '';
  String _bio = '';

  List<String> _specializations = [];
  List<String> _langs = [];
  int _yearsOfExperience = 0;

  List<String> _sessionTypes = [];
  String _sessionFee = '';
  String _registrationNumber = '';
  String _issuingBody = '';

  PickedFile? _profilePhoto;
  PickedFile? _degreeCert;
  PickedFile? _govId;

  void _goToStep(int step) {
    setState(() => _currentStep = step);
    _pageCtrl.animateToPage(
      step,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onPersonalSaved({
    required String fullName,
    required String phone,
    required String gender,
    required String bio,
  }) {
    _fullName = fullName;
    _phone = phone;
    _gender = gender;
    _bio = bio;
    _goToStep(1);
  }

  void _onProfessionalSaved({
    required List<String> specializations,
    required List<String> languages,
    required int yearsOfExperience,
  }) {
    _specializations = specializations;
    _langs = languages;
    _yearsOfExperience = yearsOfExperience;
    _goToStep(2);
  }

  void _onSessionSaved({
    required List<String> sessionTypes,
    required String sessionFee,
    required String registrationNumber,
    required String issuingBody,
  }) {
    _sessionTypes = sessionTypes;
    _sessionFee = sessionFee;
    _registrationNumber = registrationNumber;
    _issuingBody = issuingBody;
    _goToStep(3);
  }

  void _onDocumentsSubmit(BuildContext ctx) {
    final authState = ctx.read<AuthBloc>().state;
    final therapistId =
        authState is AuthAuthenticated ? authState.therapistId : '';

    final data = OnboardingFormData(
      fullName: _fullName,
      phone: _phone,
      gender: _gender,
      bio: _bio,
      specializations: _specializations,
      languages: _langs,
      yearsOfExperience: _yearsOfExperience,
      sessionTypes: _sessionTypes,
      sessionFee: _sessionFee,
      registrationNumber: _registrationNumber,
      issuingBody: _issuingBody,
      profilePhotoBytes: _profilePhoto?.bytes,
      profilePhotoName: _profilePhoto?.name,
      degreeCertBytes: _degreeCert?.bytes,
      degreeCertName: _degreeCert?.name,
      govIdBytes: _govId?.bytes,
      govIdName: _govId?.name,
    );

    ctx.read<OnboardingBloc>().add(
          OnboardingSubmitted(therapistId: therapistId, data: data),
        );
  }

  @override
  void dispose() {
    _pageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingBloc(),
      child: Builder(
        builder: (innerCtx) => BlocListener<OnboardingBloc, OnboardingState>(
          listener: (ctx, state) {
            if (state is OnboardingSuccess) {
              ctx.go(AppRoutes.home);
            }
            if (state is OnboardingFailure) {
              ScaffoldMessenger.of(ctx).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: AppColors.error,
                ),
              );
            }
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Complete your profile'),
              automaticallyImplyLeading: false,
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
                  child: AppStepIndicator(
                    totalSteps: 4,
                    currentStep: _currentStep,
                    labels: _stepLabels,
                  ),
                ),
                Expanded(
                  child: PageView(
                    controller: _pageCtrl,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _Step1Personal(onNext: _onPersonalSaved),
                      _Step2Professional(onNext: _onProfessionalSaved),
                      _Step3Sessions(
                        onNext: _onSessionSaved,
                        onBack: () => _goToStep(1),
                      ),
                      _Step4Documents(
                        profilePhoto: _profilePhoto,
                        degreeCert: _degreeCert,
                        govId: _govId,
                        onProfilePhoto: (f) => setState(() => _profilePhoto = f),
                        onDegreeCert: (f) => setState(() => _degreeCert = f),
                        onGovId: (f) => setState(() => _govId = f),
                        onBack: () => _goToStep(2),
                        onSubmit: _onDocumentsSubmit,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Step 1 — Personal Info
// ─────────────────────────────────────────────────────────────────────────────

class _Step1Personal extends StatefulWidget {
  const _Step1Personal({required this.onNext});
  final void Function({
    required String fullName,
    required String phone,
    required String gender,
    required String bio,
  }) onNext;

  @override
  State<_Step1Personal> createState() => _Step1PersonalState();
}

class _Step1PersonalState extends State<_Step1Personal> {
  final _form = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _bioCtrl = TextEditingController();
  String _gender = '';

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _bioCtrl.dispose();
    super.dispose();
  }

  void _next() {
    if (!_form.currentState!.validate()) return;
    widget.onNext(
      fullName: _nameCtrl.text.trim(),
      phone: _phoneCtrl.text.trim(),
      gender: _gender,
      bio: _bioCtrl.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _StepShell(
      title: 'Personal information',
      subtitle: 'Tell us a bit about yourself',
      onNext: _next,
      child: Form(
        key: _form,
        child: Column(
          children: [
            AppTextField(
              controller: _nameCtrl,
              label: 'Full name',
              hint: 'Dr. Jane Smith',
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Full name is required' : null,
            ),
            const SizedBox(height: 16),
            AppTextField(
              controller: _phoneCtrl,
              label: 'Phone number (optional)',
              hint: '+91 98765 43210',
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Gender (optional)'),
              items: _genders
                  .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                  .toList(),
              onChanged: (v) => setState(() => _gender = v ?? ''),
            ),
            const SizedBox(height: 16),
            AppTextField(
              controller: _bioCtrl,
              label: 'Short bio (optional)',
              hint: 'Briefly describe your approach and experience…',
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Step 2 — Professional Info
// ─────────────────────────────────────────────────────────────────────────────

class _Step2Professional extends StatefulWidget {
  const _Step2Professional({required this.onNext});
  final void Function({
    required List<String> specializations,
    required List<String> languages,
    required int yearsOfExperience,
  }) onNext;

  @override
  State<_Step2Professional> createState() => _Step2ProfessionalState();
}

class _Step2ProfessionalState extends State<_Step2Professional> {
  final _yoeCtrl = TextEditingController();
  List<String> _specs = [];
  List<String> _langs = [];
  String? _specsError;
  String? _langsError;

  @override
  void dispose() {
    _yoeCtrl.dispose();
    super.dispose();
  }

  void _next() {
    setState(() {
      _specsError = _specs.isEmpty ? 'Select at least one specialization' : null;
      _langsError = _langs.isEmpty ? 'Select at least one language' : null;
    });
    final yoe = int.tryParse(_yoeCtrl.text.trim()) ?? -1;
    if (_specs.isEmpty || _langs.isEmpty || yoe < 0) return;

    widget.onNext(
      specializations: _specs,
      languages: _langs,
      yearsOfExperience: yoe,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _StepShell(
      title: 'Professional background',
      subtitle: 'Your expertise and qualifications',
      onNext: _next,
      child: Column(
        children: [
          AppChipSelector(
            label: 'Specializations *',
            options: _specializations,
            selected: _specs,
            onChanged: (v) => setState(() {
              _specs = v;
              _specsError = null;
            }),
            errorText: _specsError,
          ),
          const SizedBox(height: 20),
          AppChipSelector(
            label: 'Languages spoken *',
            options: _languages,
            selected: _langs,
            onChanged: (v) => setState(() {
              _langs = v;
              _langsError = null;
            }),
            errorText: _langsError,
          ),
          const SizedBox(height: 20),
          AppTextField(
            controller: _yoeCtrl,
            label: 'Years of experience *',
            hint: '5',
            keyboardType: TextInputType.number,
            validator: (v) {
              final n = int.tryParse(v ?? '');
              if (n == null || n < 0) return 'Enter a valid number';
              return null;
            },
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Step 3 — Session Details
// ─────────────────────────────────────────────────────────────────────────────

class _Step3Sessions extends StatefulWidget {
  const _Step3Sessions({required this.onNext, required this.onBack});
  final void Function({
    required List<String> sessionTypes,
    required String sessionFee,
    required String registrationNumber,
    required String issuingBody,
  }) onNext;
  final VoidCallback onBack;

  @override
  State<_Step3Sessions> createState() => _Step3SessionsState();
}

class _Step3SessionsState extends State<_Step3Sessions> {
  final _form = GlobalKey<FormState>();
  final _feeCtrl = TextEditingController();
  final _regCtrl = TextEditingController();
  final _bodyCtrl = TextEditingController();
  List<String> _types = [];
  String? _typesError;

  @override
  void dispose() {
    _feeCtrl.dispose();
    _regCtrl.dispose();
    _bodyCtrl.dispose();
    super.dispose();
  }

  void _next() {
    setState(
        () => _typesError = _types.isEmpty ? 'Select at least one session type' : null);
    if (!_form.currentState!.validate() || _types.isEmpty) return;
    widget.onNext(
      sessionTypes: _types,
      sessionFee: _feeCtrl.text.trim(),
      registrationNumber: _regCtrl.text.trim(),
      issuingBody: _bodyCtrl.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _StepShell(
      title: 'Session details',
      subtitle: 'How you work with clients',
      onNext: _next,
      onBack: widget.onBack,
      child: Form(
        key: _form,
        child: Column(
          children: [
            AppChipSelector(
              label: 'Session types *',
              options: _sessionTypes,
              selected: _types,
              onChanged: (v) => setState(() {
                _types = v;
                _typesError = null;
              }),
              errorText: _typesError,
            ),
            const SizedBox(height: 20),
            AppTextField(
              controller: _feeCtrl,
              label: 'Session fee (₹ per session) *',
              hint: '1500',
              keyboardType: TextInputType.number,
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Fee is required';
                if (double.tryParse(v.trim()) == null) return 'Enter a valid amount';
                return null;
              },
            ),
            const SizedBox(height: 16),
            AppTextField(
              controller: _regCtrl,
              label: 'Registration / license number *',
              hint: 'RCI/2023/12345',
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Registration number is required' : null,
            ),
            const SizedBox(height: 16),
            AppTextField(
              controller: _bodyCtrl,
              label: 'Issuing body *',
              hint: 'Rehabilitation Council of India',
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Issuing body is required' : null,
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Step 4 — Documents
// ─────────────────────────────────────────────────────────────────────────────

class _Step4Documents extends StatefulWidget {
  const _Step4Documents({
    required this.profilePhoto,
    required this.degreeCert,
    required this.govId,
    required this.onProfilePhoto,
    required this.onDegreeCert,
    required this.onGovId,
    required this.onBack,
    required this.onSubmit,
  });

  final PickedFile? profilePhoto;
  final PickedFile? degreeCert;
  final PickedFile? govId;
  final ValueChanged<PickedFile> onProfilePhoto;
  final ValueChanged<PickedFile> onDegreeCert;
  final ValueChanged<PickedFile> onGovId;
  final VoidCallback onBack;
  final void Function(BuildContext ctx) onSubmit;

  @override
  State<_Step4Documents> createState() => _Step4DocumentsState();
}

class _Step4DocumentsState extends State<_Step4Documents> {
  String? _certError;

  void _submit(BuildContext ctx) {
    setState(() => _certError =
        widget.degreeCert == null ? 'Degree certificate is required' : null);
    if (widget.degreeCert == null) return;
    widget.onSubmit(ctx);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (ctx, state) {
        final isLoading = state is OnboardingSubmitting;
        return _StepShell(
          title: 'Documents',
          subtitle: 'Upload your credentials for verification',
          onBack: widget.onBack,
          onNext: isLoading ? null : () => _submit(ctx),
          nextLabel: 'Submit',
          loading: isLoading,
          child: Column(
            children: [
              AppFilePickerField(
                label: 'Profile photo',
                fileType: AppFileType.image,
                picked: widget.profilePhoto,
                optional: true,
                onPicked: widget.onProfilePhoto,
              ),
              const SizedBox(height: 20),
              AppFilePickerField(
                label: 'Degree / certificate (PDF) *',
                fileType: AppFileType.pdf,
                picked: widget.degreeCert,
                errorText: _certError,
                onPicked: (f) {
                  setState(() => _certError = null);
                  widget.onDegreeCert(f);
                },
              ),
              const SizedBox(height: 20),
              AppFilePickerField(
                label: 'Government ID (PDF or image)',
                fileType: AppFileType.any,
                picked: widget.govId,
                optional: true,
                onPicked: widget.onGovId,
              ),
              const SizedBox(height: 12),
              Text(
                'All files are securely stored. Max file size: 3 MB each.',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: AppColors.subtle),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Reusable step shell: title + subtitle + scrollable content + nav buttons
// ─────────────────────────────────────────────────────────────────────────────

class _StepShell extends StatelessWidget {
  const _StepShell({
    required this.title,
    required this.subtitle,
    required this.child,
    this.onNext,
    this.onBack,
    this.nextLabel = 'Continue',
    this.loading = false,
  });

  final String title;
  final String subtitle;
  final Widget child;
  final VoidCallback? onNext;
  final VoidCallback? onBack;
  final String nextLabel;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(title,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(subtitle,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColors.subtle)),
          const SizedBox(height: 28),
          child,
          const SizedBox(height: 32),
          Row(
            children: [
              if (onBack != null) ...[
                Expanded(
                  child: AppButton.outlined(
                    label: 'Back',
                    onPressed: onBack,
                  ),
                ),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: AppButton(
                  label: nextLabel,
                  loading: loading,
                  onPressed: onNext,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}