import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../token_service.dart';

class Port {
  static String path(String path) {
    var baseUrl = dotenv.env['BASE_URL'];
    return "$baseUrl$path";
  }

  static Future<Response> get(String path) async {
    return await TokenService().getToken(TokenService.authToken).then((
      token,
    ) async {
      return await Dio().get(
        Port.path(path),
        options: Options(
          contentType: 'application/json',
          headers: {'Authorization': token},
        ),
      );
    });
  }

  static Future<Response> post(String path, Map<String, dynamic> body) async {
    return await TokenService().getToken(TokenService.authToken).then((
      token,
    ) async {
      return await Dio().post(
        Port.path(path),
        data: body,
        options: Options(
          contentType: 'application/json',
          headers: {'Authorization': token},
        ),
      );
    });
  }
}
