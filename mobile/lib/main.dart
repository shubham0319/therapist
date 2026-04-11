import 'dart:async';

import 'package:flutter/material.dart';
import 'package:therapist/app.dart';
import 'package:therapist/core/config/env.dart';
import 'package:therapist/core/di/injection.dart';

void main() {
  runZonedGuarded(_boot, (error, stack) {
    // Catch uncaught zone errors (e.g. WebCrypto OperationError from
    // flutter_secure_storage on web) so the app doesn't crash.
    debugPrint('Unhandled zone error: $error');
  });
}

Future<void> _boot() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Load environment variables (pass --dart-define=FLAVOR=production for prod)
  const flavor = String.fromEnvironment('FLAVOR', defaultValue: 'development');
  await Env.load(flavor: flavor);

  // 2. Wire all dependencies (Supabase, gRPC, repositories)
  await configureDependencies();

  // 3. Start
  runApp(const TherapistApp());
}
