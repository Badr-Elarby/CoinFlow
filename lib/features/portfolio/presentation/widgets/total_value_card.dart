import 'package:flutter/material.dart';
import 'package:team_7/core/responsive/size_extensions.dart';
import 'package:team_7/core/theming/theme_extensions.dart';
import 'package:team_7/core/theming/app_colors.dart';
import 'package:team_7/core/theming/app_text.dart';
import 'package:team_7/core/responsive/app_spacing.dart';
import 'package:team_7/features/portfolio/data/models/portfolio_balance_model.dart';

class TotalValueCard extends StatelessWidget {
  final PortfolioBalanceModel balance;

  const TotalValueCard({super.key, required this.balance});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: context.secondary),
        child: Stack(
          children: [
            // Background Decoration (Simulated SVG Circles)
            const Positioned.fill(
              child: IgnorePointer(child: _BackgroundDecoration()),
            ),

            // Content
            Padding(
              padding: EdgeInsets.all(context.wp(4)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Value',
                    style: AppText.white14Regular.copyWith(
                      color: AppExtraColors.white.withValues(alpha: 0.8),
                    ),
                  ),
                  AppSpacing.h8,
                  Text(
                    balance.formattedTotalValue,
                    style: AppText.white28Bold.copyWith(fontSize: 32),
                  ),
                  AppSpacing.h4,
                  Row(
                    children: [
                      Text(
                        '${balance.formattedDailyChangePercentage} (${balance.formattedDailyChange}) Today',
                        style: balance.isDailyPositive
                            ? AppText.success14Medium
                            : AppText.white14Regular.copyWith(
                                color: AppExtraColors.danger,
                              ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BackgroundDecoration extends StatelessWidget {
  const _BackgroundDecoration();

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        // Left Group (Top-Left)
        Positioned(top: 0, left: 0, child: _CircleGroup(isLeft: true)),
        // Right Group (Top-Right)
        Positioned(top: 0, right: 0, child: _CircleGroup(isLeft: false)),
      ],
    );
  }
}

class _CircleGroup extends StatelessWidget {
  final bool isLeft;

  const _CircleGroup({required this.isLeft});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    // Dark theme: #0D0D0D base. Light theme: White base.
    final baseColor = isDark ? const Color(0xFF0D0D0D) : Colors.white;

    // Opacity levels: 50% -> 30% -> 20%
    // We render from Back (Large/LowOpacity) to Front (Small/HighOpacity)
    // to achieve the overlapping glow effect.
    final opacities = isDark
        ? [0.1, 0.2, 0.25] // Dark mode: Stronger shadows
        : [0.03, 0.05, 0.1]; // Light mode: Subtle reflection

    final sizes = [260.0, 200.0, 140.0]; // Large, Mid, Small

    // Provide explicit bounds for Stack (largest circle size)
    return SizedBox(
      width: sizes[0],
      height: sizes[0],
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          // Large (Back)
          _buildCircle(sizes[0], baseColor, opacities[0]),
          // Mid
          _buildCircle(sizes[1], baseColor, opacities[1]),
          // Small (Front)
          _buildCircle(sizes[2], baseColor, opacities[2]),
        ],
      ),
    );
  }

  Widget _buildCircle(double size, Color color, double opacity) {
    return Positioned(
      top: -size / 2, // Center vertically on top edge
      left: isLeft ? -size / 2 : null,
      right: !isLeft ? -size / 2 : null,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withValues(alpha: opacity),
        ),
      ),
    );
  }
}
