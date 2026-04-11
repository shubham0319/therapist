import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:therapist/core/di/injection.dart';
import 'package:therapist/core/router/app_router.dart';
import 'package:therapist/core/theme/app_theme.dart';
import 'package:therapist/features/auth/bloc/auth_bloc.dart';

class TherapistApp extends StatefulWidget {
  const TherapistApp({super.key});

  @override
  State<TherapistApp> createState() => _TherapistAppState();
}

class _TherapistAppState extends State<TherapistApp> {
  // AuthBloc lives at app level so the router can listen to it.
  late final AuthBloc _authBloc;
  late final GoRouterWrapper _routerWrapper; // ignore: strict_top_level_inference

  @override
  void initState() {
    super.initState();
    _authBloc = sl<AuthBloc>()..add(const AuthStarted());
    _routerWrapper = GoRouterWrapper(buildRouter(_authBloc));
  }

  @override
  void dispose() {
    _authBloc.close();
    _routerWrapper.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _authBloc,
      child: MaterialApp.router(
        title: 'Therapist',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.system,
        routerConfig: _routerWrapper.router,
      ),
    );
  }
}

/// Thin wrapper so we can dispose the router (and its ChangeNotifier).
class GoRouterWrapper {
  GoRouterWrapper(this.router);
  final GoRouter router;
  void dispose() => router.dispose();
}
