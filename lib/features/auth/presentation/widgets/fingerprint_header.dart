import 'package:flutter/material.dart';
import 'package:team_7/core/theming/app_text.dart';

class FingerprintHeader extends StatelessWidget {
  const FingerprintHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        Text(
          'Set Your Finger Print',
          style: AppText.bold26.copyWith(color: colorScheme.primary),
        ),
        const SizedBox(height: 12),
        Text(
          'Add a fingerprint to make your account\nmore secure.',
          textAlign: TextAlign.center,
          style: AppText.semiBold18.copyWith(color: colorScheme.primary),
        ),
      ],
    );
  }
}
