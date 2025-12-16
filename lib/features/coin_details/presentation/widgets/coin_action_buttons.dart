import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:team_7/core/routing/routes.dart';
import 'package:team_7/core/theming/app_colors.dart';
import 'package:team_7/core/theming/theme_extensions.dart';

class CoinActionButtons extends StatelessWidget {
  const CoinActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      decoration: BoxDecoration(
        color: context.surface,
        boxShadow: [
          BoxShadow(
            color: context.outline.withAlpha(30),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildButton(
              context,
              label: 'Sell',
              onTap: () => _showComingSoonSnackBar(context, 'Sell'),
              isPrimary: false,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildButton(
              context,
              label: 'Buy',
              onTap: () => context.push(Routes.buyCryptoRoute),
              isPrimary: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(
    BuildContext context, {
    required String label,
    required VoidCallback onTap,
    required bool isPrimary,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(30),
        child: Container(
          height: 52,
          decoration: BoxDecoration(
            color: isPrimary ? AppExtraColors.blueAccent : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
            border: isPrimary
                ? null
                : Border.all(
                    color: AppExtraColors.danger.withAlpha(128),
                    width: 1.5,
                  ),
          ),
          child: Center(
            child: Text(
              label,
              style: GoogleFonts.lato(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: isPrimary ? Colors.white : AppExtraColors.danger,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showComingSoonSnackBar(BuildContext context, String action) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$action feature coming soon!',
          style: GoogleFonts.lato(fontWeight: FontWeight.w500),
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }
}
