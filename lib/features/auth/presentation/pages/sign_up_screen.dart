import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_7/core/theming/app_colors.dart';
import 'package:team_7/features/auth/presentation/cubit/sign_up_cubit.dart';
import 'package:team_7/features/auth/presentation/widgets/background_decoration.dart';
import 'package:team_7/features/auth/presentation/widgets/login_link.dart';
import 'package:team_7/features/auth/presentation/widgets/register_button.dart';
import 'package:team_7/features/auth/presentation/widgets/sign_up_form_field.dart';
import 'package:team_7/features/auth/presentation/widgets/sign_up_header.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onSignUpPressed(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<SignUpCubit>().signUp(
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
        confirmPassword: _confirmPasswordController.text,
        phone: _phoneController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.onPrimary,
      body: BlocListener<SignUpCubit, SignUpState>(
        listener: (context, state) {
          switch (state) {
            case SignUpSuccess():
              _showSuccessMessage(context);
              break;
            case SignUpError(:final errorMessage):
              _showErrorMessage(context, errorMessage);
              break;
            case SignUpInitial():
            case SignUpLoading():
              break;
          }
        },
        child: Stack(
          children: [
            const BackgroundDecoration(),
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 30,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      const SignUpHeader(),
                      const SizedBox(height: 50),
                      SignUpFormFields(
                        firstNameController: _firstNameController,
                        lastNameController: _lastNameController,
                        emailController: _emailController,
                        phoneController: _phoneController,
                        passwordController: _passwordController,
                        confirmPasswordController: _confirmPasswordController,
                      ),
                      const SizedBox(height: 30),
                      RegisterButton(
                        onPressed: () => _onSignUpPressed(context),
                      ),
                      const SizedBox(height: 26),
                      const LoginLink(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSuccessMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Account created successfully! Please verify your email.',
        ),
        backgroundColor: AppExtraColors.success,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showErrorMessage(BuildContext context, String? message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message ?? 'Sign up failed'),
        backgroundColor: AppExtraColors.warning,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
