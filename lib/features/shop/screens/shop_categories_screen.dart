import 'package:flutter/material.dart';
import '../data/catalog.dart';
import 'product_details_screen.dart';

class ShopCategoriesScreen extends StatelessWidget {
  const ShopCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shop Eyewear')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: products.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (_, i) {
          final p = products[i];
          return Card(
            child: ListTile(
              leading: Image.network(p.image, width: 56, height: 56, fit: BoxFit.cover),
              title: Text(p.name),
              subtitle: Text('\$${p.price.toStringAsFixed(2)}'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ProductDetailsScreen(product: p)),
              ),
            ),
          );
        },
      ),
    );
  }
}
