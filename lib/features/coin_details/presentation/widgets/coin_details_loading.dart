import 'package:flutter/material.dart';
import 'package:team_7/core/theming/theme_extensions.dart';
import 'package:team_7/features/market/presentation/widgets/shimmer_box.dart';

class CoinDetailsLoadingWidget extends StatelessWidget {
  const CoinDetailsLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          // Coin title shimmer
          const Row(
            children: [
              ShimmerBox(width: 40, height: 40, isCircle: true),
              SizedBox(width: 12),
              ShimmerBox(width: 120, height: 24),
            ],
          ),
          const SizedBox(height: 20),
          // Price card shimmer
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: context.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: context.outline.withAlpha(51),
                width: 1,
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ShimmerBox(width: 150, height: 32),
                        SizedBox(height: 8),
                        ShimmerBox(width: 80, height: 16),
                      ],
                    ),
                    ShimmerBox(width: 80, height: 32),
                  ],
                ),
                SizedBox(height: 24),
                ShimmerBox(width: double.infinity, height: 120),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ShimmerBox(width: 50, height: 32),
                    ShimmerBox(width: 50, height: 32),
                    ShimmerBox(width: 50, height: 32),
                    ShimmerBox(width: 50, height: 32),
                    ShimmerBox(width: 50, height: 32),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Statistics shimmer
          const ShimmerBox(width: 100, height: 24),
          const SizedBox(height: 16),
          ...List.generate(5, (index) => const Padding(
            padding: EdgeInsets.symmetric(vertical: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ShimmerBox(width: 100, height: 16),
                    SizedBox(width: 8),
                    ShimmerBox(width: 8, height: 8, isCircle: true),
                  ],
                ),
                ShimmerBox(width: 80, height: 16),
              ],
            ),
          )),
          const SizedBox(height: 24),
          // About shimmer
          const ShimmerBox(width: 140, height: 24),
          const SizedBox(height: 12),
          const ShimmerBox(width: double.infinity, height: 100),
        ],
      ),
    );
  }
}

