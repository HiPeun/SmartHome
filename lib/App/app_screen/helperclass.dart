import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthHelper {
  static const String _isLoginKey = 'isLogin';
  static const String _userIdKey = 'user_id';
  static const String _authTokenKey = 'auth_token';
  static final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  static Future<void> saveLoginStatus(bool isLogin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoginKey, isLogin);
  }

  static Future<bool> getLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoginKey) ?? false;
  }

  static Future<void> saveUserId(String userId) async {
    await secureStorage.write(key: _userIdKey, value: userId);
  }

  static Future<String?> getUserId() async {
    return await secureStorage.read(key: _userIdKey);
  }

  static Future<void> saveAuthToken(String token) async {
    await secureStorage.write(key: _authTokenKey, value: token);
  }

  static Future<String?> getAuthToken() async {
    return await secureStorage.read(key: _authTokenKey);
  }

  static Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoginKey, false);
    await secureStorage.delete(key: _userIdKey);
    await secureStorage.delete(key: _authTokenKey);
  }
}
