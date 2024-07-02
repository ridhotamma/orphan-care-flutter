import 'package:flutter/material.dart';
import 'package:frontend_flutter/config/app_style_config.dart';

class ToggleButton extends StatelessWidget {
  final List<bool> isSelected;
  final List<String> labels;
  final Function(int) onPressed;

  const ToggleButton({
    super.key,
    required this.isSelected,
    required this.labels,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      isSelected: isSelected,
      fillColor: AppStyleConfig.accentColor,
      selectedColor: Colors.white,
      color: Colors.black,
      onPressed: (int index) {
        onPressed(index);
      },
      children: labels.map((label) {
        return Container(
          width: (MediaQuery.of(context).size.width - 36) / labels.length,
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(label),
          ),
        );
      }).toList(),
    );
  }
}
