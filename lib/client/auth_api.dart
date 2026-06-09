import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api_client.dart';

class AuthApi {
  AuthApi({ApiClient? client}) : _client = client ?? ApiClient();

  final ApiClient _client;

  Future<bool> register(String email, String contrasenia) async {
    try {
      final res = await _client.dio.post(
        '/api/auth/register',
        data: {
          'email': email.trim(),
          'contrasenia': contrasenia.trim(),
        },
      );

      debugPrint('AuthApi.register statusCode: ${res.statusCode}');
      debugPrint('AuthApi.register response body: ${res.data}');

      return _isSuccess(res.statusCode);
    } on DioException catch (e) {
      debugPrint('AuthApi.register error: ${e.message}');
      return false;
    } catch (e) {
      debugPrint('AuthApi.register error: $e');
      return false;
    }
  }

  Future<String?> login(String email, String password) async {
    try {
      final res = await _client.dio.post(
        '/api/auth/login',
        data: {
          'email': email.trim(),
          'password': password.trim(),
        },
      );

      debugPrint('AuthApi.login statusCode: ${res.statusCode}');
      debugPrint('AuthApi.login response body: ${res.data}');

      if (!_isSuccess(res.statusCode)) {
        return null;
      }

      // Guardo token en SharedPreferences para usarlo luego
      final token = res.data;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      return token;

    } on DioException catch (e) {
      debugPrint('AuthApi.login error: ${e.message}');
      return null;
    } catch (e, stackTrace) {
      debugPrint('AuthApi.login error: $e');
      debugPrintStack(stackTrace: stackTrace);
      return null;
    }
  }

  bool _isSuccess(int? statusCode) {
    return statusCode != null && statusCode >= 200 && statusCode < 300;
  }

}
