import 'package:flutter/material.dart';
import 'package:frontend_flutter/config/app_style_config.dart';
import 'package:frontend_flutter/routes/routes.dart';
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
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Personal Details',
        automaticallyImplyLeading: true,
      ),
      body: const Center(
        child: Text('Personal Details'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, RoutePaths.orphanCreateForm);
        },
        backgroundColor: AppStyleConfig.secondaryColor,
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        child: const Icon(Icons.edit_outlined),
      ),
    );
  }
}
