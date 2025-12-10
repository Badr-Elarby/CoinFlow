import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:team_7/core/responsive/size_extensions.dart';
import 'package:team_7/core/routing/app_router.dart';
import 'package:team_7/core/theming/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateAfterDelay();
  }

  Future<void> _navigateAfterDelay() async {
    await Future.delayed(const Duration(seconds: 4));

    if (!mounted) return;

    context.go(AppRouter.loginRoute);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final logoAsset = isDark
        ? 'assets/images/splash_logo_dark.png'
        : 'assets/images/splash_logo_light.png';

    final outerCircleAsset = isDark
        ? 'assets/images/splash_circle_dark1.png'
        : 'assets/images/splash_circle_light1.png';

    final innerCircleAsset = isDark
        ? 'assets/images/splash_circle_dark2.png'
        : 'assets/images/splash_circle_light2.png';

    final colorScheme = isDark
        ? AppColors.darkColorScheme
        : AppColors.lightColorScheme;
    final backgroundColor = colorScheme.surfaceContainerHighest;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: context.hp(9),
              child: Image.asset(
                outerCircleAsset,
                width: context.wp(100),
                height: context.hp(80),
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              top: context.hp(22),
              child: Image.asset(
                innerCircleAsset,
                width: context.wp(100),
                height: context.hp(55),
                fit: BoxFit.contain,
              ),
            ),
            Center(
              child: Image.asset(
                logoAsset,
                width: context.wp(35),
                height: context.wp(35),
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
