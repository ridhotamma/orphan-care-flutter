import 'package:flutter/material.dart';
import 'package:frontend_flutter/config/app_style_config.dart';
import 'package:frontend_flutter/widgets/shared/custom_app_bar.dart';

class BedroomCreateForm extends StatelessWidget {
  const BedroomCreateForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppStyleConfig.primaryBackgroundColor,
      appBar: CustomAppBar(
        title: "Create Bedroom Form",
        automaticallyImplyLeading: true,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Text('Inventory Details'),
      ),
    );
  }
}
