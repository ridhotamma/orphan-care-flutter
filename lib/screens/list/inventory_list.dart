import 'package:flutter/material.dart';
import 'package:frontend_flutter/config/app_style_config.dart';
import 'package:frontend_flutter/models/inventory_model.dart';
import 'package:frontend_flutter/routes/routes.dart';
import 'package:frontend_flutter/services/inventory_service.dart';
import 'package:frontend_flutter/widgets/shared/custom_app_bar.dart';
import 'package:shimmer/shimmer.dart';

class InventoryList extends StatefulWidget {
  const InventoryList({super.key});

  @override
  State<InventoryList> createState() => _InventoryListState();
}

class _InventoryListState extends State<InventoryList> {
  late Future<List<Inventory>> _inventoryFuture;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() {
      _inventoryFuture = InventoryService(context).fetchInventories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyleConfig.primaryBackgroundColor,
      appBar: const CustomAppBar(
        title: 'Data Inventory',
        automaticallyImplyLeading: true,
      ),
      body: FutureBuilder<List<Inventory>>(
        future: _inventoryFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildInventorySkeletons();
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return _buildInventoryEmptyState();
          } else {
            return _buildInventoryListView(snapshot.data!);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, RoutePaths.inventoryCreateForm);
        },
        backgroundColor: AppStyleConfig.secondaryColor,
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildInventorySkeletons() {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              leading: Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(8),
                child: Icon(
                  Icons.inventory_2_outlined,
                  color: Colors.grey.shade300,
                ),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.grey.shade300,
                    height: 20.0,
                    width: 100.0,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Container(
                    color: Colors.grey.shade300,
                    height: 20.0,
                    width: 150.0,
                  ),
                ],
              ),
              trailing:
                  Icon(Icons.arrow_forward_ios, color: Colors.grey.shade300),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInventoryEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(8),
            child: Icon(
              Icons.inventory_2_outlined,
              color: Colors.blue.shade900,
              size: 60.0,
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          const Text(
            'There is no inventory',
            style: AppStyleConfig.headlineMediumTextStyle,
          )
        ],
      ),
    );
  }

  Widget _buildInventoryListView(List<Inventory> data) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 12.0),
      itemCount: data.length,
      itemBuilder: (context, index) {
        final inventory = data[index];
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
              inventory.name,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Chip(
                  label: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.stacked_bar_chart,
                        size: 20,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        'Jumlah: ${inventory.quantity}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  backgroundColor: AppStyleConfig.accentColor,
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                ),
                Text(inventory.inventoryType.name),
              ],
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.pushNamed(
                context,
                RoutePaths.inventoryDetails,
                arguments: inventory.id,
              );
            },
          ),
        );
      },
    );
  }
}
