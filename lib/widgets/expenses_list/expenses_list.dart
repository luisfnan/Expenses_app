import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

import '../../entities/expense.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key, required this.expensesList});

  final List<Expense> expensesList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expensesList.length,
        itemBuilder: (ctx, index) => ExpenseItem(expensesList[index]));
  }
}
