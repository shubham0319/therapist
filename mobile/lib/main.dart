import 'package:flutter/material.dart';
import 'package:therapist/app.dart';
import 'package:therapist/core/config/env.dart';
import 'package:therapist/core/di/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Load environment variables (pass --dart-define=FLAVOR=production for prod)
  const flavor =
      String.fromEnvironment('FLAVOR', defaultValue: 'development');
  await Env.load(flavor: flavor);

  // 2. Wire all dependencies (Supabase, gRPC, repositories)
  await configureDependencies();

  // 3. Start
  runApp(const TherapistApp());
}
