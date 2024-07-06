import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend_flutter/models/inventory_model.dart';
import 'package:frontend_flutter/services/api_service.dart';
import 'package:frontend_flutter/utils/response_handler_utils.dart';
import 'package:http/http.dart' as http;

class InventoryService {
  final ApiService _apiService;
  final BuildContext _context;

  InventoryService({required BuildContext context})
      : _context = context,
        _apiService = ApiService(context);

  Future<List<InventoryType>> fetchInventoryTypes() async {
    try {
      final response = await _apiService.get('/admin/inventory-types');
      return _handleInventoryTypeListResponse(response);
    } catch (e) {
      _handleError(e);
      return [];
    }
  }

  Future<List<Inventory>> fetchInventories() async {
    try {
      final response = await _apiService.get('/admin/inventories');
      return _handleInventoryListResponse(response);
    } catch (e) {
      _handleError(e);
      return [];
    }
  }

  Future<Inventory> createInventory(Map<String, dynamic> requestData) async {
    try {
      final response =
          await _apiService.post('/admin/inventories', requestData);
      return _handleInventoryResponse(response);
    } catch (e) {
      _handleError(e);
      return Inventory();
    }
  }

  Future<Inventory> updateInventory(
      String id, Map<String, dynamic> requestData) async {
    try {
      final response =
          await _apiService.put('/admin/inventories/$id', requestData);
      return _handleInventoryResponse(response);
    } catch (e) {
      _handleError(e);
      return Inventory();
    }
  }

  Future<Inventory> fetchInventoryById(String id) async {
    try {
      final response = await _apiService.get('/admin/inventories/$id');
      return _handleInventoryResponse(response);
    } catch (e) {
      _handleError(e);
      return Inventory();
    }
  }

  Future<bool> deleteInventoryById(String id) async {
    try {
      final response = await _apiService.delete('/admin/inventories/$id');
      return response.statusCode == 204;
    } catch (e) {
      _handleError(e);
      return false;
    }
  }

  List<InventoryType> _handleInventoryTypeListResponse(http.Response response) {
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => InventoryType.fromJson(json)).toList();
  }

  List<Inventory> _handleInventoryListResponse(http.Response response) {
    final Map<String, dynamic> decodedResponse = jsonDecode(response.body);
    final List<dynamic> data = decodedResponse['data'];
    return data.map((json) => Inventory.fromJson(json)).toList();
  }

  Inventory _handleInventoryResponse(http.Response response) {
    final Map<String, dynamic> data = jsonDecode(response.body);
    return Inventory.fromJson(data);
  }

  void _handleError(dynamic error) {
    if (_context.mounted) {
      ResponseHandlerUtils.onSubmitFailed(_context, error.toString());
    }
  }
}
