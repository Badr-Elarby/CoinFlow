import 'package:flutter/material.dart';
import 'package:team_7/core/shared_widgets/custom_text_field.dart';
import 'package:team_7/core/utils/validators.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          hint: 'Email',
          prefixIcon: Icon(Icons.email),
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          validator: Validators.validateEmail,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          hint: 'Password',
          prefixIcon: Icon(Icons.lock),
          controller: passwordController,
          obscureText: true,
          validator: Validators.validatePassword,
        ),
      ],
    );
  }
}
