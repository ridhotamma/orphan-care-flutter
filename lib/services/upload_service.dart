import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:frontend_flutter/services/api_service.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class UploadService {
  final ApiService _apiService;
  final BuildContext _context;

  UploadService({required BuildContext context})
      : _context = context,
        _apiService = ApiService(context);

  Future<Map<String, dynamic>> uploadFile(String filePath) async {
    try {
      final fileName = filePath.split('/').last;
      final mimeTypeData = lookupMimeType(fileName)!.split('/');
      final file = File(filePath);
      final response = await _apiService.uploadFile(
        '/public/files/upload',
        file,
        fileName,
        MediaType(mimeTypeData[0], mimeTypeData[1]),
      );
      return _handleResponse(response);
    } catch (e) {
      _handleError(e);
      return {};
    }
  }

  Future<Map<String, dynamic>> uploadFileBytes(
      List<int> fileBytes, String fileName) async {
    try {
      final mimeTypeData = lookupMimeType(fileName)!.split('/');
      final response = await _apiService.uploadFileBytes(
        '/public/files/upload',
        fileBytes,
        fileName,
        MediaType(mimeTypeData[0], mimeTypeData[1]),
      );
      return _handleResponse(response);
    } catch (e) {
      _handleError(e);
      return {};
    }
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    final Map<String, dynamic> data = jsonDecode(response.body);
    return data;
  }

  void _handleError(dynamic error) {
    if (_context.mounted) {
      debugPrint(error.toString());
    }
  }
}
