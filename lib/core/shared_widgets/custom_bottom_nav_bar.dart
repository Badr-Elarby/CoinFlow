import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:team_7/core/responsive/size_extensions.dart';
import 'package:team_7/core/theming/theme_extensions.dart';
import 'package:team_7/core/theming/app_colors.dart';

class CustomBottomNavBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const CustomBottomNavBar({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final currentIndex = navigationShell.currentIndex;

    // Theme-aware colors
    final backgroundColor = isDark
        ? AppColors.darkSurface
        : AppColors.lightSurface;

    final activeIconColor = context.primary;

    final inactiveIconColor = isDark
        ? AppExtraColors.gray.withValues(alpha: 0.6)
        : AppExtraColors.gray;

    final activeLabelColor = isDark
        ? Colors.white
        : AppExtraColors.darkNavyIcon;

    final inactiveLabelColor = AppExtraColors.gray;

    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Container(
      height: context.hp(9) + bottomPadding,
      padding: EdgeInsets.only(bottom: bottomPadding),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavItem(
              iconPath: 'assets/images/home_icon.svg',
              label: 'Home',
              isActive: currentIndex == 0,
              activeIconColor: activeIconColor,
              inactiveIconColor: inactiveIconColor,
              activeLabelColor: activeLabelColor,
              inactiveLabelColor: inactiveLabelColor,
              onTap: () => _onItemTapped(0),
            ),
            _NavItem(
              iconPath: 'assets/images/market_icon.svg',
              label: 'Market',
              isActive: currentIndex == 1,
              activeIconColor: activeIconColor,
              inactiveIconColor: inactiveIconColor,
              activeLabelColor: activeLabelColor,
              inactiveLabelColor: inactiveLabelColor,
              onTap: () => _onItemTapped(1),
            ),
            _NavItem(
              iconPath: 'assets/images/portfolio_icon.svg',
              label: 'Portfolio',
              isActive: currentIndex == 2,
              activeIconColor: activeIconColor,
              inactiveIconColor: inactiveIconColor,
              activeLabelColor: activeLabelColor,
              inactiveLabelColor: inactiveLabelColor,
              onTap: () => _onItemTapped(2),
            ),
            _NavItem(
              iconPath: 'assets/images/settings_icon.svg',
              label: 'Settings',
              isActive: currentIndex == 3,
              activeIconColor: activeIconColor,
              inactiveIconColor: inactiveIconColor,
              activeLabelColor: activeLabelColor,
              inactiveLabelColor: inactiveLabelColor,
              onTap: () => _onItemTapped(3),
            ),
          ],
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}

class _NavItem extends StatelessWidget {
  final String iconPath;
  final String label;
  final bool isActive;
  final Color activeIconColor;
  final Color inactiveIconColor;
  final Color activeLabelColor;
  final Color inactiveLabelColor;
  final VoidCallback onTap;

  const _NavItem({
    required this.iconPath,
    required this.label,
    required this.isActive,
    required this.activeIconColor,
    required this.inactiveIconColor,
    required this.activeLabelColor,
    required this.inactiveLabelColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final iconColor = isActive ? activeIconColor : inactiveIconColor;
    final labelColor = isActive ? activeLabelColor : inactiveLabelColor;

    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: context.hp(1)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon
              SvgPicture.asset(
                iconPath,
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
              ),
              SizedBox(height: context.hp(0.5)),

              // Label
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                  color: labelColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
