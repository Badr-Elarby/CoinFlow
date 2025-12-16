import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:team_7/core/theming/app_colors.dart';
import 'package:team_7/core/theming/theme_extensions.dart';

class ExchangeFeeCard extends StatelessWidget {
  final double feePercent;
  final double feeAmount;

  const ExchangeFeeCard({
    super.key,
    required this.feePercent,
    required this.feeAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Fee Percentage Card
        Expanded(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: context.surface,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: context.outline.withAlpha(15),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                // Icon Container
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppExtraColors.warning.withAlpha(25),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      '\$',
                      style: GoogleFonts.lato(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppExtraColors.warning,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Text
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Exchange fee',
                      style: GoogleFonts.lato(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppExtraColors.paleSky,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${feePercent.toStringAsFixed(2)}%',
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: context.onSurface,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        
        const SizedBox(width: 12),
        
        // Fee Amount Card
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: context.surface,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: context.outline.withAlpha(15),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Text(
                '\$${feeAmount.toStringAsFixed(0)}',
                style: GoogleFonts.lato(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppExtraColors.navyBlue,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}




