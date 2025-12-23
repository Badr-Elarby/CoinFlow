import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_7/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:team_7/core/shared_widgets/custom_button.dart';

class RegisterButton extends StatelessWidget {
  final VoidCallback onPressed;

  const RegisterButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return CustomButton(
          text: 'Register',
          onPressed: onPressed,
          isLoading: state is AuthLoading,
          width: double.infinity,
          backgroundColor: colorScheme.primary,
          textColor: colorScheme.onPrimary,
        );
      },
    );
  }
}
