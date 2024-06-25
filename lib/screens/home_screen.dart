import 'package:flutter/material.dart';
import '../config/app_style_config.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Home Screen',
        style: AppStyleConfig.headlineTextStyle,
      ),
    );
  }
}
