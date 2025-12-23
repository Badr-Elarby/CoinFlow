import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:team_7/core/responsive/size_extensions.dart';
import 'package:team_7/core/routing/app_router.dart';
import 'package:team_7/core/routing/routes.dart';

class OnboardingActionButtons extends StatelessWidget {
  const OnboardingActionButtons({super.key});

  Future<void> _completeOnboarding(BuildContext context) async {
    await AppRouter.completeOnboarding();
    if (context.mounted) {
      context.go(Routes.signInRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final onPrimary = Theme.of(context).colorScheme.onPrimary;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.wp(6)),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () => _completeOnboarding(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Login',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          const SizedBox(height: 16),

          SizedBox(
            width: double.infinity,
            height: 56,
            child: OutlinedButton(
              onPressed: () => context.go(Routes.signUpRoute),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: primaryColor, width: 1.5),
                foregroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Register',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
