class ApiConfig {
  static String _backendUrl = 'http://20.102.109.114:3000';
  //static String _backendUrl = 'http://20.102.109.114:3000';

  static String get backendUrl => _backendUrl;

  static set backendUrl(String value) {
    _backendUrl = value;
  }
}

/**
 class ApiConfig {
  static const String backendUrl = 'http://192.168.1.96:3000';
}

Login
admin@admin.com
Javier12345
 */