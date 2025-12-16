import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:team_7/core/theming/app_colors.dart';
import 'package:team_7/core/theming/app_text.dart';
import 'package:team_7/core/routing/routes.dart';

class AlreadyHaveAnAccount extends StatelessWidget {
  const AlreadyHaveAnAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.go(Routes.signUpRoute);
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
