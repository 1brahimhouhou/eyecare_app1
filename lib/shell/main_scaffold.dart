import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:code_eyecare/features/home/screens/home_screen.dart';
import 'package:code_eyecare/features/appointments/screens/appointments_list_screen.dart';
import 'package:code_eyecare/features/shop/screens/shop_categories_screen.dart';
import 'package:code_eyecare/features/profile/screens/profile_screen.dart';
import 'package:code_eyecare/features/shop/data/cart_provider.dart';
import 'package:code_eyecare/features/shop/screens/cart_screen.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});
  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _index = 0;

  static const _titles = <String>['Home', 'Appointments', 'Shop', 'Profile'];
  final _pages = const <Widget>[HomeScreen(), AppointmentsListScreen(), ShopCategoriesScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    final cartCount = context.watch<CartProvider>().totalItems;
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_index]),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CartScreen())),
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(Icons.shopping_cart_outlined),
                if (cartCount > 0)
                  Positioned(
                    right: -2,
                    top: -2,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                      child: Text('$cartCount', style: const TextStyle(color: Colors.white, fontSize: 10)),
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
          NavigationDestination(icon: Icon(Icons.event_note_outlined), label: 'Appointments'),
          NavigationDestination(icon: Icon(Icons.storefront_outlined), label: 'Shop'),
          NavigationDestination(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}
