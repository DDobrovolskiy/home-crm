import 'package:flutter_dotenv/flutter_dotenv.dart';

class Port {
  static String getPath(String path) {
    var baseUrl = dotenv.env['BASE_URL'];
    return "$baseUrl$path";
  }
}
