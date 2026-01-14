import 'package:flutter/material.dart';

// ✅ Use RELATIVE imports (fixes red import errors)
import '../../../shell/main_scaffold.dart';
import '../../prescriptions/screens/prescriptions_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFBFB),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            'Welcome, Ibrahim 👋',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        const SizedBox(height: 20),

        _tile(
          context,
          'Book Appointment',
          onTap: () {
            // ✅ Switch to Appointments tab (index 1)
            MainScaffold.goToTab(context, 1);
          },
        ),

        _tile(
          context,
          'Shop Eyewear',
          onTap: () {
            // ✅ Switch to Shop tab (index 2)
            MainScaffold.goToTab(context, 2);
          },
        ),

        _tile(
          context,
          'My Prescriptions',
          onTap: () {
            // ✅ Open prescriptions page
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const PrescriptionsScreen(),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _tile(
    BuildContext context,
    String text, {
    required VoidCallback onTap,
  }) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: ListTile(
          title: Text(text),
          trailing: const Icon(Icons.chevron_right),
        ),
      ),
    );
  }
}
