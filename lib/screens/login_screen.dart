import 'package:flutter/material.dart';
import '../config/app_style_config.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyleConfig.primaryBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 80), // Add some space from the top
              Text(
                'Login',
                style: AppStyleConfig.headlineTextStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: AppStyleConfig.inputDecoration.copyWith(
                  hintText: 'Email',
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: AppStyleConfig.inputDecoration.copyWith(
                  hintText: 'Password',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: AppStyleConfig.primaryButtonStyle,
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/main');
                },
                child: Text(
                  'Login',
                  style: AppStyleConfig.primaryTextStyle.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
