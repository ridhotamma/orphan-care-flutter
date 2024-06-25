import 'package:flutter/material.dart';
import '../config/app_style_config.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Settings Screen',
        style: AppStyleConfig.headlineTextStyle,
      ),
    );
  }
}
