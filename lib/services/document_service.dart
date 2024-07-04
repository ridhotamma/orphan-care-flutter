import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend_flutter/models/document_model.dart';
import 'package:frontend_flutter/services/api_service.dart';
import 'package:http/http.dart' as http;

class DocumentService {
  final ApiService _apiService;

  DocumentService(BuildContext context) : _apiService = ApiService(context);

  Future<List<DocumentType>> fetchDocumentTypes() async {
    final http.Response response =
        await _apiService.get('/admin/document-types');
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => DocumentType.fromJson(json)).toList();
  }

  Future<List<DocumentType>> fetchCurrentUserDocuments() async {
    final http.Response response =
        await _apiService.get('/admin/users/documents');
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => DocumentType.fromJson(json)).toList();
  }

  Future<List<DocumentType>> fetchUserDocuments(String userId) async {
    final http.Response response =
        await _apiService.get('/admin/users/$userId/documents');
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => DocumentType.fromJson(json)).toList();
  }
}
