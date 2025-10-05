import 'package:flutter/material.dart';
import '../data/appointments_repo.dart';

class AppointmentsListScreen extends StatefulWidget {
  const AppointmentsListScreen({super.key});
  @override
  State<AppointmentsListScreen> createState() => _AppointmentsListScreenState();
}

class _AppointmentsListScreenState extends State<AppointmentsListScreen> {
  final _repo = AppointmentsRepo();
  List<Appointment> _items = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final list = await _repo.list();
    setState(() { _items = list; _loading = false; });
  }

  Future<void> _addDialog() async {
    final clinic = TextEditingController();
    final doctor = TextEditingController();
    final reason = TextEditingController();
    DateTime? dt;

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Book appointment'),
        content: SizedBox(
          width: 380,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: clinic, decoration: const InputDecoration(hintText: 'Clinic')),
              const SizedBox(height: 8),
              TextField(controller: doctor, decoration: const InputDecoration(hintText: 'Doctor')),
              const SizedBox(height: 8),
              TextField(controller: reason, decoration: const InputDecoration(hintText: 'Reason')),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(child: Text(dt == null ? 'Pick date & time' : dt.toString())),
                  TextButton(
                    onPressed: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (d == null) return;
                      final t = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (t == null) return;
                      dt = DateTime(d.year, d.month, d.day, t.hour, t.minute);
                      setState(() {});
                    },
                    child: const Text('Choose'),
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
              if (dt == null || clinic.text.isEmpty) return;
              await _repo.add(
                dateTime: dt!,
                clinic: clinic.text.trim(),
                doctor: doctor.text.trim(),
                reason: reason.text.trim(),
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
      appBar: AppBar(title: const Text('Appointments')),
      body: _items.isEmpty
          ? const Center(child: Text('No appointments yet'))
          : ListView.separated(
              itemBuilder: (_, i) {
                final a = _items[i];
                return ListTile(
                  title: Text('${a.clinic} — ${a.doctor}'),
                  subtitle: Text('${a.dateTime} • ${a.reason}'),
                  trailing: Wrap(
                    spacing: 8,
                    children: [
                      IconButton(
                        tooltip: 'Confirm',
                        onPressed: () async { await _repo.toggleConfirm(a.id); await _load(); },
                        icon: Icon(a.confirmed ? Icons.check_circle : Icons.radio_button_unchecked,
                          color: a.confirmed ? Colors.green : null),
                      ),
                      IconButton(
                        tooltip: 'Delete',
                        onPressed: () async { await _repo.remove(a.id); await _load(); },
                        icon: const Icon(Icons.delete_outline),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemCount: _items.length,
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
