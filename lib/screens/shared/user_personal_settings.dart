import 'package:flutter/material.dart';
import 'package:frontend_flutter/config/app_style_config.dart';
import 'package:frontend_flutter/widgets/shared/custom_app_bar.dart';

class UserPersonalSettings extends StatefulWidget {
  final String id;

  const UserPersonalSettings({
    super.key,
    required this.id,
  });

  @override
  State<UserPersonalSettings> createState() => _UserPersonalSettingsState();
}

class _UserPersonalSettingsState extends State<UserPersonalSettings> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(
          title: 'Personal Settings',
          automaticallyImplyLeading: true,
        ),
        body: ListView(
          children: [
            Container(
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
                    Icons.key,
                    color: Colors.blue.shade900,
                  ),
                ),
                title: const Text(
                  'Change Password',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: const Text('create new user password'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ListTile(
                leading: Container(
                  decoration: BoxDecoration(
                    color: Colors.red.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Icon(
                    Icons.block,
                    color: Colors.red.shade900,
                  ),
                ),
                title: const Text(
                  'Deactivate user account',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: const Text('make account inactive'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ListTile(
                leading: Container(
                  decoration: BoxDecoration(
                    color: Colors.red.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Icon(
                    Icons.delete,
                    color: Colors.red.shade900,
                  ),
                ),
                title: const Text(
                  'Delete user',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: const Text('Permanently delete user'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: AppStyleConfig.secondaryColor,
          foregroundColor: Colors.white,
          shape: const CircleBorder(),
          child: const Icon(Icons.edit_outlined),
        ),
      ),
    );
  }
}
