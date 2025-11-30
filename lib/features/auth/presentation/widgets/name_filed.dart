import 'package:flutter/material.dart';
import 'package:team_7/core/utils/validators.dart';
import 'package:team_7/core/shared_widgets/custom_text_field.dart';

class NameField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;

  const NameField({super.key, required this.controller, required this.hint});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return CustomTextField(
      controller: controller,
      hint: hint,
      keyboardType: TextInputType.name,
      validator: Validators.validateName,
      prefixIcon: Icon(Icons.person_outline, color: colorScheme.onSurfaceVariant),
    );
  }
}
