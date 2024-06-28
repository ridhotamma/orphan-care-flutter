import 'package:flutter/material.dart';
import 'package:frontend_flutter/config/app_style_config.dart';

class InventoryList extends StatelessWidget {
  static const String routeName = '/main/home/inventory_list';

  const InventoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppStyleConfig.secondaryColor,
        title: const Text(
          'Kelola Data Inventory',
          style: TextStyle(color: Colors.white),
        ),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: const Center(
        child: Text("Inventory Details"),
      ),
    );
  }
}
