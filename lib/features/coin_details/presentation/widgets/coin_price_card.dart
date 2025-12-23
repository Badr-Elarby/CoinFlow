import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:team_7/core/theming/app_colors.dart';
import 'package:team_7/core/theming/theme_extensions.dart';
import 'package:team_7/features/coin_details/data/model/coin_details_model.dart';
import 'package:team_7/features/coin_details/data/model/market_chart_response.dart';
import 'package:team_7/features/coin_details/presentation/cubit/coin_details_cubit.dart';
import 'package:team_7/features/coin_details/presentation/widgets/coin_price_chart.dart';

class CoinPriceCard extends StatelessWidget {
  final CoinDetailsModel coinDetails;
  final List<ChartDataPoint> chartData;
  final String selectedDays;
  final String coinId;

  const CoinPriceCard({
    super.key,
    required this.coinDetails,
    required this.chartData,
    required this.selectedDays,
    required this.coinId,
  });

  static const List<Map<String, String>> _timeRanges = [
    {'label': '1d', 'days': '1'},
    {'label': '1w', 'days': '7'},
    {'label': '1m', 'days': '30'},
    {'label': '3m', 'days': '90'},
    {'label': '1y', 'days': '365'},
  ];

  @override
  Widget build(BuildContext context) {
    final isPositive = coinDetails.isPriceChangePositive;
    final changeColor = isPositive 
        ? AppExtraColors.success 
        : AppExtraColors.danger;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: context.outline.withAlpha(51),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: context.outline.withAlpha(20),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      coinDetails.formattedPrice,
                      style: GoogleFonts.lato(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: context.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '/ 1 ${coinDetails.symbol.toUpperCase()}',
                      style: GoogleFonts.lato(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: context.onSurface.withAlpha(128),
                      ),
                    ),
                  ],
                ),
              ),
              _buildPriceChangeBadge(changeColor, isPositive),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 120,
            child: chartData.isNotEmpty
                ? CoinPriceChart(
                    chartData: chartData,
                    chartColor: changeColor,
                  )
                : Center(
                    child: CircularProgressIndicator(
                      color: context.primary,
                      strokeWidth: 2,
                    ),
                  ),
          ),
          const SizedBox(height: 16),
          _buildTimeRangeSelector(context),
        ],
      ),
    );
  }

  Widget _buildPriceChangeBadge(Color color, bool isPositive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withAlpha(26),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isPositive
                ? Icons.arrow_drop_up_rounded
                : Icons.arrow_drop_down_rounded,
            color: color,
            size: 20,
          ),
          Text(
            coinDetails.formattedPriceChange,
            style: GoogleFonts.lato(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeRangeSelector(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: _timeRanges.map((range) {
        final isSelected = selectedDays == range['days'];
        return GestureDetector(
          onTap: () {
            context.read<CoinDetailsCubit>().changeTimeRange(
              coinId,
              range['days']!,
            );
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected 
                  ? AppExtraColors.blueAccent 
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              range['label']!,
              style: GoogleFonts.lato(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isSelected 
                    ? Colors.white 
                    : context.onSurface.withAlpha(128),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

