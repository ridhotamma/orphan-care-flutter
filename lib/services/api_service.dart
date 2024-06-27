import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frontend_flutter/config/app_api_config.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:frontend_flutter/providers/auth_provider.dart';

class ApiService {
  final BuildContext context;

  ApiService(this.context);

  Uri _buildUri(String endpoint) =>
      Uri.parse('${AppApiConfig.baseUrl}$endpoint');

  Future<String?> _getToken() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return authProvider.token;
  }

  Future<http.Response> _handleResponse(http.Response response) async {
    if (response.statusCode == 401) {
      Provider.of<AuthProvider>(context, listen: false).clearToken();
      _redirectToLogin();
    }
    return response;
  }

  void _redirectToLogin() {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  Future<http.Response> _sendRequest(String method, String endpoint,
      {Map<String, dynamic>? body}) async {
    final uri = _buildUri(endpoint);
    final token = await _getToken();
    final headers = <String, String>{'Content-Type': 'application/json'};

    if (token != null) {
      headers.addAll(AppApiConfig.getHeaders(token));
    }

    http.Response response;
    switch (method) {
      case 'GET':
        response = await http.get(uri, headers: headers);
        break;
      case 'POST':
        response =
            await http.post(uri, headers: headers, body: json.encode(body));
        break;
      case 'PUT':
        response =
            await http.put(uri, headers: headers, body: json.encode(body));
        break;
      case 'DELETE':
        response = await http.delete(uri, headers: headers);
        break;
      default:
        throw UnsupportedError('Unsupported HTTP method: $method');
    }

    return await _handleResponse(response);
  }

  Future<http.Response> get(String endpoint) => _sendRequest('GET', endpoint);

  Future<http.Response> post(String endpoint, Map<String, dynamic> body) =>
      _sendRequest('POST', endpoint, body: body);

  Future<http.Response> put(String endpoint, Map<String, dynamic> body) =>
      _sendRequest('PUT', endpoint, body: body);

  Future<http.Response> delete(String endpoint) =>
      _sendRequest('DELETE', endpoint);
}
