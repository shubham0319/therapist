import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:therapist/core/router/app_router.dart';

/// Bottom nav shell used by all main tabs.
class ScaffoldWithNav extends StatelessWidget {
  const ScaffoldWithNav({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _indexFromLocation(location),
        onDestinationSelected: (i) => _onTap(context, i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }

  int _indexFromLocation(String location) {
    if (location.startsWith(AppRoutes.profile)) return 1;
    return 0;
  }

  void _onTap(BuildContext ctx, int index) {
    switch (index) {
      case 0:
        ctx.go(AppRoutes.home);
      case 1:
        ctx.go(AppRoutes.profile);
    }
  }
}
