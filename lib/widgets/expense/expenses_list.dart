import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expense/single_expense.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onCloseExpense,
  });
  final List<Expense> expenses;
  final void Function(Expense expense) onCloseExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        onDismissed: (direction) {
          onCloseExpense(expenses[index]);
        },
        key: ValueKey(expenses[index]),
        child: SingleExpense(expense: expenses[index]),
      ),
    );
  }
}
