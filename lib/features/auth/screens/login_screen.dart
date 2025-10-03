import 'package:flutter/material.dart';
import 'package:code_eyecare/common/widgets/app_text_field.dart';
import 'package:code_eyecare/common/widgets/primary_button.dart';
import 'package:code_eyecare/theme/colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            // Header مثل PDF
            Container(
              height: 140,
              decoration: BoxDecoration(
                color: AppColors.tint,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: Text('BabiVision\nMobile',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700)),
              ),
            ),
            const SizedBox(height: 24),
            const Text('Login', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700)),
            const SizedBox(height: 16),
            const AppTextField(hint: 'Email', keyboardType: TextInputType.emailAddress),
            const SizedBox(height: 16),
            const AppTextField(hint: 'Password', obscure: true),
            const SizedBox(height: 8),
            const Align(
              alignment: Alignment.centerRight,
              child: Text('Forgot password?', style: TextStyle(color: AppColors.muted)),
            ),
            const SizedBox(height: 24),
            PrimaryButton(label: 'Log in', onPressed: () => Navigator.pushReplacementNamed(context, '/main')),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/register'),
              child: const Text('create account'),
            ),
          ],
        ),
      ),
    );
  }
}
