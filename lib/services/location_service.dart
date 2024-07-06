import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:frontend_flutter/utils/response_handler_utils.dart';

class LocationService {
  static const baseUrl = 'https://www.emsifa.com/api-wilayah-indonesia/api/';
  final BuildContext _context;

  LocationService({required BuildContext context}) : _context = context;

  Future<List<Map<String, dynamic>>> fetchProvinces() async {
    try {
      final uri = Uri.parse('${baseUrl}provinces.json');
      final response = await http.get(uri);
      return _handleResponse(response);
    } catch (e) {
      _handleError(e);
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> fetchCities(String provinceId) async {
    try {
      final uri = Uri.parse('${baseUrl}regencies/$provinceId.json');
      final response = await http.get(uri);
      return _handleResponse(response);
    } catch (e) {
      _handleError(e);
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> fetchSubDistricts(String regencyId) async {
    try {
      final uri = Uri.parse('${baseUrl}districts/$regencyId.json');
      final response = await http.get(uri);
      return _handleResponse(response);
    } catch (e) {
      _handleError(e);
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> fetchUrbanVillages(
      String districtId) async {
    try {
      final uri = Uri.parse('${baseUrl}villages/$districtId.json');
      final response = await http.get(uri);
      return _handleResponse(response);
    } catch (e) {
      _handleError(e);
      return [];
    }
  }

  List<Map<String, dynamic>> _handleResponse(http.Response response) {
    final List<dynamic> data = jsonDecode(response.body);
    return List<Map<String, dynamic>>.from(
        data.map((item) => item as Map<String, dynamic>));
  }

  void _handleError(dynamic error) {
    if (_context.mounted) {
      ResponseHandlerUtils.onSubmitFailed(_context, error.toString());
    }
  }
}
