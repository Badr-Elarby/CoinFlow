import 'package:flutter/material.dart';
import 'package:team_7/core/theming/app_text.dart';

class SignUpHeader extends StatelessWidget {
  const SignUpHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        Text(
          'Create Your Account',
          style: AppText.bold26.copyWith(color: colorScheme.primary),
        ),
        const SizedBox(height: 12),
        Text(
          'Sign up to enjoy the best managing\nexperience!',
          textAlign: TextAlign.center,
          style: AppText.semiBold18.copyWith(color: colorScheme.primary),
        ),
      ],
    );
  }
}
