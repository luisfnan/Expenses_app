import 'package:expense_tracker/entities/category.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:flutter/material.dart';
import '../entities/expense.dart';
import 'expenses_list/expenses_list.dart';
import 'new_expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registerExpenses = [
    Expense(
        title: 'gas',
        amount: 2300,
        date: DateTime.now(),
        category: Category.car),
    Expense(
        title: 'supermercado',
        amount: 1200,
        date: DateTime.now(),
        category: Category.food),
  ];

  _openExpensesOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => NewExpense(_addExpense),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registerExpenses.insert(0, expense);
    });
  }

  void _removeExpenses(Expense expense) {
    final idx = _registerExpenses.indexOf(expense);
    setState(() {
      _registerExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        action: SnackBarAction(
          textColor: Colors.blue,
            label: 'Udo',
            onPressed: () {
              setState(() {
                _registerExpenses.insert(idx, expense);
              });
            }),
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
              style: IconButton.styleFrom(foregroundColor: Colors.white),
              onPressed: _openExpensesOverlay,
              icon: const Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          Chart(expenses: _registerExpenses),
          Container(
            margin: const EdgeInsets.all(15),
            child: const Text(
              'Main expenses',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: _registerExpenses.isNotEmpty
                ? ExpensesList(
                    expensesList: _registerExpenses,
                    onRemove: _removeExpenses,
                  )
                : const Center(
                    child: Text(
                        'No expenses found. Use the plus button to add a new one!'),
                  ),
          ),
        ],
      ),
    );
  }
}
