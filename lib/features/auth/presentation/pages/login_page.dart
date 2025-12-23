import 'package:flutter/material.dart';
import 'package:team_7/core/shared_widgets/custom_button.dart';
import 'package:team_7/core/theming/app_colors.dart';
import 'package:team_7/features/auth/presentation/widgets/background_decoration.dart';
import 'package:team_7/features/auth/presentation/widgets/fingerprint_footer.dart';
import 'package:team_7/features/auth/presentation/widgets/fingerprint_header.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerHighest,
      body: Stack(
        children: [
          const BackgroundDecoration(),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 40),
                  const FingerprintHeader(),
                  Image.asset("assets/images/fingerprint.png"),
                  const FingerprintFooter(),
                  const SizedBox(height: 60),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: CustomButton(
                      text: "Skip",
                      onPressed: (){
                        //todo:mohand
                      },
                      backgroundColor: AppExtraColors.transparent,
                      isOutlined: true,
                      width: 160,
                      textColor: colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
