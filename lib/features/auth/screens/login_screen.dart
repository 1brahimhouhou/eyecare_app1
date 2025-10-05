import 'package:flutter/material.dart';
import 'package:code_eyecare/features/auth/data/auth_api.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _form = GlobalKey<FormState>();
  final _email = TextEditingController(text: 'eve.holt@reqres.in');
  final _pass = TextEditingController(text: 'cityslicka');
  final _api = AuthApi();
  bool _loading = false;

  Future<void> _doLogin() async {
    if (!_form.currentState!.validate()) return;
    setState(() => _loading = true);
    try {
      await _api.login(email: _email.text.trim(), password: _pass.text);
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/main');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: SafeArea(
        child: Form(
          key: _form,
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              const SizedBox(height: 24),
              Center(child: Text('BabiVision Mobile', style: Theme.of(context).textTheme.titleLarge)),
              const SizedBox(height: 24),
              TextFormField(
                controller: _email,
                decoration: const InputDecoration(hintText: 'Email'),
                validator: (v) => (v == null || !v.contains('@')) ? 'Enter a valid email' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _pass,
                decoration: const InputDecoration(hintText: 'Password'),
                obscureText: true,
                validator: (v) => (v == null || v.length < 4) ? 'Min 4 chars' : null,
              ),
              const SizedBox(height: 24),
              _loading
                  ? const Center(child: CircularProgressIndicator())
                  : FilledButton(onPressed: _doLogin, child: const Text('Log in')),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/register'),
                child: const Text('Create account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
