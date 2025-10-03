import 'package:flutter/material.dart';
import 'package:code_eyecare/theme/colors.dart';
import 'package:code_eyecare/features/appointments/screens/appointments_list_screen.dart';
import 'package:code_eyecare/features/shop/screens/shop_categories_screen.dart';
import 'package:code_eyecare/features/profile/screens/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget _card(BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 343,
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 16, offset: Offset(0, 4))],
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primary, size: 28),
            const SizedBox(width: 12),
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
      children: [
        Container(
          height: 140,
          decoration: BoxDecoration(color: AppColors.tint, borderRadius: BorderRadius.circular(16)),
          padding: const EdgeInsets.all(16),
          child: const Align(
            alignment: Alignment.bottomLeft,
            child: Text('Welcome,\nIbrahim 👋', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700)),
          ),
        ),
        const SizedBox(height: 16),
        _card(context, Icons.calendar_month, 'Book Appointment', () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const AppointmentsListScreen()));
        }),
        _card(context, Icons.remove_red_eye_outlined, 'Shop Eyewear', () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const ShopCategoriesScreen()));
        }),
        _card(context, Icons.receipt_long, 'My Prescriptions', () {
          // بروح لصفحة البريسكربشنز إذا حتنضيف لاحقًا
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('My Prescriptions')));
        }),
      ],
    );
  }
}
