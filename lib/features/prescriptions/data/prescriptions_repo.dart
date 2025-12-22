import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Prescription {
  final String id;
  final DateTime date;
  final String rightEye;
  final String leftEye;
  final String notes;

  Prescription({
    required this.id,
    required this.date,
    required this.rightEye,
    required this.leftEye,
    required this.notes,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'date': date.toIso8601String(),
        'rightEye': rightEye,
        'leftEye': leftEye,
        'notes': notes,
      };

  static Prescription fromJson(Map<String, dynamic> j) => Prescription(
        id: j['id'] as String,
        date: DateTime.parse(j['date'] as String),
        rightEye: (j['rightEye'] as String?) ?? '',
        leftEye: (j['leftEye'] as String?) ?? '',
        notes: (j['notes'] as String?) ?? '',
      );
}

class PrescriptionsRepo {
  static const _kKey = 'prescriptions';

  Future<List<Prescription>> load() async {
    final sp = await SharedPreferences.getInstance();
    final raw = sp.getString(_kKey);
    if (raw == null || raw.isEmpty) return [];
    final list = (jsonDecode(raw) as List)
        .map((e) => Prescription.fromJson(e as Map<String, dynamic>))
        .toList();
    return list;
  }

  Future<void> save(List<Prescription> items) async {
    final sp = await SharedPreferences.getInstance();
    final encoded = jsonEncode(items.map((e) => e.toJson()).toList());
    await sp.setString(_kKey, encoded);
  }
}
