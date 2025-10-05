import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class Prescription {
  final String id;
  final DateTime date;
  final String rightEye; // مثال: "Sph -1.50 / Cyl -0.50 / Axis 180"
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
    id: j['id'],
    date: DateTime.parse(j['date']),
    rightEye: j['rightEye'],
    leftEye: j['leftEye'],
    notes: j['notes'] ?? '',
  );
}

class PrescriptionsRepo {
  static const _kKey = 'prescriptions';
  final _uuid = const Uuid();

  Future<List<Prescription>> list() async {
    final sp = await SharedPreferences.getInstance();
    final raw = sp.getString(_kKey);
    if (raw == null) return [];
    final arr = (jsonDecode(raw) as List).cast<Map<String, dynamic>>();
    return arr.map(Prescription.fromJson).toList();
  }

  Future<void> _save(List<Prescription> items) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setString(_kKey, jsonEncode(items.map((e) => e.toJson()).toList()));
  }

  Future<void> add({
    required DateTime date,
    required String rightEye,
    required String leftEye,
    String notes = '',
  }) async {
    final items = await list();
    items.add(Prescription(
      id: _uuid.v4(),
      date: date,
      rightEye: rightEye,
      leftEye: leftEye,
      notes: notes,
    ));
    await _save(items);
  }

  Future<void> remove(String id) async {
    final items = await list();
    items.removeWhere((e) => e.id == id);
    await _save(items);
  }
}
