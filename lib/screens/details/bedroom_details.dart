import 'package:flutter/material.dart';
import 'package:frontend_flutter/config/app_style_config.dart';

class BedroomDetails extends StatelessWidget {
  static const String routeName = '/home/bedroom_details';

  const BedroomDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppStyleConfig.secondaryColor,
        title: const Text(
          'Kelola Data Kamar',
          style: TextStyle(color: Colors.white),
        ),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: const Center(
        child: Text("Bedroom Details"),
      ),
    );
  }
}
