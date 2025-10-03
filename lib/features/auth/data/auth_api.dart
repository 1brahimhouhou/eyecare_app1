import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/network/dio_client.dart';

class AuthApi {
  static const _kToken = 'auth_token';
  final Dio _dio = DioClient.I.dio;

  Future<void> login({required String email, required String password}) async {
    final res = await _dio.post('/login', data: {'email': email, 'password': password});
    final token = res.data['token']?.toString();
    if (token == null || token.isEmpty) throw Exception('Login failed');
    final sp = await SharedPreferences.getInstance();
    await sp.setString(_kToken, token);
  }

  Future<void> register({required String name, required String email, required String password}) async {
    final res = await _dio.post('/register', data: {'email': email, 'password': password});
    final token = res.data['token']?.toString();
    if (token == null || token.isEmpty) throw Exception('Register failed');
    final sp = await SharedPreferences.getInstance();
    await sp.setString(_kToken, token);
  }

  Future<void> logout() async {
    final sp = await SharedPreferences.getInstance();
    await sp.remove(_kToken);
  }
}
