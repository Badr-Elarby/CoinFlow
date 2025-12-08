import 'package:flutter/material.dart';
import 'package:team_7/core/shared_widgets/custom_text_field.dart';
import 'package:team_7/core/utils/validators.dart';

class SignUpFormFields extends StatefulWidget {
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
  State<SignUpFormFields> createState() => _SignUpFormFieldsState();
}

class _SignUpFormFieldsState extends State<SignUpFormFields> {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        CustomTextField(
          controller: widget.firstNameController,
          hint: 'First Name',
          keyboardType: TextInputType.name,
          validator: Validators.validateName,
          prefixIcon: Icon(
            Icons.person_outline,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 16),
        CustomTextField(
          controller: widget.lastNameController,
          hint: 'Last Name',
          keyboardType: TextInputType.name,
          validator: Validators.validateName,
          prefixIcon: Icon(
            Icons.person_outline,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 16),
        CustomTextField(
          controller: widget.emailController,
          hint: 'Email-ID',
          keyboardType: TextInputType.emailAddress,
          validator: Validators.validateEmail,
          prefixIcon: Icon(
            Icons.email_outlined,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 16),
        CustomTextField(
          controller: widget.passwordController,
          hint: 'Password',
          obscureText: !_isPasswordVisible,
          validator: Validators.validatePassword,
          prefixIcon: Icon(
            Icons.lock_outline,
            color: colorScheme.onSurfaceVariant,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
              color: colorScheme.onSurfaceVariant,
            ),
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
          ),
        ),
        const SizedBox(height: 16),
        CustomTextField(
          controller: widget.confirmPasswordController,
          hint: 'Confirm Password',
          obscureText: !_isConfirmPasswordVisible,
          validator: (value) => Validators.validateConfirmPassword(
            value,
            widget.passwordController.text,
          ),
          prefixIcon: Icon(
            Icons.lock_outline,
            color: colorScheme.onSurfaceVariant,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _isConfirmPasswordVisible
                  ? Icons.visibility_off
                  : Icons.visibility,
              color: colorScheme.onSurfaceVariant,
            ),
            onPressed: () {
              setState(() {
                _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
              });
            },
          ),
        ),
        const SizedBox(height: 16),
        CustomTextField(
          controller: widget.phoneController,
          hint: 'XXX XXX XXXX',
          keyboardType: TextInputType.phone,
          validator: Validators.validatePhone,
          prefixIcon: Icon(
            Icons.phone_outlined,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
