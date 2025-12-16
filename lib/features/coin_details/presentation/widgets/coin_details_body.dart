import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:team_7/core/theming/theme_extensions.dart';
import 'package:team_7/features/coin_details/data/model/coin_details_model.dart';
import 'package:team_7/features/coin_details/data/model/market_chart_response.dart';
import 'package:team_7/features/coin_details/presentation/widgets/coin_price_card.dart';
import 'package:team_7/features/coin_details/presentation/widgets/coin_statistics.dart';
import 'package:team_7/features/coin_details/presentation/widgets/coin_about_section.dart';
import 'package:team_7/features/coin_details/presentation/widgets/coin_action_buttons.dart';

class CoinDetailsBody extends StatelessWidget {
  final CoinDetailsModel coinDetails;
  final List<ChartDataPoint> chartData;
  final String selectedDays;
  final String coinId;

  const CoinDetailsBody({
    super.key,
    required this.coinDetails,
    required this.chartData,
    required this.selectedDays,
    required this.coinId,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                _buildCoinTitle(context),
                const SizedBox(height: 20),
                CoinPriceCard(
                  coinDetails: coinDetails,
                  chartData: chartData,
                  selectedDays: selectedDays,
                  coinId: coinId,
                ),
                const SizedBox(height: 24),
                CoinStatistics(coinDetails: coinDetails),
                const SizedBox(height: 24),
                if (coinDetails.description != null && 
                    coinDetails.description!.isNotEmpty)
                  CoinAboutSection(coinDetails: coinDetails),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
        const CoinActionButtons(),
      ],
    );
  }

  Widget _buildCoinTitle(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: context.surface,
            boxShadow: [
              BoxShadow(
                color: context.outline.withAlpha(30),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipOval(
            child: coinDetails.image != null
                ? Image.network(
                    coinDetails.image!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Icon(
                      Icons.currency_bitcoin_rounded,
                      color: context.primary,
                      size: 24,
                    ),
                  )
                : Icon(
                    Icons.currency_bitcoin_rounded,
                    color: context.primary,
                    size: 24,
                  ),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          coinDetails.name,
          style: GoogleFonts.lato(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: context.onSurface,
          ),
        ),
      ],
    );
  }
}

