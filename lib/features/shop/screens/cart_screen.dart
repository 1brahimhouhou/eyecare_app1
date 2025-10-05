import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// غيّر المسار إذا لزم حسب مشروعك
import 'package:code_eyecare/features/shop/data/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final items = cart.items;          // List<CartItem>
    final total = cart.totalPrice;     // double

    return Scaffold(
      appBar: AppBar(title: Text('Cart (${cart.totalItems})')),
      body: items.isEmpty
          ? const Center(child: Text('Your cart is empty'))
          : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemCount: items.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (_, i) {
                      final c = items[i]; // CartItem
                      return ListTile(
                        leading: const Icon(Icons.remove_red_eye_outlined, size: 28),
                        title: Text(c.name),
                        subtitle: Text('\$${c.price.toStringAsFixed(2)}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () => cart.decrement(c.id),
                              icon: const Icon(Icons.remove),
                            ),
                            Text('${c.quantity}'),
                            IconButton(
                              onPressed: () => cart.increment(c.id),
                              icon: const Icon(Icons.add),
                            ),
                            IconButton(
                              onPressed: () => cart.remove(c.id),
                              icon: const Icon(Icons.delete_outline),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Total',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        '\$${total.toStringAsFixed(2)}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
