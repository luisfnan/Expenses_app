import 'dart:math';

import 'package:expense_tracker/entities/category.dart';
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
  void _addExpense(Expense expense){
    setState(() {
      _registerExpenses.insert(0, expense);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
              onPressed: _openExpensesOverlay, icon: const Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          const Text('Main expenses'),
          Expanded(
              child: ExpensesList(
            expensesList: _registerExpenses,
          ))
        ],
      ),
    );
  }
}
