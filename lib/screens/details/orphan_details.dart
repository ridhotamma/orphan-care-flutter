import 'package:flutter/material.dart';
import 'package:frontend_flutter/widgets/shared/custom_app_bar.dart';

class OrphanDetails extends StatelessWidget {
  static const String routeName = '/main/home/orphan_details';

  final String id;

  const OrphanDetails({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Detail Anak Asuh",
        automaticallyImplyLeading: true,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Basic Information'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Handle navigation to Basic Information
            },
          ),
          const Divider(color: Colors.grey),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Handle navigation to Profile
            },
          ),
          const Divider(color: Colors.grey),
          ListTile(
            leading: const Icon(Icons.location_on),
            title: const Text('Address'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Handle navigation to Address
            },
          ),
          const Divider(color: Colors.grey),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Personal Settings'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Handle navigation to Personal Settings
            },
          ),
          const Divider(color: Colors.grey),
        ],
      ),
    );
  }
}
