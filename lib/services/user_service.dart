import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend_flutter/models/user_model.dart';
import 'package:frontend_flutter/services/api_service.dart';
import 'package:http/http.dart' as http;

class UserService {
  final ApiService _apiService;

  UserService(BuildContext context) : _apiService = ApiService(context);

  Future<CurrentUser> fetchCurrentUser() async {
    final http.Response response =
        await _apiService.get('/public/profiles/current-user');
    final Map<String, dynamic> data = jsonDecode(response.body);
    return CurrentUser.fromJson(data);
  }

  Future<List<UserResponse>> fetchUserProfiles({
    String? roles,
    String? gender,
    String? search,
  }) async {
    final queryParams = <String, dynamic>{};
    if (roles != null) queryParams['roles'] = roles;
    if (gender != null) queryParams['gender'] = gender;
    if (search != null) queryParams['search'] = search;

    final http.Response response =
        await _apiService.get('/admin/users', queryParams);
    final Map<String, dynamic> decodedResponse = jsonDecode(response.body);
    final List<dynamic> data = decodedResponse['data'];
    return data.map((json) => UserResponse.fromJson(json)).toList();
  }
}
