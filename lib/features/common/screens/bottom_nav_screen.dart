import 'package:flutter/material.dart';
import 'package:personal_budget/features/dashboard/screens/dashboard_screen.dart';
import 'package:personal_budget/features/income/screens/income_screen.dart';
// import 'package:personal_budget/features/expense/screens/expense_screen.dart';
// import 'package:personal_budget/features/budget/screens/budget_screen.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    DashboardScreen(),
    IncomeScreen(),
    // ExpenseScreen(),
    // BudgetScreen(),
  ];

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTap,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money_outlined),
            label: 'Income',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money_off_csred_outlined),
            label: 'Expense',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_outlined),
            label: 'Budget',
          ),
        ],
      ),
    );
  }
}
