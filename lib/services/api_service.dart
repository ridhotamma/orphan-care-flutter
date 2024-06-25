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
    return Uri.parse('${AppApiConfig.baseUrl}/$endpoint');
  }

  Future<String?> _getToken() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return authProvider.token;
  }

  Future<http.Response> _handleResponse(http.Response response) async {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response;
    } else if (response.statusCode == 401) {
      Provider.of<AuthProvider>(context, listen: false).clearToken();
      throw Exception('Unauthorized');
    } else {
      throw Exception('Error: ${response.statusCode} ${response.reasonPhrase}');
    }
  }

  Future<http.Response> get(String endpoint) async {
    final uri = _buildUri(endpoint);
    final token = await _getToken();
    final headers = AppApiConfig.getHeaders(token!);
    final response = await http.get(uri, headers: headers);
    return await _handleResponse(response);
  }

  Future<http.Response> post(String endpoint, Map<String, dynamic> body) async {
    final uri = _buildUri(endpoint);
    final token = await _getToken();
    final headers = AppApiConfig.getHeaders(token!);
    final response =
        await http.post(uri, headers: headers, body: json.encode(body));
    return await _handleResponse(response);
  }

  Future<http.Response> put(String endpoint, Map<String, dynamic> body) async {
    final uri = _buildUri(endpoint);
    final token = await _getToken();
    final headers = AppApiConfig.getHeaders(token!);
    final response =
        await http.put(uri, headers: headers, body: json.encode(body));
    return await _handleResponse(response);
  }

  Future<http.Response> delete(String endpoint) async {
    final uri = _buildUri(endpoint);
    final token = await _getToken();
    final headers = AppApiConfig.getHeaders(token!);
    final response = await http.delete(uri, headers: headers);
    return await _handleResponse(response);
  }
}
