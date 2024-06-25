import 'package:flutter/material.dart';
import '../config/app_style_config.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();
  bool _isButtonDisabled = true;
  bool _isPasswordVisible = false;

  void _validateInput() {
    setState(() {
      _isButtonDisabled = _emailEditingController.text.isEmpty ||
          _passwordEditingController.text.isEmpty;
    });
  }

  void onLoginPress() {
    if (!_isButtonDisabled) {
      Navigator.pushReplacementNamed(context, '/main');
    }
  }

  @override
  void initState() {
    super.initState();
    _emailEditingController.addListener(_validateInput);
    _passwordEditingController.addListener(_validateInput);
  }

  @override
  void dispose() {
    _emailEditingController.dispose();
    _passwordEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyleConfig.primaryBackgroundColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Image.asset(
                      "images/logo.png",
                      width: 120,
                      height: 120,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Text(
                      'Login',
                      style: AppStyleConfig.headlineTextStyle,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _emailEditingController,
                      decoration: AppStyleConfig.inputDecoration.copyWith(
                        hintText: 'Email',
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _passwordEditingController,
                      decoration: AppStyleConfig.inputDecoration.copyWith(
                        hintText: 'Password',
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                          icon: Icon(_isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                      ),
                      obscureText: !_isPasswordVisible,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: _isButtonDisabled
                          ? AppStyleConfig.disabledButtonStyle
                          : AppStyleConfig.secondaryButtonStyle,
                      onPressed: onLoginPress,
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
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                'Build Number: v1.0.0',
                style: AppStyleConfig.primaryTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
