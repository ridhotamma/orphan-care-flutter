import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  String? _token;
  late SharedPreferences _prefs;
  late Future<void> _initFuture;

  AuthProvider() {
    _initFuture = _initPreferences();
  }

  Future<void> _initPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    _token = _prefs.getString('token');
    notifyListeners();
  }

  Future<void> get initFuture => _initFuture;

  String? get token => _token;

  bool get hasToken => _token != null;

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
