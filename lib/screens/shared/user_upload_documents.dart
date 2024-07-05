import 'package:flutter/material.dart';
import 'package:frontend_flutter/config/app_style_config.dart';
import 'package:frontend_flutter/routes/routes.dart';
import 'package:frontend_flutter/widgets/shared/custom_app_bar.dart';

class UserUploadDocuments extends StatefulWidget {
  final String id;

  const UserUploadDocuments({
    super.key,
    required this.id,
  });

  @override
  State<UserUploadDocuments> createState() => _UserUploadDocumentsState();
}

class _UserUploadDocumentsState extends State<UserUploadDocuments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Upload Documents',
        automaticallyImplyLeading: true,
      ),
      body: const Center(
        child: Text('Upload Documents'),
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
