import 'package:flutter/material.dart';
import '../../../common/widgets/auth_header.dart';
import 'package:eyecare_app/theme/colors.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _form  = GlobalKey<FormState>();
  final _name  = TextEditingController();
  final _email = TextEditingController();
  final _pass  = TextEditingController();
  final _pass2 = TextEditingController();
  bool _loading = false;

  InputDecoration _dec(String hint) => InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: AppColors.fieldFill,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          children: [
            const AuthHeader(title: 'Register'),
            const SizedBox(height: 12),
            Form(
              key: _form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _name,
                    decoration: _dec('Full name'),
                    validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                  ),
                  const SizedBox(height: 14),
                  TextFormField(
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: _dec('Email'),
                    validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                  ),
                  const SizedBox(height: 14),
                  TextFormField(
                    controller: _pass,
                    obscureText: true,
                    decoration: _dec('Password'),
                    validator: (v) => (v == null || v.length < 6) ? 'Min 6 chars' : null,
                  ),
                  const SizedBox(height: 14),
                  TextFormField(
                    controller: _pass2,
                    obscureText: true,
                    decoration: _dec('Confirm password'),
                    validator: (v) => v != _pass.text ? 'Passwords don\'t match' : null,
                  ),
                  const SizedBox(height: 12),
                  _loading
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: () {
                            if (!_form.currentState!.validate()) return;
                            // استدعِ لوجيك الـ register تبعك هون
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            minimumSize: const Size.fromHeight(48),
                            shape: const StadiumBorder(),
                            elevation: 0,
                          ),
                          child: const Text('Create account', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                        ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account?  ', style: TextStyle(color: AppColors.muted)),
                      TextButton(
                        onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
                        child: const Text('Log in'),
                      ),
                    ],
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
