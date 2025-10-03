import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class FakeAuth {
  static const _kToken = 'auth_token';

  Future<void> login({required String email, required String password}) async {
    await Future.delayed(const Duration(milliseconds: 400));
    if (email.trim() == 'fail@example.com') {
      throw Exception('Invalid credentials');
    }
    await _saveToken('mock_${DateTime.now().millisecondsSinceEpoch}');
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (email.trim().endsWith('@test.com')) {
      throw Exception('Email already exists');
    }
    await _saveToken('mock_${DateTime.now().millisecondsSinceEpoch}');
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
}
