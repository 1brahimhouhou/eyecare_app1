import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

// adjust this relative path to where your dio_client.dart is:
import '../../../core/network/dio_client.dart';

class AuthApi {
  static const _kToken = 'auth_token';

  // Use the same Dio instance everywhere
  final Dio _dio = DioClient.dio;

  /// Returns true if we already have a token locally.
  Future<bool> isLoggedIn() async {
    final sp = await SharedPreferences.getInstance();
    return sp.getString(_kToken)?.isNotEmpty ?? false;
  }

  /// Login (Reqres: POST /login) – only needs email & password.
  Future<void> login({
    required String email,
    required String password,
  }) async {
    // Some APIs expect NO auth header on login
    _dio.options.headers.remove('Authorization');

    final res = await _dio.post('/login', data: {
      'email': email,
      'password': password,
    });

    if (res.statusCode == 200) {
      final token = res.data['token']?.toString();
      if (token != null && token.isNotEmpty) {
        final sp = await SharedPreferences.getInstance();
        await sp.setString(_kToken, token);
        await DioClient.setupAuthHeader(); // re-apply header after saving token
        return;
      }
    }
    throw Exception(res.data['error'] ?? 'Login failed (${res.statusCode})');
  }

  /// Register (Reqres: POST /register) – you can ignore `name` for Reqres.
  Future<void> register({
    String? name, // optional for Reqres
    required String email,
    required String password,
  }) async {
    // Remove auth header on register too
    _dio.options.headers.remove('Authorization');

    final res = await _dio.post('/register', data: {
      'email': email,
      'password': password,
      // If your real API needs a name, include it here
      if (name != null && name.isNotEmpty) 'name': name,
    });

    // Reqres returns 200 (or 201 on some backends)
    if (res.statusCode == 200 || res.statusCode == 201) {
      final token = res.data['token']?.toString();
      if (token != null && token.isNotEmpty) {
        final sp = await SharedPreferences.getInstance();
        await sp.setString(_kToken, token);
        await DioClient.setupAuthHeader();
        return;
      }
    }
    throw Exception(res.data['error'] ?? 'Register failed (${res.statusCode})');
  }

  /// Log out locally (clear token & header)
  Future<void> logout() async {
    final sp = await SharedPreferences.getInstance();
    await sp.remove(_kToken);
    await DioClient.setupAuthHeader(); // this will clear header when token is missing
  }
}
