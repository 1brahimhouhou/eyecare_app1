import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(color: const Color(0xFFE6FBFB), borderRadius: BorderRadius.circular(16)),
          child: Text('Welcome, Ibrahim 👋', style: Theme.of(context).textTheme.headlineMedium),
        ),
        const SizedBox(height: 16),
        _tile(context, '📅  Book Appointment', onTap: () => Navigator.pushNamed(context, '/appointments')),
        _tile(context, '🕶️  Shop Eyewear', onTap: () => Navigator.pushNamed(context, '/shop')),
        _tile(context, '🧾  My Prescriptions', onTap: () => Navigator.pushNamed(context, '/prescriptions')),
      ],
    );
  }

  Widget _tile(BuildContext ctx, String text, {VoidCallback? onTap}) {
    return Card(
      child: ListTile(
        title: Text(text),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
