import 'package:flutter/material.dart';
import 'package:frontend_flutter/config/app_style_config.dart';

class _SkeletonAnalyticsCard extends StatelessWidget {
  const _SkeletonAnalyticsCard();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        color: AppStyleConfig.primaryBackgroundColor.withOpacity(0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(
            color: Colors.grey.withOpacity(0.5),
            width: 1.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 40.0,
                height: 40.0,
                color: Colors.black.withOpacity(0.1),
              ),
              const SizedBox(height: 10.0),
              Container(
                width: 60.0,
                height: 16.0,
                color: Colors.black.withOpacity(0.1),
              ),
              const SizedBox(height: 10.0),
              Container(
                width: 40.0,
                height: 24.0,
                color: Colors.black.withOpacity(0.1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SkeletonHomeAnalytics extends StatelessWidget {
  const SkeletonHomeAnalytics({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            _SkeletonAnalyticsCard(),
            _SkeletonAnalyticsCard(),
          ],
        ),
        Row(
          children: [
            _SkeletonAnalyticsCard(),
            _SkeletonAnalyticsCard(),
          ],
        ),
      ],
    );
  }
}
