import 'package:flutter/material.dart';

class AppointmentsListScreen extends StatelessWidget {
  const AppointmentsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mock = List.generate(6, (i) => DateTime.now().add(Duration(days: i * 3)));
    return Scaffold(
      appBar: AppBar(title: const Text('Appointments')),
      body: ListView.separated(
        itemCount: mock.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (_, i) {
          final d = mock[i];
          return ListTile(
            leading: const Icon(Icons.event),
            title: Text('Check-up'),
            subtitle: Text('${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')} at 10:00'),
            trailing: const Icon(Icons.chevron_right),
          );
        },
      ),
    );
  }
}
