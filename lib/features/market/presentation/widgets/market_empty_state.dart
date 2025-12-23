import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:team_7/core/theming/theme_extensions.dart';

class MarketEmptyState extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const MarketEmptyState({
    super.key,
    this.title = 'No coins found',
    this.subtitle = 'Try adjusting your search or filters',
    this.icon = Icons.search_off_rounded,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 64,
            color: context.onSurface.withAlpha(77),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: GoogleFonts.lato(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: context.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(
              fontSize: 14,
              color: context.onSurface.withAlpha(128),
            ),
          ),
        ],
      ),
    );
  }
}