import 'package:flutter/material.dart';
import 'package:frontend_flutter/config/app_style_config.dart';
import 'package:frontend_flutter/widgets/shared/custom_app_bar.dart';

class BedroomDetails extends StatelessWidget {
  final String id;

  const BedroomDetails({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppStyleConfig.primaryBackgroundColor,
      appBar: CustomAppBar(
        title: "Detail Kamar",
        automaticallyImplyLeading: true,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Text('Inventory Details'),
      ),
    );
  }
}
