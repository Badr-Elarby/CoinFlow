import 'package:flutter/material.dart';
import 'package:team_7/core/theming/app-text.dart';
import 'package:team_7/core/theming/app_colors.dart';
import 'package:team_7/features/auth/presentation/pages/sign_up_screen.dart';

class AlreadyHaveAnAccount extends StatelessWidget {
  const AlreadyHaveAnAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (context) => const SignUpScreen()));
      },
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: 'Already have an account? ',
              style: AppText.medium18.copyWith(color: AppExtraColors.paleSky),
            ),
            TextSpan(text: 'Sign Up', style: AppText.medium18),
          ],
        ),
      ),
    );
  }
}
