import 'package:flutter/material.dart';
import 'package:team_7/core/responsive/size_extensions.dart';

class OnboardingContent extends StatelessWidget {
  final String imagePath;
  final String title;
  final String? highlightedText;
  final double? imageHeight;
  final double? imageWidth;

  const OnboardingContent({
    super.key,
    required this.imagePath,
    required this.title,
    this.highlightedText,
    this.imageHeight,
    this.imageWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: imageHeight ?? context.hp(40),
          width: imageWidth ?? context.wp(80),
          child: Image.asset(imagePath, fit: BoxFit.contain),
        ),

        SizedBox(height: context.hp(6)),

        if (highlightedText != null)
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              children: [
                TextSpan(text: title),
                TextSpan(
                  text: highlightedText,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
            ),
          )
        else
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.wp(10)),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
                height: 1.2,
              ),
            ),
          ),
      ],
    );
  }
}
