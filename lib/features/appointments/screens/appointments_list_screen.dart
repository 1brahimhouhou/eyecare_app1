import 'package:flutter/material.dart';
import 'package:code_eyecare/theme/colors.dart';
import 'package:code_eyecare/common/widgets/primary_button.dart';

class AppointmentsListScreen extends StatelessWidget {
  const AppointmentsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = const [
      ('Eye exam', 'Main Branch', 'Confirmed'),
      ('Eye exam', 'West Branch', 'Pending'),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Appointments'), backgroundColor: AppColors.tint, elevation: 0),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          PrimaryButton(label: 'Book new appointments', onPressed: () {}),
          const SizedBox(height: 16),
          ...items.map((e) => Container(
                height: 88,
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                ),
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_month, color: AppColors.muted),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(e.$1, style: const TextStyle(fontWeight: FontWeight.w700)),
                          const SizedBox(height: 4),
                          Text(e.$2, style: const TextStyle(color: AppColors.muted)),
                        ],
                      ),
                    ),
                    Text(e.$3, style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600)),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
