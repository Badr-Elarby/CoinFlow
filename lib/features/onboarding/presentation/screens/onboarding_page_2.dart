import 'package:flutter/material.dart';
import 'package:team_7/features/onboarding/presentation/widgets/onboarding_content.dart';

class OnboardingPage2 extends StatelessWidget {
  const OnboardingPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return const OnboardingContent(
      imagePath: 'assets/images/onboarding_2.png',
      title: 'Transaction Security',
    );
  }
}
