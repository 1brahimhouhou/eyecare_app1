import 'package:flutter/material.dart';
import 'package:code_eyecare/theme/colors.dart';

class ShopCategoriesScreen extends StatelessWidget {
  const ShopCategoriesScreen({super.key});

  Widget _tile(String title, IconData icon) {
    return Container(
      width: 343, height: 88,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 28),
          const SizedBox(width: 12),
          Expanded(child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600))),
          const Icon(Icons.chevron_right, color: AppColors.muted),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shop'), backgroundColor: AppColors.tint, elevation: 0),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _tile('Eyeglasses', Icons.remove_red_eye_outlined),
          _tile('Sunglasses', Icons.wb_sunny_outlined),
          _tile('Contact Lenses', Icons.circle_outlined),
        ],
      ),
    );
  }
}
