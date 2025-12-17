import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:team_7/core/theming/app_colors.dart';
import 'package:team_7/core/theming/theme_extensions.dart';

class CurrencyInputCard extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String currency;
  final Widget currencyIcon;
  final VoidCallback onCurrencyTap;
  final bool isFiat;
  final bool readOnly;
  final ValueChanged<String>? onChanged;
  final String? hintText;

  const CurrencyInputCard({
    super.key,
    required this.label,
    required this.controller,
    required this.currency,
    required this.currencyIcon,
    required this.onCurrencyTap,
    this.isFiat = true,
    this.readOnly = false,
    this.onChanged,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Text(
          label,
          style: GoogleFonts.lato(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppExtraColors.paleSky,
          ),
        ),
        const SizedBox(height: 8),

        // Input Row
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Amount Input
            Expanded(
              child: TextField(
                controller: controller,
                readOnly: readOnly,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[\d,.]')),
                ],
                onChanged: onChanged,
                style: GoogleFonts.lato(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: context.primary,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  isDense: true,
                  hintText: hintText,
                  hintStyle: GoogleFonts.lato(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: AppExtraColors.gray.withAlpha(100),
                  ),
                  prefixText: isFiat ? '\$' : '',
                  prefixStyle: GoogleFonts.lato(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: context.primary,
                  ),
                ),
              ),
            ),

            // Currency Selector
            _CurrencySelector(
              currency: currency,
              currencyIcon: currencyIcon,
              onTap: onCurrencyTap,
            ),
          ],
        ),

        // Divider
        Container(
          height: 1,
          color: context.outline.withAlpha(50),
          margin: const EdgeInsets.only(top: 8),
        ),
      ],
    );
  }
}

class _CurrencySelector extends StatelessWidget {
  final String currency;
  final Widget currencyIcon;
  final VoidCallback onTap;

  const _CurrencySelector({
    required this.currency,
    required this.currencyIcon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: context.background,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: context.outline.withAlpha(50), width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            currencyIcon,
            const SizedBox(width: 8),
            Text(
              currency,
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: context.onSurface,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.keyboard_arrow_down,
              color: AppExtraColors.paleSky,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
