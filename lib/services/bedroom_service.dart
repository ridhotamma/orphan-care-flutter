import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend_flutter/models/bedroom_model.dart';
import 'package:frontend_flutter/services/api_service.dart';
import 'package:frontend_flutter/utils/response_handler_utils.dart';
import 'package:http/http.dart' as http;

class BedroomService {
  final ApiService _apiService;
  final BuildContext _context;

  BedroomService({required BuildContext context})
      : _context = context,
        _apiService = ApiService(context);

  Future<List<BedRoomType>> fetchBedRoomTypes() async {
    try {
      final response = await _apiService.get('/admin/bedroom-types');
      return _handleBedRoomTypeListResponse(response);
    } catch (e) {
      _handleError(e);
      return [];
    }
  }

  Future<List<BedRoom>> fetchBedRooms() async {
    try {
      final response = await _apiService.get('/admin/bedrooms');
      return _handleBedRoomListResponse(response);
    } catch (e) {
      _handleError(e);
      return [];
    }
  }

  Future<BedRoom> createBedRoom(Map<String, dynamic> requestData) async {
    try {
      final response = await _apiService.post('/admin/bedrooms', requestData);
      return _handleBedRoomResponse(response);
    } catch (e) {
      _handleError(e);
      return BedRoom();
    }
  }

  Future<BedRoom> fetchBedRoomById(String id) async {
    try {
      final response = await _apiService.get('/admin/bedrooms/$id');
      return _handleBedRoomResponse(response);
    } catch (e) {
      _handleError(e);
      return BedRoom();
    }
  }

  Future<BedRoom> updateBedRoom(String id, Map<String, dynamic> bedroom) async {
    try {
      final response = await _apiService.put('/admin/bedrooms/$id', bedroom);
      return _handleBedRoomResponse(response);
    } catch (e) {
      _handleError(e);
      return BedRoom();
    }
  }

  Future<bool> deleteBedRoomById(String id) async {
    try {
      final response = await _apiService.delete('/admin/bedrooms/$id');
      return response.statusCode == 204;
    } catch (e) {
      _handleError(e);
      return false;
    }
  }

  List<BedRoomType> _handleBedRoomTypeListResponse(http.Response response) {
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => BedRoomType.fromJson(json)).toList();
  }

  List<BedRoom> _handleBedRoomListResponse(http.Response response) {
    final Map<String, dynamic> decodedResponse = jsonDecode(response.body);
    final List<dynamic> data = decodedResponse['data'];
    return data.map((json) => BedRoom.fromJson(json)).toList();
  }

  BedRoom _handleBedRoomResponse(http.Response response) {
    final Map<String, dynamic> data = jsonDecode(response.body);
    return BedRoom.fromJson(data);
  }

  void _handleError(dynamic error) {
    if (_context.mounted) {
      ResponseHandlerUtils.onSubmitFailed(_context, error.toString());
    }
  }
}
