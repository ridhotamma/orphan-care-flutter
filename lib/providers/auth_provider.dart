import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  String? _token;
  late SharedPreferences _prefs;

  Future<void> initPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    _token = _prefs.getString('token');
  }

  String? get token => _token;

  void setToken(String? token) {
    _token = token;
    _prefs.setString('token', token ?? '');
    notifyListeners();
  }

  void clearToken() {
    _token = null;
    _prefs.remove('token');
    notifyListeners();
  }
}
