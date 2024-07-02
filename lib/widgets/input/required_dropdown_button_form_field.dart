import 'package:flutter/material.dart';
import 'package:frontend_flutter/config/app_style_config.dart';

class RequiredDropdownButtonFormField extends StatelessWidget {
  final String? value;
  final String hintText;
  final ValueChanged<String?> onChanged;
  final List<DropdownMenuItem<String>> items;
  final FormFieldValidator<String>? validator;

  const RequiredDropdownButtonFormField({
    super.key,
    required this.value,
    required this.hintText,
    required this.onChanged,
    required this.items,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: AppStyleConfig.inputDecoration.copyWith(
        hintText: hintText,
        labelText: '$hintText *',
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
      ),
      value: value,
      onChanged: onChanged,
      validator: validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return 'Please select $hintText';
            }
            return null;
          },
      items: items,
    );
  }
}
