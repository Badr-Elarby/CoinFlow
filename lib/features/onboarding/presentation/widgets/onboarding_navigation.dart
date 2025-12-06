import 'package:flutter/material.dart';
import 'package:team_7/core/responsive/size_extensions.dart';

class OnboardingNavigation extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final VoidCallback onNext;

  const OnboardingNavigation({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final inactiveColor = Theme.of(context).colorScheme.outline;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.wp(6),
        vertical: context.hp(4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Pagination Dots
          Row(
            children: List.generate(totalPages, (index) {
              final isActive = index == currentPage;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.only(right: 6),
                height: 6,
                width: isActive ? 24 : 6, // Active is wider
                decoration: BoxDecoration(
                  color: isActive ? primaryColor : inactiveColor,
                  borderRadius: BorderRadius.circular(3),
                ),
              );
            }),
          ),

          // Next Button (Arrow)
          GestureDetector(
            onTap: onNext,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: primaryColor,
              ),
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Theme.of(context).colorScheme.onPrimary,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
