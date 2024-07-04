import 'package:flutter/material.dart';
import 'package:frontend_flutter/config/app_style_config.dart';
import 'package:frontend_flutter/models/user_model.dart';
import 'package:frontend_flutter/models/analytic_model.dart';
import 'package:frontend_flutter/widgets/home/home_analytics.dart';
import 'package:frontend_flutter/widgets/home/home_list.dart';
import 'package:frontend_flutter/widgets/home/welcome_banner.dart';
import 'package:frontend_flutter/widgets/skeleton/home_analytics_skeleton.dart';
import 'package:frontend_flutter/widgets/skeleton/welcome_banner_skeleton.dart';

class HomeScreen extends StatelessWidget {
  final Future<AnalyticData> analyticsDataFuture;
  final Future<CurrentUser> currentUserFuture;

  const HomeScreen({
    super.key,
    required this.analyticsDataFuture,
    required this.currentUserFuture,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyleConfig.primaryBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              WelcomeBannerWidget(currentUserFuture: currentUserFuture),
              const SizedBox(height: 12.0),
              AnalyticsDataWidget(analyticsDataFuture: analyticsDataFuture),
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

class WelcomeBannerWidget extends StatelessWidget {
  final Future<CurrentUser> currentUserFuture;

  const WelcomeBannerWidget({super.key, required this.currentUserFuture});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CurrentUser>(
      future: currentUserFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SkeletonWelcomeBanner();
        } else if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        } else if (snapshot.hasData) {
          return WelcomeBanner(currentUser: snapshot.data!);
        } else {
          return const Center(child: Text('No data available'));
        }
      },
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
          return const SkeletonHomeAnalytics();
        } else if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        } else if (snapshot.hasData) {
          return HomeAnalytics(data: snapshot.data!);
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
  }
}
