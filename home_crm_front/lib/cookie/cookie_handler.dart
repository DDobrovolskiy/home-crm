import 'package:shared_preferences/shared_preferences.dart';

class CookieHandler {
  Future<void> saveValue(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    switch(value.runtimeType){
      case String:
        await prefs.setString(key, value);
        break;
      case int:
        await prefs.setInt(key, value);
        break;
      case bool:
        await prefs.setBool(key, value);
        break;
      default:
        throw Exception('Unsupported type');
    }
  }

  Future<String?> getValue(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
}