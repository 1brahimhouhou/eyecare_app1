import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class Appointment {
  final String id;
  final DateTime dateTime;
  final String clinic;
  final String doctor;
  final String reason;
  final bool confirmed;

  Appointment({
    required this.id,
    required this.dateTime,
    required this.clinic,
    required this.doctor,
    required this.reason,
    this.confirmed = false,
  });

  Appointment copyWith({bool? confirmed}) => Appointment(
        id: id,
        dateTime: dateTime,
        clinic: clinic,
        doctor: doctor,
        reason: reason,
        confirmed: confirmed ?? this.confirmed,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'dateTime': dateTime.toIso8601String(),
        'clinic': clinic,
        'doctor': doctor,
        'reason': reason,
        'confirmed': confirmed,
      };

  static Appointment fromJson(Map<String, dynamic> j) => Appointment(
        id: j['id'] as String,
        dateTime: DateTime.parse(j['dateTime'] as String),
        clinic: j['clinic'] as String,
        doctor: j['doctor'] as String,
        reason: j['reason'] as String,
        confirmed: (j['confirmed'] as bool?) ?? false,
      );
}

class AppointmentsRepo {
  static const _kKey = 'appointments';
  final _uuid = const Uuid();

  Future<List<Appointment>> list() async {
    final sp = await SharedPreferences.getInstance();
    final raw = sp.getString(_kKey);
    if (raw == null || raw.isEmpty) return [];
    final arr = (jsonDecode(raw) as List).cast<Map<String, dynamic>>();
    return arr.map(Appointment.fromJson).toList();
  }

  Future<void> _save(List<Appointment> items) async {
    final sp = await SharedPreferences.getInstance();
    final encoded = jsonEncode(items.map((e) => e.toJson()).toList());
    await sp.setString(_kKey, encoded);
  }

  Future<void> add({
    required DateTime dateTime,
    required String clinic,
    required String doctor,
    required String reason,
  }) async {
    final items = await list();
    items.add(
      Appointment(
        id: _uuid.v4(),
        dateTime: dateTime,
        clinic: clinic,
        doctor: doctor,
        reason: reason,
      ),
    );
    await _save(items);
  }

  Future<void> toggleConfirm(String id) async {
    final items = await list();
    final i = items.indexWhere((e) => e.id == id);
    if (i == -1) return;
    items[i] = items[i].copyWith(confirmed: !items[i].confirmed);
    await _save(items);
  }

  Future<void> remove(String id) async {
    final items = await list();
    items.removeWhere((e) => e.id == id);
    await _save(items);
  }
}
