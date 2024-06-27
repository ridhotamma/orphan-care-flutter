import 'package:flutter/material.dart';
import 'package:frontend_flutter/config/app_style_config.dart';

class SkeletonWelcomeBanner extends StatelessWidget {
  const SkeletonWelcomeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200.0,
      decoration: BoxDecoration(
        color: AppStyleConfig.secondaryColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 60.0,
              height: 20.0,
              color: Colors.white.withOpacity(0.5),
            ),
            const SizedBox(height: 8.0),
            Container(
              width: 180.0,
              height: 18.0,
              color: Colors.white.withOpacity(0.5),
            ),
          ],
        ),
      ),
    );
  }
}
