import 'package:flutter/material.dart';
import 'package:team_7/core/utils/validators.dart';
import 'package:team_7/core/shared_widgets/custom_text_field.dart';

class PhoneField extends StatelessWidget {
  final TextEditingController controller;

  const PhoneField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return CustomTextField(
      controller: controller,
      hint: 'XXX XXX XXXX',
      keyboardType: TextInputType.phone,
      validator: Validators.validatePhone,
      prefixIcon: Icon(Icons.phone_outlined, color: colorScheme.onSurfaceVariant),
    );
  }
}
