import 'package:flutter/material.dart';
import 'package:frontend_flutter/widgets/home/home_analytics.dart';
import 'package:frontend_flutter/widgets/home/home_list.dart';
import 'package:frontend_flutter/widgets/home/welcome_banner.dart';
import 'package:frontend_flutter/config/app_style_config.dart';
import 'package:frontend_flutter/models/analytic_model.dart';
import 'package:frontend_flutter/services/analytics_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<AnalyticData> _analyticsData;

  @override
  void initState() {
    super.initState();
    _analyticsData = AnalyticsService(context).fetchHomePageAnalytics();
  }

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
              const SizedBox(height: 12.0),
              AnalyticsDataWidget(analyticsDataFuture: _analyticsData),
              const SizedBox(height: 12.0),
              HomeList(
                onItemSelected: (selectedItem) {
                  String routeName = selectedItem['routeName'];
                  Navigator.pushNamed(context, routeName);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnalyticsDataWidget extends StatelessWidget {
  final Future<AnalyticData> analyticsDataFuture;

  const AnalyticsDataWidget({super.key, required this.analyticsDataFuture});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AnalyticData>(
      future: analyticsDataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          return HomeAnalytics(data: snapshot.data!);
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
  }
}
