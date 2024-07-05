// https://www.emsifa.com/api-wilayah-indonesia/api/provinces.json
// https://www.emsifa.com/api-wilayah-indonesia/api/regencies/11.json
// https://www.emsifa.com/api-wilayah-indonesia/api/districts/1102.json
// https://www.emsifa.com/api-wilayah-indonesia/api/villages/1102011.json

import 'dart:convert';
import 'package:http/http.dart' as http;

class LocationService {
  static const baseUrl = 'https://www.emsifa.com/api-wilayah-indonesia/api/';

  Future<List<Map<String, dynamic>>> fetchProvinces() async {
    final uri = Uri.parse('$baseUrl/provinces.json');
    http.Response response = await http.get(uri);
    final List<dynamic> data = jsonDecode(response.body);

    return List<Map<String, dynamic>>.from(
        data.map((item) => item as Map<String, dynamic>));
  }

  Future<List<Map<String, dynamic>>> fetchCities(String provinceId) async {
    final uri = Uri.parse('$baseUrl/regencies/$provinceId.json');
    http.Response response = await http.get(uri);
    final List<dynamic> data = jsonDecode(response.body);

    return List<Map<String, dynamic>>.from(
        data.map((item) => item as Map<String, dynamic>));
  }

  Future<List<Map<String, dynamic>>> fetchSubDistricts(String regencyId) async {
    final uri = Uri.parse('$baseUrl/districts/$regencyId.json');
    http.Response response = await http.get(uri);
    final List<dynamic> data = jsonDecode(response.body);

    return List<Map<String, dynamic>>.from(
        data.map((item) => item as Map<String, dynamic>));
  }

  Future<List<Map<String, dynamic>>> fetchUrbanVillages(
      String districtId) async {
    final uri = Uri.parse('$baseUrl/villages/$districtId.json');
    http.Response response = await http.get(uri);
    final List<dynamic> data = jsonDecode(response.body);

    return List<Map<String, dynamic>>.from(
        data.map((item) => item as Map<String, dynamic>));
  }
}
