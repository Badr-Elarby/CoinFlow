import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:team_7/core/theming/theme_extensions.dart';
import 'package:team_7/features/coin_details/data/model/market_chart_response.dart';

class CoinPriceChart extends StatelessWidget {
  final List<ChartDataPoint> chartData;
  final Color chartColor;

  const CoinPriceChart({
    super.key,
    required this.chartData,
    required this.chartColor,
  });

  @override
  Widget build(BuildContext context) {
    if (chartData.isEmpty) {
      return const Center(child: Text('No chart data available'));
    }

    final spots = _generateSpots();
    if (spots.isEmpty) {
      return const Center(child: Text('No chart data available'));
    }

    final minY = spots.map((s) => s.y).reduce(min) * 0.98;
    final maxY = spots.map((s) => s.y).reduce(max) * 1.02;

    return LineChart(
      LineChartData(
        gridData: const FlGridData(show: false),
        titlesData: const FlTitlesData(
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        minX: 0,
        maxX: (spots.length - 1).toDouble(),
        minY: minY,
        maxY: maxY,
        lineTouchData: LineTouchData(
          enabled: true,
          touchTooltipData: LineTouchTooltipData(
            getTooltipColor: (_) => context.surface,
            tooltipBorder: BorderSide(
              color: context.outline.withAlpha(51),
              width: 1,
            ),
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((spot) {
                return LineTooltipItem(
                  '\$${spot.y.toStringAsFixed(2)}',
                  GoogleFonts.lato(
                    color: chartColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                );
              }).toList();
            },
          ),
          handleBuiltInTouches: true,
        ),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            curveSmoothness: 0.3,
            color: chartColor,
            barWidth: 2.5,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  chartColor.withAlpha(80),
                  chartColor.withAlpha(10),
                ],
              ),
            ),
          ),
        ],
      ),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  List<FlSpot> _generateSpots() {
    // Sample to avoid too many points
    final dataLength = chartData.length;
    final sampleRate = dataLength > 100 ? (dataLength / 100).ceil() : 1;
    
    final List<FlSpot> spots = [];
    for (int i = 0; i < dataLength; i += sampleRate) {
      final price = chartData[i].price;
      spots.add(FlSpot(spots.length.toDouble(), price));
    }
    
    // Make sure we include the last point
    if (spots.isNotEmpty && chartData.isNotEmpty) {
      final lastPrice = chartData.last.price;
      if (spots.last.y != lastPrice) {
        spots.add(FlSpot(spots.length.toDouble(), lastPrice));
      }
    }
    
    return spots;
  }
}

