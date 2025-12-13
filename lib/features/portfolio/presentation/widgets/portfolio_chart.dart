import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:team_7/core/responsive/size_extensions.dart';
import 'package:team_7/core/theming/theme_extensions.dart';
import 'package:team_7/core/theming/app_colors.dart';
import 'package:team_7/core/theming/app_text.dart';
import 'package:team_7/core/responsive/app_spacing.dart';
import 'package:team_7/features/portfolio/data/models/portfolio_balance_model.dart';

class PortfolioChart extends StatelessWidget {
  final PortfolioBalanceModel balance;

  const PortfolioChart({super.key, required this.balance});

  // Map coin IDs to colors
  Color _getCoinColor(String coinId) {
    switch (coinId.toLowerCase()) {
      case 'bitcoin':
        return AppExtraColors.purple;
      case 'ethereum':
        return AppExtraColors.cyanLight;
      case 'litecoin':
        return AppExtraColors.softRed;
      default:
        return AppExtraColors.blueAccent;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Prepare holdings data for chart
    final holdings = balance.allocations.map((allocation) {
      return {
        'symbol': allocation.symbol,
        'value': allocation.value,
        'color': _getCoinColor(allocation.coinId),
      };
    }).toList();

    final total = balance.totalValue;

    return Row(
      children: [
        // Donut Chart
        SizedBox(
          width: context.wp(40),
          height: context.wp(40),
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                size: Size(context.wp(40), context.wp(40)),
                painter: DonutChartPainter(holdings: holdings, total: total),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    balance.formattedTotalValue,
                    style: AppText.white12Medium.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.onSurface,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        AppSpacing.w16,

        // Legend
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: holdings.map((holding) {
              final value = holding['value'] as double;
              final symbol = holding['symbol'] as String;
              final color = holding['color'] as Color;

              return Padding(
                padding: EdgeInsets.only(bottom: context.hp(1.5)),
                child: Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    AppSpacing.w8,
                    Expanded(
                      child: Text(
                        '\$${value.toStringAsFixed(2)} $symbol',
                        style: AppText.white14Regular.copyWith(
                          fontWeight: FontWeight.w500,
                          color: context.onSurface,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class DonutChartPainter extends CustomPainter {
  final List<Map<String, dynamic>> holdings;
  final double total;

  DonutChartPainter({required this.holdings, required this.total});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 10;
    final innerRadius = radius * 0.7;

    double startAngle = -math.pi / 2; // Start from top

    for (final holding in holdings) {
      final value = holding['value'] as double;
      final sweepAngle = (value / total) * 2 * math.pi;
      final color = holding['color'] as Color;

      // Draw arc
      final paint = Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = radius - innerRadius
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        Rect.fromCircle(
          center: center,
          radius: radius - (radius - innerRadius) / 2,
        ),
        startAngle,
        sweepAngle,
        false,
        paint,
      );

      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant DonutChartPainter oldDelegate) {
    return oldDelegate.total != total || oldDelegate.holdings != holdings;
  }
}
