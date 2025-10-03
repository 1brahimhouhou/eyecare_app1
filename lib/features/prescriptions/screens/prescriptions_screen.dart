import 'package:flutter/material.dart';
import 'package:code_eyecare/theme/colors.dart';
import 'package:code_eyecare/common/widgets/primary_button.dart';

class PrescriptionsScreen extends StatelessWidget {
  const PrescriptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = const [
      ("Dr. Sara • 2025-05-10", "Sphere: -2.00 / Cylinder: -0.50"),
      ("Clinic West • 2024-10-03", "Contact lens: -1.75 (R/L)"),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('My Prescriptions'), backgroundColor: AppColors.tint, elevation: 0),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          PrimaryButton(label: "Upload prescription", onPressed: () {}),
          const SizedBox(height: 16),
          ...items.map((e) => Container(
                height: 84,
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    const Icon(Icons.visibility_outlined, color: AppColors.muted),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(e.$1, style: const TextStyle(fontWeight: FontWeight.w600)),
                          const SizedBox(height: 6),
                          Text(e.$2, style: const TextStyle(color: AppColors.muted, fontSize: 13)),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
