import 'package:flutter/material.dart';
import 'package:code_eyecare/features/auth/data/auth_api.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _form = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController(text: 'eve.holt@reqres.in');
  final _pass = TextEditingController(text: 'p@ssw0rd');
  final _api = AuthApi();
  bool _loading = false;

  Future<void> _doReg() async {
    if (!_form.currentState!.validate()) return;
    setState(() => _loading = true);
    try {
      await _api.register(name: _name.text.trim(), email: _email.text.trim(), password: _pass.text);
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
      appBar: AppBar(title: const Text('Register')),
      body: SafeArea(
        child: Form(
          key: _form,
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              TextFormField(controller: _name, decoration: const InputDecoration(hintText: 'Full name')),
              const SizedBox(height: 12),
              TextFormField(
                controller: _email,
                decoration: const InputDecoration(hintText: 'Email'),
                validator: (v) => (v == null || !v.contains('@')) ? 'Enter a valid email' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _pass,
                decoration: const InputDecoration(hintText: 'Password'),
                obscureText: true,
                validator: (v) => (v == null || v.length < 4) ? 'Min 4 chars' : null,
              ),
              const SizedBox(height: 24),
              _loading
                  ? const Center(child: CircularProgressIndicator())
                  : FilledButton(onPressed: _doReg, child: const Text('Create account')),
            ],
          ),
        ),
      ),
    );
  }
}
