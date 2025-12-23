import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:team_7/core/theming/theme_extensions.dart';

class MarketHeader extends StatelessWidget {
  final String title;

  const MarketHeader({super.key, this.title = 'Crypto Market'});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Row(
        children: [
          Text(
            title,
            style: GoogleFonts.lato(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: context.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
