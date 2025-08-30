import 'package:flutter/cupertino.dart';
import 'package:home_crm_front/domain/support/router/roters.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenService {
  static const String authToken = 'authToken';
  static const String organizationToken = 'organizationToken';

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
        Navigator.pushReplacementNamed(context, RoutersApp.login);
      }
    });
  }

  Future<void> clearAllToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(authToken);
    await prefs.remove(organizationToken);
  }
}
