import 'package:flutter/material.dart';
import 'package:team_7/features/auth/presentation/widgets/email_filed.dart';
import 'package:team_7/features/auth/presentation/widgets/name_filed.dart';
import 'package:team_7/features/auth/presentation/widgets/password_and_confirm_password_filed.dart';
import 'package:team_7/features/auth/presentation/widgets/phone_filed.dart';

class SignUpFormFields extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const SignUpFormFields({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.phoneController,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NameField(
          controller: firstNameController,
          hint: 'First Name',
        ),
        const SizedBox(height: 16),
        NameField(
          controller: lastNameController,
          hint: 'Last Name',
        ),
        const SizedBox(height: 16),
        EmailField(controller: emailController),
        const SizedBox(height: 16),
        PasswordField(controller: passwordController),
        const SizedBox(height: 16),
        ConfirmPasswordField(
          controller: confirmPasswordController,
          passwordController: passwordController,
        ),
        const SizedBox(height: 16),
        PhoneField(controller: phoneController),
      ],
    );
  }
}