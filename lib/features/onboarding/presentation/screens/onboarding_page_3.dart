import 'package:flutter/material.dart';
import 'package:team_7/features/onboarding/presentation/widgets/onboarding_content.dart';

class OnboardingPage3 extends StatelessWidget {
  const OnboardingPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return const OnboardingContent(
      imagePath: 'assets/images/onboarding_3.png',
      title: 'Fast And Reliable Market\nUpdated',
    );
  }
}
