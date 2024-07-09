import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend_flutter/models/document_model.dart';
import 'package:frontend_flutter/services/api_service.dart';
import 'package:http/http.dart' as http;

class DocumentService {
  final ApiService _apiService;
  final BuildContext _context;

  DocumentService({required BuildContext context})
      : _context = context,
        _apiService = ApiService(context);

  Future<List<DocumentType>> fetchDocumentTypes() async {
    try {
      final response = await _apiService.get('/admin/document-types');
      return _handleDocumentTypeListResponse(response);
    } catch (e) {
      _handleError(e);
      return [];
    }
  }

  Future<List<Document>> fetchCurrentUserDocuments() async {
    try {
      final response = await _apiService.get('/public/users/documents');
      return _handleDocumentListResponse(response);
    } catch (e) {
      _handleError(e);
      return [];
    }
  }

  Future<List<Document>> fetchUserDocuments(String userId) async {
    try {
      final response = await _apiService.get('/public/users/$userId/documents');
      return _handleDocumentListResponse(response);
    } catch (e) {
      _handleError(e);
      return [];
    }
  }

  Future<void> createUserDocument(String userId, data) async {
    try {
      await _apiService.post('/public/users/$userId/documents', data);
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> deleteUserDocument(String userId, String documentId) async {
    try {
      await _apiService.delete('/public/users/$userId/documents/$documentId');
    } catch (e) {
      _handleError(e);
    }
  }

  List<DocumentType> _handleDocumentTypeListResponse(http.Response response) {
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => DocumentType.fromJson(json)).toList();
  }

  List<Document> _handleDocumentListResponse(http.Response response) {
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => Document.fromJson(json)).toList();
  }

  void _handleError(dynamic error) {
    if (_context.mounted) {
      debugPrint(error.toString());
    }
  }
}
