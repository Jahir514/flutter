import 'package:flutter/material.dart';
import 'package:personal_budget/core/themes/app_theme.dart';
import 'package:personal_budget/features/auth/screens/login_screen.dart';
import 'package:personal_budget/features/auth/screens/register_screen.dart';
import 'package:personal_budget/features/dashboard/screens/dashboard_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budget Builder',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: '/dashboard',
      routes: {
        '/dashboard': (_) => const DashboardScreen(),
        '/login': (_) => const LoginScreen(),
        '/register': (_) => const RegisterScreen(),
      },
    );
  }
}
