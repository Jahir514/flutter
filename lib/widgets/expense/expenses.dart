import "package:expense_tracker/widgets/expense/expenses_list.dart";
import "package:expense_tracker/models/expense.dart";
import "package:expense_tracker/widgets/expense/new_expense.dart";
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
      category: Category.leisure,
    ),
    Expense(
      title: 'Shylet Tour',
      amount: 49.99,
      date: DateTime.now(),
      category: Category.travel,
    ),
  ];

  // for opening modal on clicking plus icon
  // IN General context is a full of meta data.
  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context:
          context, // this context hold information about the Expenses Widget and its position in widget tree.
      builder: (ctx) => NewExpense(
        onAddExpnse: _addExpense,
      ), // this ctx(context) hold info about showModalBottomSheet and its position in widget tree.
    );
  }

  // create new expense
  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  // delete expense
  void _closeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    //clear existing snackbar messages
    ScaffoldMessenger.of(context).clearSnackBars();
    //message after delete expense
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Expense deleted'),
        duration: Duration(seconds: 3),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // display content based on expenses
    Widget mainContent = Center(
      child: Text('No Expense available. Please add a new one!!'),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onCloseExpense: _closeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Expense Tracker'),
        actions: [
          IconButton(onPressed: _openAddExpenseOverlay, icon: Icon(Icons.add)),
        ],
      ),
      body: Column(
        children: [
          Text('The chart view'),
          Expanded(child: mainContent),
        ],
      ),
    );
  }
}
