import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:team_7/core/theming/app_colors.dart';
import 'package:team_7/core/theming/theme_extensions.dart';
import 'package:team_7/features/coin_details/data/model/coin_details_model.dart';

class CoinStatistics extends StatelessWidget {
  final CoinDetailsModel coinDetails;

  const CoinStatistics({super.key, required this.coinDetails});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Statistics',
          style: GoogleFonts.lato(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: context.onSurface,
          ),
        ),
        const SizedBox(height: 16),
        _buildStatRow(
          context,
          label: 'Current Price',
          value: _formatCurrency(coinDetails.currentPrice),
          dotColor: AppExtraColors.blueAccent,
        ),
        _buildStatRow(
          context,
          label: 'Market Cap',
          value: _formatLargeNumber(coinDetails.marketCap),
          dotColor: AppExtraColors.purple,
        ),
        _buildStatRow(
          context,
          label: 'Volume 24h',
          value: _formatLargeNumber(coinDetails.volume24h),
          dotColor: AppExtraColors.cyanLight,
        ),
        _buildStatRow(
          context,
          label: 'Circulating Supply',
          value: _formatSupply(coinDetails.circulatingSupply),
          dotColor: AppExtraColors.warning,
        ),
        _buildStatRow(
          context,
          label: 'Max Supply',
          value: coinDetails.maxSupply != null
              ? _formatSupply(coinDetails.maxSupply)
              : '∞',
          dotColor: AppExtraColors.success,
          isLast: true,
        ),
      ],
    );
  }

  Widget _buildStatRow(
    BuildContext context, {
    required String label,
    required String value,
    required Color dotColor,
    bool isLast = false,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Row(
            children: [
              Text(
                label,
                style: GoogleFonts.lato(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: context.onSurface.withAlpha(179),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: dotColor,
                  shape: BoxShape.circle,
                ),
              ),
              const Spacer(),
              Text(
                value,
                style: GoogleFonts.lato(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: context.onSurface,
                ),
              ),
            ],
          ),
        ),
        if (!isLast)
          Divider(
            height: 1,
            color: context.outline.withAlpha(51),
          ),
      ],
    );
  }

  String _formatCurrency(double? value) {
    if (value == null) return '\$0.00';
    if (value >= 1000) {
      return '\$${_formatNumber(value)}';
    }
    return '\$${value.toStringAsFixed(value < 1 ? 4 : 2)}';
  }

  String _formatLargeNumber(double? value) {
    if (value == null) return '\$0';
    if (value >= 1e12) {
      return '\$${(value / 1e12).toStringAsFixed(2)}T';
    } else if (value >= 1e9) {
      return '\$${(value / 1e9).toStringAsFixed(2)}B';
    } else if (value >= 1e6) {
      return '\$${(value / 1e6).toStringAsFixed(2)}M';
    }
    return '\$${_formatNumber(value)}';
  }

  String _formatSupply(double? value) {
    if (value == null) return 'N/A';
    if (value >= 1e9) {
      return '${(value / 1e9).toStringAsFixed(2)}B';
    } else if (value >= 1e6) {
      return '${(value / 1e6).toStringAsFixed(2)}M';
    }
    return _formatNumber(value);
  }

  String _formatNumber(double value) {
    final parts = value.toStringAsFixed(0).split('');
    final buffer = StringBuffer();
    int count = 0;
    
    for (int i = parts.length - 1; i >= 0; i--) {
      buffer.write(parts[i]);
      count++;
      if (count % 3 == 0 && i != 0) {
        buffer.write(',');
      }
    }
    
    return buffer.toString().split('').reversed.join();
  }
}

