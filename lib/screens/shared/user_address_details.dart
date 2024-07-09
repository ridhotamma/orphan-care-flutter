import 'package:flutter/material.dart';
import 'package:frontend_flutter/config/app_style_config.dart';
import 'package:frontend_flutter/widgets/shared/custom_app_bar.dart';

class UserAddressDetails extends StatefulWidget {
  final String id;

  const UserAddressDetails({
    super.key,
    required this.id,
  });

  @override
  State<UserAddressDetails> createState() => _UserAddressDetailsState();
}

class _UserAddressDetailsState extends State<UserAddressDetails> {
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
