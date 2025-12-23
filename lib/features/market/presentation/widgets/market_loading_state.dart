import 'package:flutter/material.dart';
import 'package:team_7/core/theming/theme_extensions.dart';
import 'package:team_7/features/market/presentation/widgets/shimmer_box.dart';

class MarketLoadingState extends StatelessWidget {
  final int itemCount;

  const MarketLoadingState({super.key,required this.itemCount});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: itemCount,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (_, __) => _shimmerCoinTile(context),
    );
  }
}

Widget _shimmerCoinTile(BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    decoration: BoxDecoration(
      color: context.surface,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: context.outline.withAlpha(51), width: 1),
    ),
    child: Row(
      children: [
        const ShimmerBox(width: 44, height: 44, isCircle: true),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ShimmerBox(width: 100, height: 16),
              const SizedBox(height: 6),
              const ShimmerBox(width: 60, height: 12),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const ShimmerBox(width: 70, height: 16),
            const SizedBox(height: 6),
            const ShimmerBox(width: 50, height: 20),
          ],
        ),
      ],
    ),
  );
}
