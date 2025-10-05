import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'theme/colors.dart';
import 'shell/main_scaffold.dart';

// لو بدك بوابة لوج-إن: استعمل FakeAuth/isLoggedIn اللي عملناه قبل
// import 'features/auth/data/fake_auth.dart';
// import 'features/auth/screens/login_screen.dart';
// import 'features/auth/screens/register_screen.dart';

import 'features/shop/data/cart_provider.dart';
import 'features/appointments/screens/appointments_list_screen.dart';
import 'features/shop/screens/cart_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final cart = CartProvider();
  await cart.load();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<CartProvider>.value(value: cart),
      ],
      child: const BabiVisionApp(),
    ),
  );
}

class BabiVisionApp extends StatelessWidget {
  const BabiVisionApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
      scaffoldBackgroundColor: Colors.white,
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: AppColors.text,
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BabiVision',
      theme: theme,
      home: const MainScaffold(),
      routes: {
        '/appointments': (_) => const AppointmentsListScreen(),
        '/cart': (_) => const CartScreen(),
      },
    );
  }
}
