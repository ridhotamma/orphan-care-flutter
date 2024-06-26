import 'package:flutter/material.dart';
import 'package:frontend_flutter/config/app_style_config.dart';
import 'package:frontend_flutter/models/user_model.dart';

class WelcomeBanner extends StatelessWidget {
  final CurrentUser currentUser;

  const WelcomeBanner({super.key, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    String profileName = currentUser.username;

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200.0,
      decoration: BoxDecoration(
        color: AppStyleConfig.secondaryColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Halo',
                    textAlign: TextAlign.left,
                    style: AppStyleConfig.headlineTextStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 180),
                    child: Text(
                      profileName,
                      textAlign: TextAlign.left,
                      style: AppStyleConfig.bodyTextStyle.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 160,
              height: 160,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/welcome.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
