class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String image;
  Product({required this.id, required this.name, required this.description, required this.price, required this.image});
}

final products = <Product>[
  Product(
    id: 'p1',
    name: 'Classic Frame',
    description: 'Lightweight acetate frame for daily use.',
    price: 49.99,
    image: 'https://images.unsplash.com/photo-1511499767150-a48a237f0083?w=640',
  ),
  Product(
    id: 'p2',
    name: 'Blue Light Block',
    description: 'Protect your eyes from blue light.',
    price: 69.00,
    image: 'https://images.unsplash.com/photo-1509099836639-18ba1795216d?w=640',
  ),
  Product(
    id: 'p3',
    name: 'Sun Glasses',
    description: 'Polarized lenses for sunny days.',
    price: 89.50,
    image: 'https://images.unsplash.com/photo-1511497584788-876760111969?w=640',
  ),
];
