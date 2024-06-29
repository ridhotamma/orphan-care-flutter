import 'package:flutter/material.dart';
import 'package:frontend_flutter/config/app_style_config.dart';
import 'package:frontend_flutter/widgets/shared/custom_app_bar.dart';

class InventoryList extends StatelessWidget {
  static const String routeName = '/main/home/inventory_list';

  const InventoryList({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> bedrooms = [
      {'name': 'Inventory 1', 'type': 'Type A'},
      {'name': 'Inventory 2', 'type': 'Type B'},
      {'name': 'Inventory 3', 'type': 'Type C'},
    ];

    return Scaffold(
      backgroundColor: AppStyleConfig.primaryBackgroundColor,
      appBar: const CustomAppBar(
        title: 'Data Inventory',
        automaticallyImplyLeading: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(top: 12.0),
        itemCount: bedrooms.length,
        itemBuilder: (context, index) {
          final bedroom = bedrooms[index];
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              leading: Container(
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(8),
                child: Icon(
                  Icons.inventory_2_outlined,
                  color: Colors.blue.shade900,
                ),
              ),
              title: Text(
                bedroom['name']!,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(bedroom['type']!),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Handle tap event
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppStyleConfig.secondaryColor,
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
