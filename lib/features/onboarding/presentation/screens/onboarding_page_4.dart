import 'package:flutter/material.dart';
import 'package:team_7/core/responsive/size_extensions.dart';
import 'package:team_7/features/onboarding/presentation/widgets/onboarding_content.dart';
import 'package:team_7/features/onboarding/presentation/widgets/onboarding_action_buttons.dart';

class OnboardingPage4 extends StatelessWidget {
  const OnboardingPage4({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OnboardingContent(
          imagePath: 'assets/images/onboarding_4.png',
          title: 'Get Started Now!',
          imageHeight: context.hp(35),
          imageWidth: context.wp(70),
        ),

        SizedBox(height: context.hp(8)),

        const OnboardingActionButtons(),
      ],
    );
  }
}
