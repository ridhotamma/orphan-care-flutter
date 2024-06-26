import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend_flutter/models/user_model.dart';
import 'package:frontend_flutter/services/api_service.dart';
import 'package:http/http.dart' as http;

class UserService {
  final ApiService apiService;

  UserService(BuildContext context) : apiService = ApiService(context);

  Future<CurrentUser> fetchCurrentUser() async {
    final http.Response response =
        await apiService.get('/public/profiles/current-user');
    final Map<String, dynamic> data = jsonDecode(response.body);
    return CurrentUser.fromJson(data);
  }
}
