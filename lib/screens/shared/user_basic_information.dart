import 'package:flutter/material.dart';
import 'package:frontend_flutter/config/app_style_config.dart';
import 'package:frontend_flutter/widgets/shared/custom_app_bar.dart';

class UserBasicInformation extends StatefulWidget {
  final String id;

  const UserBasicInformation({
    super.key,
    required this.id,
  });

  @override
  State<UserBasicInformation> createState() => _UserBasicInformationState();
}

class _UserBasicInformationState extends State<UserBasicInformation> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(
          title: 'Basic Information',
          automaticallyImplyLeading: true,
        ),
        body: const Center(
          child: Text('Basic Information'),
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
