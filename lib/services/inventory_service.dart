import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend_flutter/models/inventory_model.dart';
import 'package:frontend_flutter/services/api_service.dart';
import 'package:http/http.dart' as http;

class InventoryService {
  final ApiService _apiService;

  InventoryService(BuildContext context) : _apiService = ApiService(context);

  Future<List<InventoryType>> fetchInventoryTypes() async {
    final http.Response response =
        await _apiService.get('/admin/inventory-types');
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => InventoryType.fromJson(json)).toList();
  }

  Future<List<Inventory>> fetchInventories() async {
    final http.Response response = await _apiService.get('/admin/inventories');
    final Map<String, dynamic> decodedResponse = jsonDecode(response.body);
    final List<dynamic> data = decodedResponse['data'];
    return data.map((json) => Inventory.fromJson(json)).toList();
  }

  Future<Inventory> createInventory(Map<String, dynamic> requestData) async {
    final http.Response response =
        await _apiService.post('/admin/inventories', requestData);
    final Map<String, dynamic> decodedResponse = jsonDecode(response.body);
    return Inventory.fromJson(decodedResponse);
  }

  Future<Inventory> updateInventory(
      String id, Map<String, dynamic> requestData) async {
    final http.Response response =
        await _apiService.put('/admin/inventories/$id', requestData);
    final Map<String, dynamic> data = jsonDecode(response.body);
    return Inventory.fromJson(data);
  }

  Future<Inventory> fetchInventoryById(String id) async {
    final http.Response response =
        await _apiService.get('/admin/inventories/$id');
    final Map<String, dynamic> data = jsonDecode(response.body);
    return Inventory.fromJson(data);
  }

  Future<bool> deleteInventoryById(String id) async {
    final http.Response response =
        await _apiService.delete('/admin/inventories/$id');
    return response.statusCode == 204 ? true : false;
  }
}
