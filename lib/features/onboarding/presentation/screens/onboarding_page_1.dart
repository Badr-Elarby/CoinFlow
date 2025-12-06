import 'package:flutter/material.dart';
import 'package:team_7/features/onboarding/presentation/widgets/onboarding_content.dart';

class OnboardingPage1 extends StatelessWidget {
  const OnboardingPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return const OnboardingContent(
      imagePath: 'assets/images/onboarding_1.png',
      title: 'Welcome To ',
      highlightedText: 'Crypto X',
    );
  }
}
