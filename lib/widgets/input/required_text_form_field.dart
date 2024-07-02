import 'package:flutter/material.dart';
import 'package:frontend_flutter/config/app_style_config.dart';

class RequiredTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final FormFieldValidator<String>? validator;
  final bool readOnly;
  final VoidCallback? onTap;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;

  const RequiredTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.validator,
    this.readOnly = false,
    this.onTap,
    this.keyboardType,
    this.obscureText = false,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: AppStyleConfig.inputDecoration.copyWith(
        hintText: hintText,
        labelText: '$hintText *',
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
        suffixIcon: suffixIcon,
      ),
      validator: validator,
      readOnly: readOnly,
      onTap: onTap,
      keyboardType: keyboardType,
      obscureText: obscureText,
    );
  }
}
