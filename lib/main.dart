import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'theme/colors.dart';
import 'core/push/push_service.dart';
import 'features/shop/data/cart_provider.dart';
import 'shell/main_scaffold.dart';
import 'features/auth/data/auth_api.dart';



// إذا عندك FakeAuth بدّل السطر الجايي بهيك: import 'features/auth/data/fake_auth.dart';
import 'features/auth/data/auth_api.dart';

import 'features/auth/screens/login_screen.dart';
import 'features/auth/screens/register_screen.dart';
import 'features/home/screens/home_screen.dart';
import 'features/appointments/screens/appointments_list_screen.dart';
import 'features/shop/screens/shop_categories_screen.dart';
import 'features/prescriptions/screens/prescriptions_screen.dart';
import 'package:flutter/material.dart';
import 'core/network/dio_client.dart'; 

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioClient.enableLogging();        // so you can see requests/responses in the console
  await DioClient.setupAuthHeader();
  


  // Providers ready
  final cart = CartProvider();
  await cart.load();

  // Push init (اختياري إذا عامل الخدمة)
  await PushService.init();

  runApp(
    MultiProvider(
      providers: [
        // لأنّو عامل instance مسبقاً، استعمل .value
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
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      appBarTheme: const AppBarTheme(centerTitle: false),
    );

    return MaterialApp(
  title: 'BabiVision Mobile',
  debugShowCheckedModeBanner: false,
  initialRoute: '/login', // or '/'
  routes: {
  '/login': (_) => const LoginScreen(),
  '/register': (_) => const RegisterScreen(), // <- needed
  '/main': (_) => const MainScaffold(),
},

);

  }
}

/// بوابة بسيطة: إذا في توكن/سِشن بيروح عالـ Main، غير هيك عالـ Login
class _Gate extends StatelessWidget {
  const _Gate();

  @override
  Widget build(BuildContext context) {
    final future = AuthApi().isLoggedIn();   // <- this will work once the import is correct

    return FutureBuilder<bool>(
      future: future,
      builder: (ctx, snap) {
        if (!snap.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        final loggedIn = snap.data ?? false;
        return loggedIn ? const MainScaffold() : const LoginScreen();
      },
    );
  }
}
