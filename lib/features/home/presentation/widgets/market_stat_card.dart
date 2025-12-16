import 'package:flutter/material.dart';

class MarketStatCard extends StatelessWidget {
  final String title;
  final String value;
  final String? percentChange;
  final bool isPositive;

  const MarketStatCard({
    super.key,
    required this.title,
    required this.value,
    this.percentChange,
    this.isPositive = true,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.outline.withAlpha(30), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(5),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: colorScheme.onSurface.withAlpha(150),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: colorScheme.onSurface,
              letterSpacing: -0.5,
            ),
          ),
          if (percentChange != null) ...[
            const SizedBox(height: 6),
            Row(
              children: [
                Icon(
                  isPositive
                      ? Icons.arrow_upward_rounded
                      : Icons.arrow_downward_rounded,
                  color: isPositive
                      ? const Color(0xFF00CB6A)
                      : const Color(0xFFF26666),
                  size: 14,
                ),
                const SizedBox(width: 4),
                Text(
                  percentChange!,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: isPositive
                        ? const Color(0xFF00CB6A)
                        : const Color(0xFFF26666),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
