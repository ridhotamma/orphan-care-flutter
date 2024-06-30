import 'package:flutter/material.dart';
import 'package:frontend_flutter/config/app_style_config.dart';
import 'package:frontend_flutter/widgets/shared/custom_app_bar.dart';

class InventoryList extends StatelessWidget {
  const InventoryList({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> bedrooms = [
      {'name': 'Inventory 1', 'type': 'Makanan'},
      {'name': 'Inventory 2', 'type': 'Makanan'},
      {'name': 'Inventory 3', 'type': 'Alat Tulis'},
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
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Chip(
                    label: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.stacked_bar_chart,
                          size: 20,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          'Jumlah: 10',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                    backgroundColor: AppStyleConfig.accentColor,
                    padding: EdgeInsets.symmetric(horizontal: 0),
                  ),
                  Text(bedroom['type']!)
                ],
              ),
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
