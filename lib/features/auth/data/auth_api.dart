import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/network/dio_client.dart';

class AuthApi {
  static const _kToken = 'auth_token';
  final Dio _dio = DioClient.I.dio;

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    // reqres ما بدها name، بس منبعته لو حبّينا
    final res = await _dio.post(
      '/register',
      data: {
        'email': email,      // لازم يكون valid عند reqres: eve.holt@reqres.in
        'password': password // أي كلمة سر
      },
    );
    // بيرجع token
    final token = (res.data as Map)['token'] as String?;
    if (token == null) {
      throw Exception('Invalid response (no token)');
    }
    await _saveToken(token);
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    final res = await _dio.post(
      '/login',
      data: {
        'email': email,      // eve.holt@reqres.in
        'password': password // cityslicka
      },
    );
    final token = (res.data as Map)['token'] as String?;
    if (token == null) {
      throw Exception('Invalid response (no token)');
    }
    await _saveToken(token);
  }

  Future<void> logout() async {
    final sp = await SharedPreferences.getInstance();
    await sp.remove(_kToken);
  }

  Future<bool> isLoggedIn() async {
    final sp = await SharedPreferences.getInstance();
    return sp.getString(_kToken)?.isNotEmpty == true;
  }

  Future<void> _saveToken(String token) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setString(_kToken, token);
  }

  Future<String?> getToken() async {
    final sp = await SharedPreferences.getInstance();
    return sp.getString(_kToken);
  }
}
