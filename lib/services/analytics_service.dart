import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend_flutter/models/analytic_model.dart';
import 'package:frontend_flutter/services/api_service.dart';
import 'package:http/http.dart' as http;

class AnalyticsService {
  final ApiService _apiService;
  final BuildContext context;

  AnalyticsService({required this.context}) : _apiService = ApiService(context);

  Future<AnalyticData> fetchHomePageAnalytics() async {
    final http.Response response =
        await _apiService.get('/admin/analytics/homepage');
    final Map<String, dynamic> data = jsonDecode(response.body);
    return AnalyticData.fromJson(data);
  }
}
