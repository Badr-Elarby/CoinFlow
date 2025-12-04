import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:team_7/core/helpers/shared_pref_helper.dart';
import 'package:team_7/features/splash/presentation/screens/splash_screen.dart';
import 'package:team_7/features/onboarding/presentation/screens/onboarding_screen.dart';

class AppRouter {
  AppRouter._();

  static const String splashRoute = '/splash';
  static const String onboardingRoute = '/onboarding';
  static const String loginRoute = '/login';
  static const String homeRoute = '/home';

  static const String onboardingCompletedKey = 'onboarding_completed';

  static bool? _cachedOnboardingCompleted;
  static bool _shouldCheckOnboarding = false;

  static final GoRouter router = GoRouter(
    initialLocation: splashRoute,
    debugLogDiagnostics: true,

    redirect: (context, state) async {
      final currentPath = state.uri.path;

      if (_shouldCheckOnboarding && currentPath == splashRoute) {
        _shouldCheckOnboarding = false;

        _cachedOnboardingCompleted ??= await SharedPrefHelper.getBool(
          onboardingCompletedKey,
        );

        if (_cachedOnboardingCompleted == true) {
          return loginRoute;
        } else {
          return onboardingRoute;
        }
      }

      return null;
    },

    routes: [
      GoRoute(
        path: splashRoute,
        name: 'splash',
        pageBuilder: (context, state) =>
            MaterialPage(key: state.pageKey, child: const SplashScreen()),
      ),
      GoRoute(
        path: onboardingRoute,
        name: 'onboarding',
        pageBuilder: (context, state) =>
            MaterialPage(key: state.pageKey, child: const OnboardingScreen()),
      ),
      GoRoute(
        path: loginRoute,
        name: 'login',
        pageBuilder: (context, state) =>
            MaterialPage(key: state.pageKey, child: const Placeholder()),
      ),
      GoRoute(
        path: homeRoute,
        name: 'home',
        pageBuilder: (context, state) =>
            MaterialPage(key: state.pageKey, child: const Placeholder()),
      ),
    ],

    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text('Route not found: ${state.uri.path}')),
    ),
  );

  static void triggerOnboardingCheck() {
    _shouldCheckOnboarding = true;
  }

  static Future<void> completeOnboarding() async {
    await SharedPrefHelper.setData(onboardingCompletedKey, true);
    _cachedOnboardingCompleted = true;
  }

  static Future<void> resetOnboarding() async {
    await SharedPrefHelper.removeData(onboardingCompletedKey);
    _cachedOnboardingCompleted = null;
    _shouldCheckOnboarding = false;
  }
}
