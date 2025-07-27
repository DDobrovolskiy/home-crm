import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenService {
  static const String authToken = 'authToken';

  Future<String?> getToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(token);
  }

  Future<bool> saveToken(String name, String token) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(name, token);
  }

  Future<bool> clearToken(String name) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(name);
  }

  Future<void> checkAuthAndRedirect(BuildContext context) async {
    TokenService().getToken(authToken).then((hasToken) {
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
