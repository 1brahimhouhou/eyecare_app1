import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartItem {
  final String id;
  final String name;
  final double price;
  final String? image;
  int quantity;
  CartItem({required this.id, required this.name, required this.price, this.image, this.quantity = 1});

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'price': price, 'image': image, 'quantity': quantity};
  factory CartItem.fromJson(Map<String, dynamic> j) =>
      CartItem(id: j['id'], name: j['name'], price: (j['price'] as num).toDouble(), image: j['image'], quantity: j['quantity'] ?? 1);
}

class CartProvider extends ChangeNotifier {
  static const _kKey = 'cart_items';
  final Map<String, CartItem> _map = {};

  List<CartItem> get items => _map.values.toList();
  int get totalItems => _map.values.fold(0, (s, e) => s + e.quantity);
  double get totalPrice => _map.values.fold(0, (s, e) => s + e.price * e.quantity);

  Future<void> load() async {
    final sp = await SharedPreferences.getInstance();
    final raw = sp.getString(_kKey);
    if (raw == null) return;
    final list = (jsonDecode(raw) as List).cast<Map<String, dynamic>>();
    _map
      ..clear()
      ..addEntries(list.map((m) {
        final c = CartItem.fromJson(m);
        return MapEntry(c.id, c);
      }));
    notifyListeners();
  }

  Future<void> _save() async {
    final sp = await SharedPreferences.getInstance();
    await sp.setString(_kKey, jsonEncode(_map.values.map((e) => e.toJson()).toList()));
  }

  void addItem({required String id, required String name, required double price, String? image}) {
    if (_map.containsKey(id)) {
      _map[id]!.quantity++;
    } else {
      _map[id] = CartItem(id: id, name: name, price: price, image: image);
    }
    _save();
    notifyListeners();
  }

  void increment(String id) {
    if (_map.containsKey(id)) {
      _map[id]!.quantity++;
      _save();
      notifyListeners();
    }
  }

  void decrement(String id) {
    if (!_map.containsKey(id)) return;
    final c = _map[id]!;
    c.quantity--;
    if (c.quantity <= 0) _map.remove(id);
    _save();
    notifyListeners();
  }

  void remove(String id) {
    _map.remove(id);
    _save();
    notifyListeners();
  }

  void clear() {
    _map.clear();
    _save();
    notifyListeners();
  }
}

