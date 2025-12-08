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

  static final GoRouter router = GoRouter(
    initialLocation: splashRoute,

    redirect: (context, state) async {
      final Path = state.uri.path;

      if (Path == splashRoute) {
        return null;
      }

      final onboardingCompleted = await SharedPrefHelper.getBool(
        onboardingCompletedKey,
      );

      if (!onboardingCompleted) {
        return onboardingRoute;
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

  static Future<void> completeOnboarding() async {
    await SharedPrefHelper.setData(onboardingCompletedKey, true);
  }
}
