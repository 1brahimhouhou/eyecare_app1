import 'package:shared_preferences/shared_preferences.dart';

class AuthApi {
  static const _kToken = 'auth_token';

  Future<bool> isLoggedIn() async {
    final sp = await SharedPreferences.getInstance();
    return sp.getString(_kToken)?.isNotEmpty ?? false;
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    // fake local validation
    await Future.delayed(const Duration(milliseconds: 300));

    if (email.trim().isEmpty || password.isEmpty) {
      throw Exception('Email and password are required');
    }
    if (email.trim() == 'fail@example.com') {
      throw Exception('Invalid credentials');
    }

    final sp = await SharedPreferences.getInstance();
    await sp.setString(_kToken, 'local_${DateTime.now().millisecondsSinceEpoch}');
  }

  Future<void> register({
    String? name,
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));

    if (email.trim().isEmpty || password.isEmpty) {
      throw Exception('Email and password are required');
    }
    if (email.trim().endsWith('@test.com')) {
      throw Exception('Email already exists');
    }

    final sp = await SharedPreferences.getInstance();
    await sp.setString(_kToken, 'local_${DateTime.now().millisecondsSinceEpoch}');
  }

  Future<void> logout() async {
    final sp = await SharedPreferences.getInstance();
    await sp.remove(_kToken);
  }
}
