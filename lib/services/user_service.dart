import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend_flutter/models/guardian_model.dart';
import 'package:frontend_flutter/models/user_model.dart';
import 'package:frontend_flutter/services/api_service.dart';
import 'package:http/http.dart' as http;

class UserService {
  final ApiService _apiService;
  final BuildContext _context;

  UserService({required BuildContext context})
      : _context = context,
        _apiService = ApiService(context);

  Future<UserResponse> fetchCurrentUser() async {
    try {
      final response = await _apiService.get('/public/profiles/current-user');
      return _handleUserResponse(response);
    } catch (e) {
      _handleError(e);
    }
    return UserResponse.empty();
  }

  Future<UserResponse> fetchUserDetails(String userId) async {
    try {
      final response = await _apiService.get('/admin/users/$userId');
      return _handleUserResponse(response);
    } catch (e) {
      _handleError(e);
    }
    return UserResponse.empty();
  }

  Future<List<GuardianType>> fetchGuardianTypes() async {
    try {
      final response = await _apiService.get('/admin/guardian-types');
      return _handleGuardianTypeListResponse(response);
    } catch (e) {
      _handleError(e);
    }
    return List<GuardianType>.filled(1, GuardianType.empty());
  }

  Future<Map<String, dynamic>> createUser(
      Map<String, dynamic> userRequest) async {
    try {
      final response = await _apiService.post('/admin/users', userRequest);
      return jsonDecode(response.body);
    } catch (e) {
      _handleError(e);
      return {};
    }
  }

  Future<List<UserResponse>> fetchUserProfiles({
    String? roles,
    String? gender,
    String? search,
  }) async {
    final queryParams =
        _buildQueryParams(roles: roles, gender: gender, search: search);
    final response = await _apiService.get('/admin/users', queryParams);
    return _handleUserProfileListResponse(response);
  }

  Map<String, String> _buildQueryParams({
    String? roles,
    String? gender,
    String? search,
  }) {
    final queryParams = <String, String>{};
    if (roles != null) queryParams['roles'] = roles;
    if (gender != null) queryParams['gender'] = gender;
    if (search != null) queryParams['search'] = search;
    return queryParams;
  }

  UserResponse _handleUserResponse(http.Response response) {
    final Map<String, dynamic> data = jsonDecode(response.body);
    return UserResponse.fromJson(data);
  }

  List<GuardianType> _handleGuardianTypeListResponse(http.Response response) {
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => GuardianType.fromJson(json)).toList();
  }

  List<UserResponse> _handleUserProfileListResponse(http.Response response) {
    final Map<String, dynamic> decodedResponse = jsonDecode(response.body);
    final List<dynamic> data = decodedResponse['data'];
    return data.map((json) => UserResponse.fromJson(json)).toList();
  }

  void _handleError(dynamic error) {
    if (_context.mounted) {
      debugPrint(error.toString());
    }
  }
}
