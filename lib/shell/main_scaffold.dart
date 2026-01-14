import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ✅ Use RELATIVE imports (fixes your red import errors)
import '../features/home/screens/home_screen.dart';
import '../features/appointments/screens/appointments_list_screen.dart';
import '../features/shop/screens/shop_categories_screen.dart';
import '../features/profile/screens/profile_screen.dart';
import '../features/shop/screens/cart_screen.dart';
import '../features/shop/data/cart_provider.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  static void goToTab(BuildContext context, int index) {
    final _MainScaffoldState? state =
        context.findAncestorStateOfType<_MainScaffoldState>();
    if (state == null) return;
    state.setState(() => state._index = index);
  }

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _index = 0;

  static const List<String> _titles = [
    'Home',
    'Appointments',
    'Shop',
    'Profile',
  ];

  // ✅ IMPORTANT: remove "const" from the list if any screen constructor isn't const
final List<Widget> _pages = [
  HomeScreen(),
  AppointmentsListScreen(),
  ShopCategoriesScreen(),
  ProfileScreen(),
];


  @override
  Widget build(BuildContext context) {
    final cartCount = context.watch<CartProvider>().totalItems;

    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_index]),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CartScreen()),
              );
            },
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(Icons.shopping_cart_outlined),
                if (cartCount > 0)
                  Positioned(
                    right: -6,
                    top: -6,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '$cartCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      body: _pages[_index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
          NavigationDestination(
              icon: Icon(Icons.event_note_outlined), label: 'Appointments'),
          NavigationDestination(
              icon: Icon(Icons.storefront_outlined), label: 'Shop'),
          NavigationDestination(
              icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}
