import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend_flutter/models/guardian_model.dart';
import 'package:frontend_flutter/models/user_model.dart';
import 'package:frontend_flutter/services/api_service.dart';
import 'package:frontend_flutter/utils/response_handler_utils.dart';
import 'package:http/http.dart' as http;

class UserService {
  final ApiService _apiService;
  final BuildContext context;

  UserService({required this.context}) : _apiService = ApiService(context);

  Future<UserResponse> fetchCurrentUser() async {
    final http.Response response =
        await _apiService.get('/public/profiles/current-user');
    final Map<String, dynamic> data = jsonDecode(response.body);
    return UserResponse.fromJson(data);
  }

  Future<List<GuardianType>> fetchGuardianTypes() async {
    final http.Response response =
        await _apiService.get('/admin/guardian-types');
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => GuardianType.fromJson(json)).toList();
  }

  Future<Map<String, dynamic>> createUser(
    Map<String, dynamic> userRequest,
  ) async {
    try {
      final http.Response response = await _apiService.post(
        '/admin/users',
        userRequest,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data;
      } else {
        final Map<String, dynamic> data = jsonDecode(response.body);
        if (context.mounted) {
          ResponseHandlerUtils.onSubmitFailed(context, data['message']);
        }
        return {};
      }
    } catch (e) {
      if (context.mounted) {
        ResponseHandlerUtils.onSubmitFailed(context, e.toString());
      }
      return {};
    }
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
