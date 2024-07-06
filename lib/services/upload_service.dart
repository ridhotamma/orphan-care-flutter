import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend_flutter/services/api_service.dart';
import 'package:http/http.dart' as http;

class UploadService {
  final ApiService _apiService;
  final BuildContext _context;

  UploadService({required BuildContext context})
      : _context = context,
        _apiService = ApiService(context);

  Future<Map<String, dynamic>> uploadFile(
      String filePath, String fileName) async {
    final response = await _apiService.uploadFile(
      '/public/files/upload',
      filePath,
      fileName,
    );
    return _handleResponse(response);
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    final Map<String, dynamic> data = jsonDecode(response.body);
    return data;
  }
}
