import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:team_7/core/routing/routes.dart';
import 'package:team_7/core/theming/app_colors.dart';
import 'package:team_7/core/theming/app_text.dart';
import 'package:team_7/features/auth/domain/repository/fingerprint_sevice.dart';

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
            FingerprintService.requestBiometric().then((value) {
              if (value) {
                if (context.mounted) {
                  context.go(Routes.homeRoute);
                }
              }
            });
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
