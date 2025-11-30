import 'package:flutter/material.dart';
import 'package:team_7/core/theming/app-text.dart';
import 'package:team_7/core/theming/app_colors.dart';

class PasswordTextField extends StatefulWidget {
  final String hint;
  final String? label;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final bool isVisible;
  final VoidCallback? onToggleVisibility;

  const PasswordTextField({
    super.key,
    required this.hint,
    this.label,
    this.controller,
    this.validator,
    this.onChanged,
    this.isVisible = false,
    this.onToggleVisibility,
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  late bool _isVisible;

  @override
  void initState() {
    super.initState();
    _isVisible = widget.isVisible;
  }

  @override
  void didUpdateWidget(PasswordTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isVisible != widget.isVisible) {
      _isVisible = widget.isVisible;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return TextFormField(
      controller: widget.controller,
      obscureText: !_isVisible,
      validator: widget.validator,
      onChanged: widget.onChanged,
      style: AppText.medium14.copyWith(color: colorScheme.primary),
      decoration: InputDecoration(
        hintText: widget.hint,
        labelText: widget.label,
        hintStyle: AppText.medium14.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
        prefixIcon: Icon(
          Icons.lock_outline,
          color: colorScheme.onSurfaceVariant,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _isVisible ? Icons.visibility_off : Icons.visibility,
            color: colorScheme.onSurfaceVariant,
          ),
          onPressed: () {
            setState(() {
              _isVisible = !_isVisible;
            });
            widget.onToggleVisibility?.call();
          },
        ),
        filled: true,
        fillColor: Colors.transparent,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppExtraColors.white, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppExtraColors.warning, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppExtraColors.danger,
            width: 1.5,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    );
  }
}
