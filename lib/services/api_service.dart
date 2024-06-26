import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frontend_flutter/config/app_api_config.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:frontend_flutter/providers/auth_provider.dart';

class ApiService {
  final BuildContext context;

  ApiService(this.context);

  Uri _buildUri(String endpoint) {
    return Uri.parse('${AppApiConfig.baseUrl}$endpoint');
  }

  Future<String?> _getToken() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return authProvider.token;
  }

  Map<String, String> _buildHeaders(String? token) {
    return {
      'Content-Type': 'application/json',
      if (token != null) ...AppApiConfig.getHeaders(token),
    };
  }

  Future<http.Response> _handleResponse(http.Response response) async {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response;
    } else if (response.statusCode == 401) {
      _handleUnauthorized();
      return response;
    } else {
      throw Exception('Failed with status code: ${response.statusCode}');
    }
  }

  void _handleUnauthorized() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.clearToken();
    _redirectToLogin();
  }

  void _redirectToLogin() {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  Future<http.Response> _sendRequest(
    Future<http.Response> Function() request,
  ) async {
    try {
      final response = await request();
      return await _handleResponse(response);
    } catch (e) {
      throw Exception('Failed to send request: $e');
    }
  }

  Future<http.Response> get(String endpoint) async {
    final uri = _buildUri(endpoint);
    final token = await _getToken();
    final headers = _buildHeaders(token);

    return _sendRequest(() => http.get(uri, headers: headers));
  }

  Future<http.Response> post(String endpoint, Map<String, dynamic> body) async {
    final uri = _buildUri(endpoint);
    final token = await _getToken();
    final headers = _buildHeaders(token);

    return _sendRequest(
        () => http.post(uri, headers: headers, body: json.encode(body)));
  }

  Future<http.Response> put(String endpoint, Map<String, dynamic> body) async {
    final uri = _buildUri(endpoint);
    final token = await _getToken();
    final headers = _buildHeaders(token);

    return _sendRequest(
        () => http.put(uri, headers: headers, body: json.encode(body)));
  }

  Future<http.Response> delete(String endpoint) async {
    final uri = _buildUri(endpoint);
    final token = await _getToken();
    final headers = _buildHeaders(token);

    return _sendRequest(() => http.delete(uri, headers: headers));
  }
}
