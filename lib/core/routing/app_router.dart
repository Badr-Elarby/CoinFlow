import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:team_7/core/helpers/shared_pref_helper.dart';
import 'package:team_7/core/shared_widgets/custom_bottom_nav_bar.dart';
import 'package:team_7/features/splash/presentation/screens/splash_screen.dart';
import 'package:team_7/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:team_7/features/home/presentation/pages/home_screen.dart';
import 'package:team_7/features/portfolio/presentation/screens/portfolio_screen.dart';

class AppRouter {
  AppRouter._();

  // Route paths
  static const String splashRoute = '/splash';
  static const String onboardingRoute = '/onboarding';
  static const String loginRoute = '/login';
  static const String homeRoute = '/home';
  static const String marketRoute = '/market';
  static const String portfolioRoute = '/portfolio';
  static const String settingsRoute = '/settings';

  static const String onboardingCompletedKey = 'onboarding_completed';

  // Global key for navigator
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: splashRoute,

    redirect: (context, state) async {
      final path = state.uri.path;

      // Allow splash screen
      if (path == splashRoute) {
        return null;
      }

      // Check onboarding completion for protected routes
      final onboardingCompleted = await SharedPrefHelper.getBool(
        onboardingCompletedKey,
      );

      if (!onboardingCompleted && path != onboardingRoute) {
        return onboardingRoute;
      }

      return null;
    },

    routes: [
      // Splash Route (outside shell)
      GoRoute(
        path: splashRoute,
        name: 'splash',
        pageBuilder: (context, state) =>
            MaterialPage(key: state.pageKey, child: const SplashScreen()),
      ),

      // Onboarding Route (outside shell)
      GoRoute(
        path: onboardingRoute,
        name: 'onboarding',
        pageBuilder: (context, state) =>
            MaterialPage(key: state.pageKey, child: const OnboardingScreen()),
      ),

      // Login Route (outside shell)
      GoRoute(
        path: loginRoute,
        name: 'login',
        pageBuilder: (context, state) =>
            MaterialPage(key: state.pageKey, child: const Placeholder()),
      ),

      // Shell Route with Bottom Navigation
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNavBar(navigationShell: navigationShell);
        },
        branches: [
          // Home Branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: homeRoute,
                name: 'home',
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: HomeScreen()),
              ),
            ],
          ),

          // Market Branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: marketRoute,
                name: 'market',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: Placeholder(), // TODO: Replace with MarketScreen
                ),
              ),
            ],
          ),

          // Portfolio Branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: portfolioRoute,
                name: 'portfolio',
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: PortfolioScreen()),
              ),
            ],
          ),

          // Settings Branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: settingsRoute,
                name: 'settings',
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: Placeholder()),
              ),
            ],
          ),
        ],
      ),
    ],

    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text('Route not found: ${state.uri.path}')),
    ),
  );

  static Future<void> completeOnboarding() async {
    await SharedPrefHelper.setData(onboardingCompletedKey, true);
  }
}

/// Scaffold with bottom navigation bar
class ScaffoldWithNavBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithNavBar({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: CustomBottomNavBar(navigationShell: navigationShell),
    );
  }
}
