import 'package:flutter/material.dart';
import 'package:team_7/core/theming/app_text.dart';

class OrLoginWith extends StatelessWidget {
  const OrLoginWith({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: colorScheme.outline,
            thickness: 1,
            height: 1,
            indent: 30,
          ),
        ),
        const SizedBox(width: 10),
        Text('Or Login with', style: AppText.semiBold12),
        const SizedBox(width: 10),
        Expanded(
          child: Divider(
            color: colorScheme.outline,
            thickness: 1,
            height: 1,
            endIndent: 30,
          ),
        ),
      ],
    );
  }
}
