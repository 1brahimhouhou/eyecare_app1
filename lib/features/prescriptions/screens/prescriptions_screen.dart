import 'package:flutter/material.dart';
import '../data/prescriptions_repo.dart';

class PrescriptionsScreen extends StatefulWidget {
  const PrescriptionsScreen({super.key});
  @override
  State<PrescriptionsScreen> createState() => _PrescriptionsScreenState();
}

class _PrescriptionsScreenState extends State<PrescriptionsScreen> {
  final _repo = PrescriptionsRepo();
  List<Prescription> _items = [];
  bool _loading = true;

  @override
  void initState() { super.initState(); _load(); }

  Future<void> _load() async {
    final list = await _repo.list();
    setState(() { _items = list; _loading = false; });
  }

  Future<void> _addDialog() async {
    final right = TextEditingController();
    final left  = TextEditingController();
    final notes = TextEditingController();
    DateTime date = DateTime.now();

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Add prescription'),
        content: SizedBox(
          width: 380,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: right, decoration: const InputDecoration(hintText: 'Right eye (Sph/Cyl/Axis)')),
              const SizedBox(height: 8),
              TextField(controller: left,  decoration: const InputDecoration(hintText: 'Left eye (Sph/Cyl/Axis)')),
              const SizedBox(height: 8),
              TextField(controller: notes, decoration: const InputDecoration(hintText: 'Notes')),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(child: Text('Date: ${date.toLocal().toString().split(".").first}')),
                  TextButton(
                    onPressed: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: date,
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2100),
                      );
                      if (d != null) date = d;
                    },
                    child: const Text('Pick date'),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          FilledButton(
            onPressed: () async {
              if (right.text.trim().isEmpty || left.text.trim().isEmpty) return;
              await _repo.add(
                date: date,
                rightEye: right.text.trim(),
                leftEye: left.text.trim(),
                notes: notes.text.trim(),
              );
              if (context.mounted) Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
    await _load();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Center(child: CircularProgressIndicator());
    return Scaffold(
      appBar: AppBar(title: const Text('My Prescriptions')),
      body: _items.isEmpty
          ? const Center(child: Text('No prescriptions yet'))
          : ListView.separated(
              itemCount: _items.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (_, i) {
                final p = _items[i];
                return ListTile(
                  title: Text(p.date.toLocal().toString().split(' ').first),
                  subtitle: Text('OD: ${p.rightEye}\nOS: ${p.leftEye}\n${p.notes}'),
                  isThreeLine: true,
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () async { await _repo.remove(p.id); await _load(); },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
