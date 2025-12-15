import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:team_7/core/constants/assets_paths.dart';
import 'package:team_7/core/theming/app-text.dart';
import 'package:team_7/features/auth/data/models/sign_in_request_model.dart';
import 'package:team_7/features/auth/domain/repository/fingerprint_sevice.dart';
import 'package:team_7/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:team_7/features/auth/presentation/widgets/already_have_an_account.dart';
import 'package:team_7/features/auth/presentation/widgets/background_decoration.dart';
import 'package:team_7/features/auth/presentation/widgets/login_button.dart';
import 'package:team_7/features/auth/presentation/widgets/login_form.dart';
import 'package:team_7/features/auth/presentation/widgets/or_login_with.dart';
import 'package:team_7/features/auth/presentation/widgets/remember_forgot_section.dart';
import 'package:team_7/features/home/presentation/pages/home_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        switch (state) {
          case AuthSuccess():
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
            break;
          case AuthError(:final errorMessage):
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(errorMessage.errorMessage),
                backgroundColor: Colors.red,
              ),
            );
            break;
          case AuthInitial():
          case AuthLoading():
            break;
        }
      },
      child: Scaffold(
        backgroundColor: colorScheme.surfaceContainerHighest,
        body: Form(
          key: _formKey,
          child: Stack(
            children: [
              const BackgroundDecoration(),
              SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 30,
                  ),
                  child: Column(
                    children: [
                      Text('Login To Your Account', style: AppText.bold26),
                      const SizedBox(height: 10),
                      Text(
                        'Welcome back you’ve\n been missed!',
                        textAlign: TextAlign.center,
                        style: AppText.semiBold18,
                      ),
                      const SizedBox(height: 100),
                      LoginForm(
                        emailController: _emailController,
                        passwordController: _passwordController,
                      ),
                      const RememberForgotSection(),
                      const SizedBox(height: 20),
                      LoginButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthCubit>().login(
                              SignInRequestModel(
                                email: _emailController.text.trim(),
                                password: _passwordController.text,
                              ),
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      const OrLoginWith(),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              FingerprintService.requestBiometric().then((
                                value,
                              ) {
                                if (value) {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => const HomeScreen(),
                                    ),
                                  );
                                }
                              });
                            },
                            child: SvgPicture.asset(
                              '${AssetsPaths.svgPath}icon_finger.svg',
                            ),
                          ),
                          const SizedBox(width: 80),
                          SvgPicture.asset('${AssetsPaths.svgPath}Face_ID.svg'),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const AlreadyHaveAnAccount(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
