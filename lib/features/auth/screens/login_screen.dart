import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:eyecare_app/theme/colors.dart';
import 'package:eyecare_app/common/widgets/auth_header.dart';
import 'package:eyecare_app/features/auth/data/auth_api.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _form = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _pass = TextEditingController();

  bool _loading = false;

  @override
  void dispose() {
    _email.dispose();
    _pass.dispose();
    super.dispose();
  }

  InputDecoration _dec(String hint) => InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: AppColors.fieldFill,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      );

  Future<void> _login() async {
    if (!_form.currentState!.validate()) return;

    setState(() => _loading = true);

    try {
      final auth = context.read<AuthApi>();

      await auth.login(
        email: _email.text.trim(),
        password: _pass.text,
      );

      if (!mounted) return;

      // Go to home (MainScaffold)
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          children: [
            const AuthHeader(title: 'Login'),
            const SizedBox(height: 12),

            Form(
              key: _form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: _dec('Email'),
                    validator: (v) =>
                        (v == null || v.trim().isEmpty) ? 'Required' : null,
                  ),
                  const SizedBox(height: 14),

                  TextFormField(
                    controller: _pass,
                    obscureText: true,
                    decoration: _dec('Password'),
                    validator: (v) => (v == null || v.length < 6)
                        ? 'Min 6 chars'
                        : null,
                  ),

                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // later: add forgot password screen
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.muted,
                      ),
                      child: const Text('Forgot password?'),
                    ),
                  ),

                  const SizedBox(height: 6),

                  _loading
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: _login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            minimumSize: const Size.fromHeight(48),
                            shape: const StadiumBorder(),
                            elevation: 0,
                          ),
                          child: const Text(
                            'Log in',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                  const SizedBox(height: 12),

                  TextButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, '/register'),
                    child: const Text('create account'),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
