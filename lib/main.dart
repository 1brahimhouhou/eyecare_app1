import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:eyecare_app/theme/colors.dart';
import 'package:eyecare_app/core/push/push_service.dart';
import 'package:eyecare_app/features/shop/data/cart_provider.dart';
import 'package:eyecare_app/shell/main_scaffold.dart';
import 'package:eyecare_app/features/auth/data/auth_api.dart';

import 'package:eyecare_app/features/auth/screens/login_screen.dart';
import 'package:eyecare_app/features/auth/screens/register_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Local-only init
  final cart = CartProvider();
  await cart.load();

  await PushService.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<CartProvider>.value(value: cart),
        Provider<AuthApi>(create: (_) => AuthApi()),
      ],
      child: const EyeCareApp(),
    ),
  );
}

class EyeCareApp extends StatelessWidget {
  const EyeCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EyeCare',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primaryColor: AppColors.primary,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        useMaterial3: true,
      ),

      /// 👇 ROUTES (THIS FIXES YOUR ERROR)
      initialRoute: '/',

      routes: {
        '/': (_) => const LoginScreen(),
        '/login': (_) => const LoginScreen(),
        '/register': (_) => const RegisterScreen(),
        '/home': (_) => const MainScaffold(),
      },
    );
  }
}
