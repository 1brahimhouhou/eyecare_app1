import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartItem {
  final String id;
  final String name;
  final double price;
  final String? image;
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    this.image,
    this.quantity = 1,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'price': price,
        'image': image,
        'quantity': quantity,
      };

  factory CartItem.fromJson(Map<String, dynamic> j) => CartItem(
        id: j['id'] as String,
        name: j['name'] as String,
        price: (j['price'] as num).toDouble(),
        image: j['image'] as String?,
        quantity: (j['quantity'] as int?) ?? 1,
      );
}

class CartProvider extends ChangeNotifier {
  static const _kKey = 'cart_items';
  final Map<String, CartItem> _map = {};

  List<CartItem> get items => _map.values.toList();
  int get totalItems => _map.values.fold(0, (sum, e) => sum + e.quantity);
  double get totalPrice =>
      _map.values.fold(0.0, (sum, e) => sum + (e.price * e.quantity));

  Future<void> load() async {
    final sp = await SharedPreferences.getInstance();
    final raw = sp.getString(_kKey);
    if (raw == null || raw.isEmpty) return;

    final list = (jsonDecode(raw) as List)
    .cast<Map<String, dynamic>>()
    .map((next) => CartItem.fromJson(next))
    .toList();


    _map
      ..clear()
      ..addEntries(list.map((c) => MapEntry(c.id, c)));

    notifyListeners();
  }

  Future<void> _save() async {
    final sp = await SharedPreferences.getInstance();
    final encoded = jsonEncode(_map.values.map((e) => e.toJson()).toList());
    await sp.setString(_kKey, encoded);
  }

  Future<void> addItem({
    required String id,
    required String name,
    required double price,
    String? image,
  }) async {
    if (_map.containsKey(id)) {
      _map[id]!.quantity++;
    } else {
      _map[id] = CartItem(id: id, name: name, price: price, image: image);
    }
    await _save();
    notifyListeners();
  }

  Future<void> increment(String id) async {
    if (!_map.containsKey(id)) return;
    _map[id]!.quantity++;
    await _save();
    notifyListeners();
  }

  Future<void> decrement(String id) async {
    if (!_map.containsKey(id)) return;
    final item = _map[id]!;
    item.quantity--;
    if (item.quantity <= 0) _map.remove(id);
    await _save();
    notifyListeners();
  }

  Future<void> remove(String id) async {
    _map.remove(id);
    await _save();
    notifyListeners();
  }

  Future<void> clear() async {
    _map.clear();
    await _save();
    notifyListeners();
  }
}
