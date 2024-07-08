import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend_flutter/models/analytic_model.dart';
import 'package:frontend_flutter/services/api_service.dart';
import 'package:http/http.dart' as http;

class AnalyticsService {
  final ApiService _apiService;
  final BuildContext _context;

  AnalyticsService({required BuildContext context})
      : _context = context,
        _apiService = ApiService(context);

  Future<AnalyticData> fetchHomePageAnalytics() async {
    try {
      final response = await _apiService.get('/admin/analytics/homepage');
      return _handleAnalyticsResponse(response);
    } catch (e) {
      _handleError(e);
      return AnalyticData();
    }
  }

  AnalyticData _handleAnalyticsResponse(http.Response response) {
    final Map<String, dynamic> data = jsonDecode(response.body);
    return AnalyticData.fromJson(data);
  }

  void _handleError(dynamic error) {
    if (_context.mounted) {
      debugPrint(error.toString());
    }
  }
}
