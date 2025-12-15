import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:team_7/core/theming/app_colors.dart';
import 'package:team_7/core/theming/theme_extensions.dart';

class MarketErrorState extends StatelessWidget {
  final dynamic error;
  final VoidCallback onRetry;

  const MarketErrorState({
    super.key,
    required this.error,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 64,
              color: AppExtraColors.danger.withAlpha(179),
            ),
            const SizedBox(height: 16),
            Text(
              'Failed to load market data',
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: context.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              error.message ?? 'An unexpected error occurred',
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                fontSize: 14,
                color: context.onSurface.withAlpha(128),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Retry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppExtraColors.blueAccent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}