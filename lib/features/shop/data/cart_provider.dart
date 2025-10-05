import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartItem {
  final String id;
  final String name;
  final double price;
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    this.quantity = 1,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'price': price,
        'quantity': quantity,
      };

  factory CartItem.fromMap(Map<String, dynamic> map) => CartItem(
        id: map['id'] as String,
        name: map['name'] as String,
        price: (map['price'] as num).toDouble(),
        quantity: map['quantity'] as int,
      );
}

class CartProvider extends ChangeNotifier {
  static const _kKey = 'cart_items';

  final List<CartItem> _items = [];
  List<CartItem> get items => List.unmodifiable(_items);

  // ← المطلوب من MainScaffold
  int get totalItems => _items.fold(0, (sum, it) => sum + it.quantity);

  double get totalPrice =>
      _items.fold(0.0, (sum, it) => sum + it.price * it.quantity);

  Future<void> load() async {
    final sp = await SharedPreferences.getInstance();
    final raw = sp.getString(_kKey);
    if (raw == null) return;
    final decoded = jsonDecode(raw);
    if (decoded is List) {
      final list = decoded
          .map((e) => CartItem.fromMap(Map<String, dynamic>.from(e)))
          .toList()
          .cast<CartItem>();
      _items
        ..clear()
        ..addAll(list);
      notifyListeners();
    }
  }

  Future<void> _save() async {
    final sp = await SharedPreferences.getInstance();
    final raw = jsonEncode(_items.map((e) => e.toMap()).toList());
    await sp.setString(_kKey, raw);
  }

  void add(CartItem item) {
    final i = _items.indexWhere((e) => e.id == item.id);
    if (i >= 0) {
      _items[i].quantity += item.quantity;
    } else {
      _items.add(item);
    }
    _save();
    notifyListeners();
  }

  void remove(String id) {
    _items.removeWhere((e) => e.id == id);
    _save();
    notifyListeners();
  }

  void clear() {
    _items.clear();
    _save();
    notifyListeners();
  }

  void increment(String id) {
    final i = _items.indexWhere((e) => e.id == id);
    if (i >= 0) {
      _items[i].quantity++;
      _save();
      notifyListeners();
    }
  }

  void decrement(String id) {
    final i = _items.indexWhere((e) => e.id == id);
    if (i >= 0 && _items[i].quantity > 1) {
      _items[i].quantity--;
      _save();
      notifyListeners();
    }
  }
}
