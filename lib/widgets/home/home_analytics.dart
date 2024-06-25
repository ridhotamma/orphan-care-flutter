import 'package:flutter/material.dart';
import 'package:frontend_flutter/config/app_style_config.dart';

class HomeAnalytics extends StatelessWidget {
  const HomeAnalytics({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            _buildAnalyticsCard(
              icon: Icons.child_care,
              title: "Jumlah Anak",
              count: 10,
            ),
            _buildAnalyticsCard(
              icon: Icons.supervised_user_circle,
              title: "Jumlah Pengasuh",
              count: 5,
            )
          ],
        ),
        Row(
          children: [
            _buildAnalyticsCard(
              icon: Icons.hotel,
              title: "Jumlah Kamar",
              count: 5,
            ),
            _buildAnalyticsCard(
              icon: Icons.inventory_2_outlined,
              title: "Jumlah Inventori",
              count: 5,
            ),
          ],
        )
      ],
    );
  }

  Widget _buildAnalyticsCard({
    required IconData icon,
    required String title,
    required int count,
  }) {
    return Expanded(
      child: Card(
        color: AppStyleConfig.primaryBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: const BorderSide(
              color: Colors.grey, width: 1.0), // Add solid border
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 40.0,
                color: Colors.black,
              ),
              const SizedBox(height: 10.0),
              Text(
                title,
                style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10.0),
              Text(
                count.toString(),
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
