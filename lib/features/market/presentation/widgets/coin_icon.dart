import 'package:flutter/material.dart';
import 'package:team_7/core/theming/app_colors.dart';
import 'package:team_7/core/theming/theme_extensions.dart';

class CoinIcon extends StatelessWidget {
  final String? imageUrl;

  const CoinIcon({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: context.isDarkMode
            ? Colors.white.withAlpha(13)
            : context.primary.withAlpha(13),
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: imageUrl != null
            ? Image.network(
                imageUrl!,
                width: 44,
                height: 44,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _fallbackIcon(),
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: context.primary.withAlpha(128),
                      ),
                    ),
                  );
                },
              )
            : _fallbackIcon(),
      ),
    );
  }
}

Widget _fallbackIcon() {
  return Container(
    width: 44,
    height: 44,
    color: AppExtraColors.blueAccent.withAlpha(51),
    child: Icon(
      Icons.currency_bitcoin_rounded,
      color: AppExtraColors.blueAccent,
      size: 24,
    ),
  );
}
