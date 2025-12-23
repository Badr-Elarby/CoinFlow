import 'package:flutter/material.dart';
import 'package:team_7/core/theming/app_text.dart';

class RememberForgotSection extends StatefulWidget {
  const RememberForgotSection({super.key});

  @override
  State<RememberForgotSection> createState() => _RememberForgotSectionState();
}

class _RememberForgotSectionState extends State<RememberForgotSection> {
  bool _rememberMe = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
              value: _rememberMe,
              onChanged: (value) {
                if (value == true) {
                  setState(() {
                    _rememberMe = true;
                  });
                } else {
                  setState(() {
                    _rememberMe = false;
                  });
                }
              },
            ),
            Text('Remember me', style: AppText.semiBold12),
          ],
        ),
        Text('Forgot Password?', style: AppText.semiBold12),
      ],
    );
  }
}
