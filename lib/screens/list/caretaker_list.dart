import 'package:flutter/material.dart';
import 'package:frontend_flutter/config/app_style_config.dart';

class CaretakerList extends StatelessWidget {
  static const String routeName = '/main/home/caretaker_details';

  const CaretakerList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppStyleConfig.secondaryColor,
        title: const Text(
          'Kelola Data Pengasuh',
          style: TextStyle(color: Colors.white),
        ),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: const Center(
        child: Text("Caretaker Details"),
      ),
    );
  }
}
