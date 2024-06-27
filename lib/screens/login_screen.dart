import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend_flutter/models/auth_model.dart';
import 'package:frontend_flutter/config/app_style_config.dart';
import 'package:frontend_flutter/providers/auth_provider.dart';
import 'package:frontend_flutter/services/api_service.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isButtonDisabled = true;
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_validateInput);
    _passwordController.addListener(_validateInput);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validateInput() {
    setState(() {
      _isButtonDisabled =
          _emailController.text.isEmpty || _passwordController.text.isEmpty;
    });
  }

  Future<void> onLoginPress() async {
    if (_isButtonDisabled || _isLoading) return;

    setState(() {
      _isLoading = true;
    });

    ApiService apiService = ApiService(context);
    LoginRequest loginRequest = LoginRequest(
      username: _emailController.text,
      password: _passwordController.text,
    );

    try {
      Response response =
          await apiService.post('/auth/login', loginRequest.toJson());
      if (response.statusCode == 200) {
        String? jwtToken = jsonDecode(response.body)['jwt'];
        onLoginSuccess(jwtToken);
      } else {
        onLoginFailed(jsonDecode(response.body)['message']);
      }
    } catch (e) {
      onLoginFailed('Failed to connect');
    } finally {
      setState(() {
        _isLoading = false;
      });
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
  Widget build(BuildContext context) {
    String currentYear = DateTime.now().year.toString();

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
                    const SizedBox(height: 40),
                    Image.asset(
                      "images/logo.png",
                      width: 120,
                      height: 120,
                    ),
                    const SizedBox(height: 40),
                    Text(
                      'Login',
                      style: AppStyleConfig.headlineTextStyle,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _emailController,
                      decoration: AppStyleConfig.inputDecoration.copyWith(
                        hintText: 'Email',
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _passwordController,
                      decoration: AppStyleConfig.inputDecoration.copyWith(
                        hintText: 'Password',
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                      obscureText: !_isPasswordVisible,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: _isButtonDisabled || _isLoading
                          ? AppStyleConfig.disabledButtonStyle
                          : AppStyleConfig.secondaryButtonStyle,
                      onPressed: _isLoading ? null : onLoginPress,
                      child: _isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2.0,
                              ),
                            )
                          : Text(
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
                '© $currentYear PSAA Annajah',
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
