import 'package:flutter/material.dart';
import 'package:frontend_flutter/config/app_style_config.dart';
import 'package:frontend_flutter/widgets/shared/custom_app_bar.dart';

class CaretakerCreateForm extends StatelessWidget {
  const CaretakerCreateForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppStyleConfig.primaryBackgroundColor,
      appBar: CustomAppBar(
        title: "Create User Form",
        automaticallyImplyLeading: true,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Text('Inventory Details'),
      ),
    );
  }
}
