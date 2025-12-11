import 'package:flutter/material.dart';
import 'package:team_7/core/theming/app-text.dart';
import 'package:team_7/core/theming/app_colors.dart';
import 'package:team_7/features/auth/domain/repository/fingerprint_sevice.dart';
import 'package:team_7/features/home/presentation/pages/home_screen.dart';

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
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
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
