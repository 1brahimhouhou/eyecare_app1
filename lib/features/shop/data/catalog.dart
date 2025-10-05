class Product {
  final String id;
  final String name;
  final double price;
  final String category;
  final String image;
  final String description;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.image,
    required this.description,
  });
}

const products = <Product>[
  Product(
    id: 'p1',
    name: 'Classic Frames',
    price: 49.9,
    category: 'Eyeglasses',
    image: 'https://picsum.photos/seed/eyeglass1/200/120',
    description: 'Lightweight, durable everyday eyeglass frames.',
  ),
  Product(
    id: 'p2',
    name: 'Blue Light Blocker',
    price: 59.0,
    category: 'Eyeglasses',
    image: 'https://picsum.photos/seed/eyeglass2/200/120',
    description: 'Protective lenses for screens.',
  ),
  Product(
    id: 'p3',
    name: 'Daily Contacts',
    price: 29.5,
    category: 'Contact Lenses',
    image: 'https://picsum.photos/seed/contacts/200/120',
    description: 'Comfortable daily-use contact lenses.',
  ),
];
