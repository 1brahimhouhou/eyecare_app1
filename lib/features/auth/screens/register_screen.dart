import 'package:flutter/material.dart';
import 'package:code_eyecare/common/widgets/app_text_field.dart';
import 'package:code_eyecare/common/widgets/primary_button.dart';
import 'package:code_eyecare/theme/colors.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: const [
            SizedBox(height: 12),
            Text('Register', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700)),
            SizedBox(height: 16),
            AppTextField(hint: 'Full name'),
            SizedBox(height: 16),
            AppTextField(hint: 'Email', keyboardType: TextInputType.emailAddress),
            SizedBox(height: 16),
            AppTextField(hint: 'Password', obscure: true),
            SizedBox(height: 16),
            AppTextField(hint: 'Confirm password', obscure: true),
            SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        child: PrimaryButton(label: 'Create account', onPressed: null),
      ),
    );
  }
}
