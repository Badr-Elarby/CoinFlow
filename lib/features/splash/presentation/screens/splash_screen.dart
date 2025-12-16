import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:team_7/core/responsive/size_extensions.dart';
import 'package:team_7/core/routing/routes.dart';
import 'package:team_7/core/theming/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller for the breathing effect
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    // Define scale range (subtle breathing)
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 3.1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _navigateAfterDelay();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _navigateAfterDelay() async {
    await Future.delayed(const Duration(seconds: 4));

    if (!mounted) return;

    context.go(Routes.signInRoute);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final logoAsset = isDark
        ? 'assets/images/splash_logo_dark.png'
        : 'assets/images/splash_logo_light.png';

    // Use both SVGs for the background effect as requested
    // splash_circle2 is larger (Outer), splash_circle1 is smaller (Inner)
    const outerCircleSvg = 'assets/images/splash_circle2.svg';
    const innerCircleSvg = 'assets/images/splash_circle1.svg';

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
            // Outer Circle (Larger) - Back Layer
            Positioned(
              top: context.hp(010),
              left: 0,
              right: 0,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _scaleAnimation.value,
                    child: child,
                  );
                },
                child: SvgPicture.asset(
                  outerCircleSvg,
                  width: context.wp(100),
                  // Allow height to scale naturally
                  placeholderBuilder: (context) => const SizedBox.shrink(),
                ),
              ),
            ),

            // Inner Circle (Smaller) - Middle Layer
            Positioned(
              top: context.hp(28),
              left: 0,
              right: 0,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _scaleAnimation.value,
                    child: child,
                  );
                },
                child: SvgPicture.asset(
                  innerCircleSvg,
                  width: context.wp(90),
                  // Allow height to scale naturally
                  placeholderBuilder: (context) => const SizedBox.shrink(),
                ),
              ),
            ),

            // App Logo
            Center(
              child: Image.asset(
                logoAsset,
                width: context.wp(30),
                height: context.wp(30),
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
