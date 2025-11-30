import 'package:flutter/material.dart';
import 'package:team_7/core/utils/validators.dart';
import 'package:team_7/features/auth/presentation/widgets/password_text_field.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController controller;

  const PasswordField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return PasswordTextField(
      controller: controller,
      hint: 'Password',
      validator: Validators.validatePassword,
    );
  }
}

class ConfirmPasswordField extends StatelessWidget {
  final TextEditingController controller;
  final TextEditingController passwordController;

  const ConfirmPasswordField({
    super.key,
    required this.controller,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return PasswordTextField(
      controller: controller,
      hint: 'Confirm Password',
      validator: (value) =>
          Validators.validateConfirmPassword(value, passwordController.text),
    );
  }
}
