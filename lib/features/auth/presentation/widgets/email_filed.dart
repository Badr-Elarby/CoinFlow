import 'package:flutter/material.dart';
import 'package:team_7/core/utils/validators.dart';
import 'package:team_7/core/shared_widgets/custom_text_field.dart';

class EmailField extends StatelessWidget {
  final TextEditingController controller;

  const EmailField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return CustomTextField(
      controller: controller,
      hint: 'Email-ID',
      keyboardType: TextInputType.emailAddress,
      validator: Validators.validateEmail,
      prefixIcon: Icon(Icons.email_outlined, color: colorScheme.onSurfaceVariant),
    );
  }
}
