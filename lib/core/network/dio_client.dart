// lib/core/network/dio_client.dart
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioClient {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://reqres.in/api',
      headers: {'Content-Type': 'application/json'},
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
      // Let us inspect status codes ourselves
      validateStatus: (_) => true,
    ),
  );

  static void enableLogging() {
    dio.interceptors.clear();
    dio.interceptors.add(LogInterceptor(
      request: true, requestHeader: true, requestBody: true,
      responseHeader: false, responseBody: true, error: true,
    ));
  }

  static Future<void> setupAuthHeader() async {
    final sp = await SharedPreferences.getInstance();
    final token = sp.getString('auth_token');
    if (token != null && token.isNotEmpty) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    } else {
      dio.options.headers.remove('Authorization');
    }
  }
}
