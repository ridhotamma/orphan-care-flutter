import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend_flutter/models/bedroom_model.dart';
import 'package:frontend_flutter/services/api_service.dart';
import 'package:http/http.dart' as http;

class BedroomService {
  final ApiService _apiService;

  BedroomService(BuildContext context) : _apiService = ApiService(context);

  Future<List<BedRoomType>> fetchBedRoomTypes() async {
    final http.Response response =
        await _apiService.get('/admin/bedroom-types');
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => BedRoomType.fromJson(json)).toList();
  }

  Future<List<BedRoom>> fetchBedRooms() async {
    final http.Response response = await _apiService.get('/admin/bedrooms');
    final Map<String, dynamic> decodedResponse = jsonDecode(response.body);
    final List<dynamic> data = decodedResponse['data'];
    return data.map((json) => BedRoom.fromJson(json)).toList();
  }

  Future<BedRoom> createBedRoom(Map<String, dynamic> requestData) async {
    final http.Response response =
        await _apiService.post('/admin/bedrooms', requestData);
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    return BedRoom.fromJson(responseData);
  }

  Future<BedRoom> fetchBedRoomById(String id) async {
    final http.Response response = await _apiService.get('/admin/bedrooms/$id');
    final Map<String, dynamic> data = jsonDecode(response.body);
    return BedRoom.fromJson(data);
  }

  Future<BedRoom> updateBedRoom(String id, Map<String, dynamic> bedroom) async {
    final http.Response response =
        await _apiService.put('/admin/bedrooms/$id', bedroom);
    final Map<String, dynamic> data = jsonDecode(response.body);
    return BedRoom.fromJson(data);
  }

  Future<bool> deleteBedRoomById(String id) async {
    final http.Response response =
        await _apiService.delete('/admin/bedrooms/$id');
    return response.statusCode == 204 ? true : false;
  }
}
