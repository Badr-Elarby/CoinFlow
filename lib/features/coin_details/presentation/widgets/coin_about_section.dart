import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:team_7/core/theming/theme_extensions.dart';
import 'package:team_7/features/coin_details/data/model/coin_details_model.dart';

class CoinAboutSection extends StatelessWidget {
  final CoinDetailsModel coinDetails;

  const CoinAboutSection({super.key, required this.coinDetails});

  @override
  Widget build(BuildContext context) {
    final description = coinDetails.description;
    
    if (description == null || description.isEmpty) {
      return const SizedBox.shrink();
    }

    // Remove HTML tags from description
    final cleanDescription = _removeHtmlTags(description);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About ${coinDetails.name}',
          style: GoogleFonts.lato(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: context.onSurface,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          cleanDescription,
          style: GoogleFonts.lato(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: context.onSurface.withAlpha(179),
            height: 1.6,
          ),
          maxLines: 8,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  String _removeHtmlTags(String htmlString) {
    // Remove HTML tags
    final RegExp htmlTagRegex = RegExp(r'<[^>]*>');
    String cleanString = htmlString.replaceAll(htmlTagRegex, '');
    
    // Decode common HTML entities
    cleanString = cleanString
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&quot;', '"')
        .replaceAll('&#39;', "'")
        .replaceAll('&nbsp;', ' ')
        .replaceAll('\r\n', '\n')
        .replaceAll('\r', '\n');
    
    // Remove multiple consecutive newlines
    cleanString = cleanString.replaceAll(RegExp(r'\n{3,}'), '\n\n');
    
    return cleanString.trim();
  }
}

