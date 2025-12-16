import 'package:flutter/material.dart';
import 'package:team_7/core/theming/theme_extensions.dart';

class MarketSearchBar extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final String? hintText;

  const MarketSearchBar({super.key, this.onChanged, this.hintText});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.outline.withAlpha(77), width: 1),
      ),
      child: TextField(
        onChanged: onChanged,
        style: TextStyle(color: context.onSurface, fontSize: 14),
        decoration: InputDecoration(
          hintText: hintText ?? 'Search',
          hintStyle: TextStyle(
            color: context.onSurface.withAlpha(128),
            fontSize: 14,
          ),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: context.onSurface.withAlpha(128),
            size: 20,
          ),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
    );
  }
}
