import 'package:flutter/material.dart';
import 'package:team_7/core/theming/app-text.dart';

class FingerprintFooter extends StatelessWidget {
  const FingerprintFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        Text(
          'Place your finger in fingerprint\nsensor until the icon completely',
          textAlign: TextAlign.center,
          style: AppText.semiBold18.copyWith(color: colorScheme.primary),
        ),
      ],
    );
  }
}
