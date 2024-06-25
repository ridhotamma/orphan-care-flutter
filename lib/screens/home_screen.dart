import 'package:flutter/material.dart';
import 'package:frontend_flutter/widgets/home/home_analytics.dart';
import 'package:frontend_flutter/widgets/home/home_list.dart';
import 'package:frontend_flutter/widgets/home/welcome_banner.dart';
import 'package:frontend_flutter/config/app_style_config.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyleConfig.secondaryBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const WelcomeBanner(profileName: "Bima Arviandi"),
              const SizedBox(
                height: 20.0,
              ),
              const HomeAnalytics(),
              const SizedBox(
                height: 20.0,
              ),
              HomeList(onItemSelected: (selectedItem) {})
            ],
          ),
        ),
      ),
    );
  }
}
