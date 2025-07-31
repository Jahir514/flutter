import 'package:flutter/material.dart';
import 'package:personal_budget/core/themes/color_palette.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Budget'),
        backgroundColor: AppColors.primary,
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/login'),
            icon: const Icon(Icons.login),
            tooltip: 'Login',
          ),
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/register'),
            icon: const Icon(Icons.app_registration),
            tooltip: 'Register',
          ),
        ],
      ),
      body: const Center(child: Text("Welcome to Budget Tracker")),
    );
  }
}
