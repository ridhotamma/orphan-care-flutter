import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend_flutter/models/auth_model.dart';
import 'package:frontend_flutter/config/app_style_config.dart';
import 'package:frontend_flutter/providers/auth_provider.dart';
import 'package:frontend_flutter/services/api_service.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  final ApiService apiService;

  const LoginScreen({super.key, required this.apiService});

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

  void onLoginPress() async {
    if (!_isButtonDisabled) {
      LoginRequest loginRequest = LoginRequest(
          username: _emailEditingController.text,
          password: _passwordEditingController.text);

      Map<String, dynamic> requestBody = loginRequest.toJson();
      Response response =
          await widget.apiService.post('/auth/login', requestBody);
      if (response.statusCode == 200) {
        String? jwtToken = jsonDecode(response.body)['jwt'];
        onLoginSuccess(jwtToken);
      } else {
        onLoginFailed(jsonDecode(response.body)['message']);
      }
    }
  }

  void onLoginSuccess(String? jwtToken) {
    Provider.of<AuthProvider>(context, listen: false).setToken(jwtToken);
    Navigator.pushReplacementNamed(context, '/main');
  }

  void onLoginFailed(String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppStyleConfig.errorColor,
        content: Text(
          errorMessage,
          style: const TextStyle(color: Colors.white),
        ),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
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
