import 'package:flutter/material.dart';
import 'package:team_7/core/responsive/size_extensions.dart';
import 'package:team_7/core/theming/theme_extensions.dart';
import 'package:team_7/core/theming/app_colors.dart';
import 'package:team_7/core/theming/app_text.dart';

class MonthSelector extends StatefulWidget {
  const MonthSelector({super.key});

  @override
  State<MonthSelector> createState() => _MonthSelectorState();
}

class _MonthSelectorState extends State<MonthSelector> {
  int selectedIndex = 1; // Dec is selected by default

  final List<String> months = ['Nov', 'Dec', 'Jan', 'Feb', 'Mar', 'Apr'];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: months.length,
        itemBuilder: (context, index) {
          final isSelected = index == selectedIndex;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: Container(
              margin: EdgeInsets.only(right: context.wp(2)),
              padding: EdgeInsets.symmetric(
                horizontal: context.wp(4),
                vertical: context.hp(1),
              ),
              decoration: BoxDecoration(
                color: isSelected
                    ? (context.isDarkMode
                          ? AppExtraColors.white
                          : context.primary)
                    : AppExtraColors.transparent,
                borderRadius: BorderRadius.circular(20),
                border: isSelected
                    ? null
                    : Border.all(
                        color: context.outline.withValues(alpha: 0.3),
                        width: 1,
                      ),
              ),
              child: Center(
                child: Text(
                  months[index],
                  style: AppText.white14Regular.copyWith(
                    fontWeight: FontWeight.w500,
                    color: isSelected
                        ? (context.isDarkMode
                              ? context.onPrimary
                              : AppExtraColors.white)
                        : context.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
