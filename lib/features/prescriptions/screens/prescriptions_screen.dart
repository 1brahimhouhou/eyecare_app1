// lib/features/prescriptions/screens/prescriptions_screen.dart
import 'package:flutter/material.dart';
import '../data/prescriptions_repo.dart';

class PrescriptionsScreen extends StatefulWidget {
  const PrescriptionsScreen({super.key});

  @override
  State<PrescriptionsScreen> createState() => _PrescriptionsScreenState();
}

class _PrescriptionsScreenState extends State<PrescriptionsScreen> {
  final repo = PrescriptionsRepo();
  List<Prescription> items = [];

  @override
  void initState() {
    super.initState();
    repo.load().then((v) => setState(() => items = v));
  }

  Future<void> _add() async {
    final now = DateTime.now();
    final p = Prescription(
      id: 'rx_${now.millisecondsSinceEpoch}',
      date: now,
      rightEye: 'Sph -1.50 / Cyl -0.50 / Axis 180°',
      leftEye:  'Sph -1.25 / Cyl -0.25 / Axis 170°',
      notes: 'Auto-generated for demo',
    );
    setState(() => items.add(p));
    await repo.save(items);
  }

  Future<void> _remove(String id) async {
    setState(() => items.removeWhere((e) => e.id == id));
    await repo.save(items);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Prescriptions')),
      body: items.isEmpty
          ? const Center(child: Text('No prescriptions yet'))
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: items.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (_, i) {
                final p = items[i];
                return ListTile(
                  title: Text(
                    'Rx ${p.id}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  subtitle: Text(
                    '${p.date.toLocal()}'
                    '\nR: ${p.rightEye}\nL: ${p.leftEye}\n${p.notes}',
                  ),
                  isThreeLine: true,
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () => _remove(p.id),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _add,
        icon: const Icon(Icons.add),
        label: const Text('Add'),
      ),
    );
  }
}
