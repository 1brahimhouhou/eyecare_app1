import 'package:flutter/material.dart';
import 'package:code_eyecare/theme/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Widget _row(String title, {String? subtitle, IconData icon = Icons.chevron_right, bool danger=false}) {
    return Container(
      height: 72,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: danger ? const Color(0xFFDE4437) : AppColors.text,
                )),
                if (subtitle != null) Text(subtitle, style: const TextStyle(color: AppColors.muted, fontSize: 12)),
              ],
            ),
          ),
          Icon(icon, color: AppColors.muted),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: const [
        SizedBox(height: 8),
        Center(child: CircleAvatar(radius: 42, backgroundColor: AppColors.tint, child: Text('i', style: TextStyle(fontSize: 28)))),
        SizedBox(height: 8),
        Center(child: Text('ibrahim Houhou', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700))),
        SizedBox(height: 24),
        // البنود مثل الـ PDF
        // Edit profile / Notifications / Settings / My orders / Logout
      ],
    );
  }
}
