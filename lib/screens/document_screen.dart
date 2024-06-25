import 'package:flutter/material.dart';
import '../config/app_style_config.dart';

class DocumentScreen extends StatelessWidget {
  const DocumentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Document Screen',
        style: AppStyleConfig.headlineTextStyle,
      ),
    );
  }
}
