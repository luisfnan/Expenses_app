import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

import '../../entities/expense.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.onRemove, required this.expensesList});

  final List<Expense> expensesList;
  final void Function(Expense expense) onRemove;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // Creates a scrollable list view
      itemCount: expensesList.length,
      itemBuilder: (ctx, index) => Dismissible(
        //deletes an element by swiping right
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.6),
          margin: EdgeInsets.symmetric(
              horizontal: Theme.of(context).cardTheme.margin!.horizontal,
              vertical: Theme.of(context).cardTheme.margin!.vertical - 5),
        ),
        onDismissed: (direction) {
          onRemove(expensesList[index]);
        },
        key: Key(expensesList[index].id),
        child: ExpenseItem(
          expensesList[index],
        ),
      ),
    );
  }
}
