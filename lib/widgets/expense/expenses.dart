import "package:expense_tracker/widgets/expense/expenses_list.dart";
import "package:expense_tracker/models/expense.dart";
import "package:flutter/material.dart";

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter Course',
      amount: 29.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Dart Course',
      amount: 39.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Pizza',
      amount: 9.99,
      date: DateTime.now(),
      category: Category.food,
    ),
    Expense(
      title: 'Borbad Movie Ticket',
      amount: 5.99,
      date: DateTime.now(),
      category: Category.entertainment,
    ),
    Expense(
      title: 'Shylet Tour',
      amount: 49.99,
      date: DateTime.now(),
      category: Category.travel,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.add))],
      ),
      body: Column(
        children: [
          Text('The chart view'),
          Expanded(child: ExpensesList(expenses: _registeredExpenses)),
        ],
      ),
    );
  }
}
