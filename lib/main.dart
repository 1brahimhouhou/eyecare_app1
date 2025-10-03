import 'package:flutter/material.dart';
import 'package:code_eyecare/theme/colors.dart';
import 'package:code_eyecare/shell/main_scaffold.dart';
import 'package:code_eyecare/features/auth/screens/login_screen.dart';
import 'package:code_eyecare/features/auth/screens/register_screen.dart';

void main() => runApp(const BabiVisionApp());

class BabiVisionApp extends StatelessWidget {
  const BabiVisionApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
      scaffoldBackgroundColor: Colors.white,
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
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
      initialRoute: '/login',
      routes: {
        '/login': (_) => const LoginScreen(),
        '/register': (_) => const RegisterScreen(),
        '/main': (_) => const MainScaffold(),
      },
    );
  }
}
