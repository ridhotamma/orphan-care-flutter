import 'package:flutter/material.dart';
import 'package:frontend_flutter/config/app_style_config.dart';

class HomeList extends StatelessWidget {
  final Function(Map<String, dynamic> selectedItem) onItemSelected;

  const HomeList({super.key, required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> listItems = [
      {
        'title': 'Data Anak Asuh',
        'subtitle': 'Kelola data profil anak asuh',
        'icon': Icons.child_care,
        'color': AppStyleConfig.secondaryColor
      },
      {
        'title': 'Data Pengasuh',
        'subtitle': 'Kelola data profil pengasuh',
        'icon': Icons.supervised_user_circle,
        'color': AppStyleConfig.secondaryColor
      },
      {
        'title': 'Data Kamar',
        'subtitle': 'Kelola data kamar',
        'icon': Icons.hotel,
        'color': AppStyleConfig.secondaryColor
      },
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: listItems.length,
      itemBuilder: (context, index) {
        final item = listItems[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 15.0),
          color: item['color'],
          child: ListTile(
            leading: Icon(item['icon']),
            title: Text(
              item['title'],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(item['subtitle']),
            onTap: () => onItemSelected(item),
            textColor: Colors.white,
            iconColor: Colors.white,
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
        );
      },
    );
  }
}
