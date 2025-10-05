// lib/features/auth/screens/login_screen.dart
import 'package:flutter/material.dart';

import 'package:code_eyecare/shell/main_scaffold.dart';
import 'package:code_eyecare/theme/colors.dart';
import 'package:code_eyecare/common/validators.dart';
import 'package:code_eyecare/common/widgets/primary_button.dart';
import 'package:code_eyecare/features/auth/data/auth_api.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey  = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl  = TextEditingController();

  bool _loading = false;
  final _auth = AuthApi();

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Future<void> _doLogin() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    FocusScope.of(context).unfocus();
    setState(() => _loading = true);

    try {
      await _auth.login(
        email: _emailCtrl.text.trim(),
        password: _passCtrl.text.trim(),
      );

      if (!mounted) return;
      // انتقال مباشر للشاشة الرئيسية
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const MainScaffold()),
      );

      // إذا حابب تستخدم routes جاهزة بدل المباشر:
      // Navigator.pushReplacementNamed(context, '/main');

    } catch (e) {
      if (!mounted) return;
      final msg = e.toString().replaceFirst('Exception: ', '');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(msg)),
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
          padding: const EdgeInsets.all(24),
          children: [
            const SizedBox(height: 24),

            // شعار بسيط (مستطيل ملوّن مثل التصميم)
            Container(
              height: 140,
              decoration: BoxDecoration(
                color: AppColors.tint,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: Text(
                  'BabiVision Mobile',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                ),
              ),
            ),

            const SizedBox(height: 24),
            Text(
              'Login',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 12),

            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _emailCtrl,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    autofillHints: const [AutofillHints.email],
                    decoration: const InputDecoration(hintText: 'Email'),
                    validator: Validators.email,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passCtrl,
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => _doLogin(),
                    decoration: const InputDecoration(hintText: 'Password'),
                    validator: (v) => Validators.minLen(v, 6),
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Forgot password?',
                      style: TextStyle(color: AppColors.muted),
                    ),
                  ),
                  const SizedBox(height: 24),

                  _loading
                      ? const Center(child: CircularProgressIndicator())
                      : PrimaryButton(
                          label: 'Log in',
                          onPressed: _doLogin,
                        ),

                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/register'),
                    child: const Text('create account'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
