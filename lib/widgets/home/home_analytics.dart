// home_analytics.dart
import 'package:flutter/material.dart';
import 'package:frontend_flutter/config/app_style_config.dart';

class HomeAnalytics extends StatelessWidget {
  const HomeAnalytics({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 8.0,
      mainAxisSpacing: 8.0,
      children: [
        _buildAnalyticsCard(
          icon: Icons.child_care,
          title: "Jumlah Anak Asuh",
          count: 10,
        ),
        _buildAnalyticsCard(
          icon: Icons.supervised_user_circle,
          title: "Jumlah Pengasuh",
          count: 5,
        ),
        _buildAnalyticsCard(
          icon: Icons.bed,
          title: "Jumlah Kamar",
          count: 15,
        ),
      ],
    );
  }

  Widget _buildAnalyticsCard({
    required IconData icon,
    required String title,
    required int count,
  }) {
    return Card(
      color: AppStyleConfig.secondaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 40.0,
            color: Colors.white, // Change the color as per your theme
          ),
          const SizedBox(height: 10.0),
          Text(
            title,
            style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10.0),
          Text(
            count.toString(),
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.white, // Change the color as per your theme
            ),
          ),
        ],
      ),
    );
  }
}
