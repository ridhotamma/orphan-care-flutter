import 'package:flutter/material.dart';
import 'package:frontend_flutter/config/app_style_config.dart';
import 'package:frontend_flutter/screens/details/bedroom_details.dart';
import 'package:frontend_flutter/screens/details/caretaker_details.dart';
import 'package:frontend_flutter/screens/details/inventory_details.dart';
import 'package:frontend_flutter/screens/details/orphan_details.dart';

class ListItem {
  final int id;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final String route;

  ListItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.route,
  });
}

class HomeList extends StatelessWidget {
  final Function(Map<String, dynamic> selectedItem) onItemSelected;

  const HomeList({super.key, required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    final List<ListItem> listItems = [
      ListItem(
        id: 1,
        title: 'Data Anak Asuh',
        subtitle: 'Kelola data profil anak asuh',
        icon: Icons.child_care,
        color: AppStyleConfig.secondaryColor,
        route: OrphanDetails.routeName,
      ),
      ListItem(
        id: 2,
        title: 'Data Pengasuh',
        subtitle: 'Kelola data profil pengasuh',
        icon: Icons.supervised_user_circle,
        color: AppStyleConfig.secondaryColor,
        route: CareTakerDetails.routeName,
      ),
      ListItem(
        id: 3,
        title: 'Data Kamar',
        subtitle: 'Kelola data kamar',
        icon: Icons.hotel,
        color: AppStyleConfig.secondaryColor,
        route: BedroomDetails.routeName,
      ),
      ListItem(
        id: 4,
        title: 'Data Inventori',
        subtitle: 'Kelola data kamar',
        icon: Icons.inventory_2_outlined,
        color: AppStyleConfig.secondaryColor,
        route: InventoryDetails.routeName,
      )
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: listItems.length,
      itemBuilder: (context, index) {
        final item = listItems[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 15.0),
          color: item.color,
          child: ListTile(
            leading: Icon(item.icon),
            title: Text(
              item.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(item.subtitle),
            onTap: () => onItemSelected({'routeName': item.route}),
            textColor: Colors.white,
            iconColor: Colors.white,
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
        );
      },
    );
  }
}
