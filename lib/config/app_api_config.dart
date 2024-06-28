class AppApiConfig {
  static const String _developmentBaseUrl =
      'https://personwithai.my.id/orphancare/api';
  static const String _stagingBaseUrl =
      'https://personwithai.my.id/orphancare/api';
  static const String _productionBaseUrl = 'https://api.psaa-annajah.my.id/api';

  static const bool isProduction = bool.fromEnvironment('dart.vm.product');
  static const bool isStaging = bool.fromEnvironment('dart.vm.staging');

  static String get baseUrl {
    if (isProduction) {
      return _productionBaseUrl;
    } else if (isStaging) {
      return _stagingBaseUrl;
    } else {
      return _developmentBaseUrl;
    }
  }

  static Map<String, String> getHeaders(String token) {
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }
}
