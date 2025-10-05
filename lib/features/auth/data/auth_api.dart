import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/network/dio_client.dart';

class AuthApi {
  static const _kToken = 'auth_token';
  final Dio _dio = DioClient.dio;
  
  Future<bool> isLoggedIn() async {
    final sp = await SharedPreferences.getInstance();
    final token = sp.getString(_kToken);
    return token != null && token.isNotEmpty;
  }
  
  Future<void> _saveToken(String token) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setString(_kToken, token);
  }

  Future<String?> getToken() async {
    final sp = await SharedPreferences.getInstance();
    return sp.getString(_kToken);
  }

  Future<void> logout() async {
    final sp = await SharedPreferences.getInstance();
    await sp.remove(_kToken);
  }

  Future<void> login({required String email, required String password}) async {
    final res = await _dio.post('/login', data: jsonEncode({
      'email': email,
      'password': password,
    }));
    final token = res.data['token']?.toString();
    if (token == null) throw Exception('No token returned');
    await _saveToken(token);
  }

  Future<void> register({required String name, required String email, required String password}) async {
    final res = await _dio.post('/register', data: jsonEncode({
      'email': email,
      'password': password,
    }));
    final token = res.data['token']?.toString();
    if (token == null) throw Exception('No token returned');
    await _saveToken(token);
  }
}
