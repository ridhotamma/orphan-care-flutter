import 'package:flutter/material.dart';
import 'package:frontend_flutter/config/app_style_config.dart';
import 'package:frontend_flutter/routes/routes.dart';
import 'package:frontend_flutter/widgets/shared/custom_app_bar.dart';

class UserProfileDetails extends StatefulWidget {
  final String id;

  const UserProfileDetails({
    super.key,
    required this.id,
  });

  @override
  State<UserProfileDetails> createState() => _UserProfileDetailsState();
}

class _UserProfileDetailsState extends State<UserProfileDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Profile Details',
        automaticallyImplyLeading: true,
      ),
      body: const Center(
        child: Text('Profile Details'),
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
