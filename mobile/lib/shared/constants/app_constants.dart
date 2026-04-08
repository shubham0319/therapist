abstract class AppConstants {
  // Session types matching backend enum
  static const sessionTypes = ['chat', 'audio', 'video'];

  // Therapist status values returned by backend
  static const statusNeedsOnboarding = 'needs_onboarding';
  static const statusPending = 'pending';
  static const statusVerified = 'verified';
  static const statusRejected = 'rejected';

  // Supported languages (extend as needed)
  static const languages = [
    'English', 'Hindi', 'Tamil', 'Telugu',
    'Kannada', 'Malayalam', 'Bengali', 'Marathi',
  ];

  // Common specialisations
  static const specializations = [
    'Anxiety Disorders',
    'Depression',
    'Relationship Issues',
    'Trauma & PTSD',
    'OCD',
    'Grief & Loss',
    'Career Stress',
    'Family Therapy',
  ];
}
