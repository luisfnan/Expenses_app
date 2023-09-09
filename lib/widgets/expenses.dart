import 'package:expense_tracker/entities/category.dart';
import 'package:flutter/material.dart';
import '../entities/expense.dart';
import 'expenses_list/expenses_list.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          const Text('data'),
          Expanded(
              child: ExpensesList(
            expensesList: _registerExpenses,
          ))
        ],
      ),
    );
  }
}
