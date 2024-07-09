import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:frontend_flutter/utils/exception_util.dart';
import 'package:frontend_flutter/utils/response_handler_util.dart';
import 'package:http/http.dart' as http;
import 'package:frontend_flutter/config/app_api_config.dart';
import 'package:http_parser/http_parser.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:frontend_flutter/providers/auth_provider.dart';

class ApiService {
  final BuildContext context;

  ApiService(this.context);

  Uri _buildUri(String endpoint, [Map<String, dynamic>? queryParams]) {
    final uri = Uri.parse('${AppApiConfig.baseUrl}$endpoint');
    if (queryParams != null) {
      return uri.replace(queryParameters: queryParams);
    }
    return uri;
  }

  Future<String?> _getToken() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return authProvider.token;
  }

  Future<http.Response> _handleResponse(http.Response response) async {
    switch (response.statusCode) {
      case 200:
      case 201:
        return response;
      case 204:
        return response;
      case 400:
        throw BadRequestException('Bad Request: ${response.body}');
      case 401:
        Provider.of<AuthProvider>(context, listen: false).clearToken();
        _redirectToLogin();
        throw UnauthorizedException('Unauthorized');
      case 500:
        throw InternalServerErrorException(
            'Internal Server Error: ${response.body}');
      default:
        throw UnknownException(
            'Unknown Error: ${response.statusCode} ${response.body}');
    }
  }

  void _redirectToLogin() {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  Future<http.Response> _sendRequest(
    String method,
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final uri = _buildUri(endpoint, queryParams);
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
              await http.post(uri, headers: headers, body: jsonEncode(body));
          break;
        case 'PUT':
          response =
              await http.put(uri, headers: headers, body: jsonEncode(body));
          break;
        case 'DELETE':
          response = await http.delete(uri, headers: headers);
          break;
        default:
          throw UnsupportedError('Unsupported HTTP method: $method');
      }

      return await _handleResponse(response);
    } on BadRequestException catch (e) {
      if (context.mounted) {
        ResponseHandlerUtils.onSubmitFailed(
            context, 'BadRequestException: ${e.message}');
      }
      rethrow;
    } on UnauthorizedException catch (e) {
      if (context.mounted) {
        ResponseHandlerUtils.onSubmitFailed(
            context, 'UnauthorizedException: ${e.message}: ${e.message}');
      }
      rethrow;
    } on InternalServerErrorException catch (e) {
      if (context.mounted) {
        ResponseHandlerUtils.onSubmitFailed(context,
            'InternalServerErrorException: ${e.message}: ${e.message}: ${e.message}');
      }
      rethrow;
    } on UnknownException catch (e) {
      if (context.mounted) {
        ResponseHandlerUtils.onSubmitFailed(
            context, 'UnknownException: ${e.message}');
      }
      rethrow;
    }
  }

  Future<http.Response> get(String endpoint,
          [Map<String, dynamic>? queryParams]) =>
      _sendRequest('GET', endpoint, queryParams: queryParams);

  Future<http.Response> post(String endpoint, Map<String, dynamic> body) =>
      _sendRequest('POST', endpoint, body: body);

  Future<http.Response> put(String endpoint, Map<String, dynamic> body) =>
      _sendRequest('PUT', endpoint, body: body);

  Future<http.Response> delete(String endpoint) =>
      _sendRequest('DELETE', endpoint);

  Future<http.Response> uploadFile(
      String endpoint, File file, String fileName, MediaType mediaType) async {
    final uri = _buildUri(endpoint);
    final token = await _getToken();
    final headers = <String, String>{};

    if (token != null) {
      headers.addAll(AppApiConfig.getHeaders(token));
    }

    final request = http.MultipartRequest('POST', uri);
    request.headers.addAll(headers);
    request.files.add(await http.MultipartFile.fromPath(
      'file',
      file.path,
      filename: fileName,
      contentType: mediaType,
    ));

    if (kDebugMode) {
      print("Sending request to: $uri");
      print("Headers: $headers");
      print("File Name: $fileName");
      print("File Size: ${file.lengthSync()}");
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (kDebugMode) {
      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
    }

    return await _handleResponse(response);
  }

  Future<http.Response> uploadFileBytes(String endpoint, List<int> fileBytes,
      String fileName, MediaType mediaType) async {
    final uri = _buildUri(endpoint);
    final token = await _getToken();
    final headers = <String, String>{};

    if (token != null) {
      headers.addAll(AppApiConfig.getHeaders(token));
    }

    final request = http.MultipartRequest('POST', uri);
    request.headers.addAll(headers);
    request.files.add(http.MultipartFile.fromBytes(
      'file',
      fileBytes,
      filename: fileName,
      contentType: mediaType,
    ));

    if (kDebugMode) {
      print("Sending request to: $uri");
      print("Headers: $headers");
      print("File Name: $fileName");
      print("File Size: ${fileBytes.length}");
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (kDebugMode) {
      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
    }

    return await _handleResponse(response);
  }
}
