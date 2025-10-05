import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/catalog.dart';
import '../data/cart_provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final cart = context.read<CartProvider>();
    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Image.network(product.image, height: 180, fit: BoxFit.cover),
          const SizedBox(height: 16),
          Text(product.name, style: Theme.of(context).textTheme.headlineSmall),
          Text('\$${product.price.toStringAsFixed(2)}'),
          const SizedBox(height: 8),
          Text(product.description),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () => cart.addItem(
              id: product.id,
              name: product.name,
              price: product.price,
              image: product.image,
            ),
            icon: const Icon(Icons.add_shopping_cart),
            label: const Text('Add to cart'),
          ),
        ],
      ),
    );
  }
}
