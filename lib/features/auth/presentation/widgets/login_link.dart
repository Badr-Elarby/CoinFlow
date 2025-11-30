import 'package:flutter/material.dart';
import 'package:team_7/core/theming/app-text.dart';
import 'package:team_7/core/theming/app_colors.dart';

class LoginLink extends StatelessWidget {
  const LoginLink({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account? ',
          style: AppText.medium18.copyWith(color: AppExtraColors.paleSky),
        ),
        GestureDetector(
          onTap: () {
            //todo: mohand
          },
          child: Text(
            'Login',
            style: AppText.medium18.copyWith(color: colorScheme.primary),
          ),
        ),
      ],
    );
  }
}
