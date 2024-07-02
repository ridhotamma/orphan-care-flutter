import 'package:flutter/material.dart';
import 'package:frontend_flutter/config/app_style_config.dart';

class OptionalTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboardType;

  const OptionalTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: AppStyleConfig.inputDecoration.copyWith(
        hintText: hintText,
        labelText: hintText,
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
      ),
      keyboardType: keyboardType,
    );
  }
}
