import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenService {
  static const String _tokenKey = 'authToken';

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<bool> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(_tokenKey, token);
  }

  Future<bool> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(_tokenKey);
  }

  Future<void> checkAuthAndRedirect(BuildContext context) async {
    TokenService().getToken().then((hasToken) {
      if (hasToken == null) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
    // final hasToken = await TokenService().getToken() != null;
    // if (!hasToken) {
    //   Navigator.pushReplacementNamed(context, '/login');
    // }
  }
}
