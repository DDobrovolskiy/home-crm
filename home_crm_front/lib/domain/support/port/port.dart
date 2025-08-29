import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:home_crm_front/domain/support/exceptions/exceptions.dart';
import 'package:home_crm_front/domain/support/port/response_dto.dart';

import '../token_service.dart';

class Port {
  static String path(String path) {
    var baseUrl = dotenv.env['BASE_URL'];
    return "$baseUrl$path";
  }

  static Future<T?> get<T>(
    String path,
      T Function(Object? json) fromJsonT) async {
    Map<String, dynamic>? headers = await getHeaders();
    var fullPath = Port.path(path);
    debugPrint('GET: $fullPath');
    final response = await Dio()
        .get(
      fullPath,
      options: Options(contentType: 'application/json', headers: headers),
    );
    ResponseDTO<dynamic> responseDTO = await handle(response, fromJsonT);
    return responseDTO.data;
  }

  static Future<T?> post<T>(String path,
      Map<String, dynamic> body,
      T Function(Object? json) fromJsonT) async {
    Map<String, dynamic>? headers = await getHeaders();
    var fullPath = Port.path(path);
    debugPrint('POST: $fullPath');
    final response = await Dio()
        .post(
      fullPath,
      data: body,
      options: Options(contentType: 'application/json', headers: headers),
    );
    ResponseDTO<dynamic> responseDTO = await handle(response, fromJsonT);
    return responseDTO.data;
  }

  static Future<T?> put<T>(String path,
      Map<String, dynamic> body,
      T Function(Object? json) fromJsonT) async {
    Map<String, dynamic>? headers = await getHeaders();
    var fullPath = Port.path(path);
    debugPrint('PUT: $fullPath');
    final response = await Dio()
        .put(
      fullPath,
      data: body,
      options: Options(contentType: 'application/json', headers: headers),
    );
    ResponseDTO<dynamic> responseDTO = await handle(response, fromJsonT);
    return responseDTO.data;
  }

  static Future<T?> delete<T>(String path,
      Map<String, dynamic> body,
      T Function(Object? json) fromJsonT) async {
    Map<String, dynamic>? headers = await getHeaders();
    var fullPath = Port.path(path);
    debugPrint('DELETE: $fullPath');
    final response = await Dio()
        .delete(
      fullPath,
      data: body,
      options: Options(contentType: 'application/json', headers: headers),
    );
    ResponseDTO<dynamic> responseDTO = await handle(response, fromJsonT);
    return responseDTO.data;
  }

  static Future<ResponseDTO<dynamic>> handle(Response<dynamic> response,
      Function(Object? json) fromJsonT) async {
    if (response.statusCode == 401) {
      debugPrint('HTTP-401');
      await TokenService().clearToken(TokenService.authToken);
      throw AuthException();
    } else if (response.statusCode != 200) {
      debugPrint('HTTP-${response.statusCode}');
      throw PortException();
    }
    var responseDTO = ResponseDTO.fromJson(response.data, fromJsonT);
    if (responseDTO.status != 0) {
      throw ResponseException(message: responseDTO.convertToString());
    }
    return responseDTO;
  }

  static Future<Map<String, dynamic>> getHeaders() async {
    Map<String, dynamic> headers = {};
    String? authToken = await TokenService().getToken(TokenService.authToken);
    if (authToken != null) {
      headers.putIfAbsent('Authorization', () => authToken);
    }
    String? orgToken = await TokenService().getToken(
      TokenService.organizationToken,
    );
    if (orgToken != null) {
      headers.putIfAbsent('Organization', () => orgToken);
    }
    return headers;
  }
}
