import 'dart:ffi';

import 'package:expense_tracker/entities/category.dart';
import 'package:expense_tracker/entities/expense.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense(this.onAddExpense, {super.key});

  final void Function(Expense expense) onAddExpense;

  @override
  State<StatefulWidget> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  DateTime? _selectedDate;
  late Category _selectedCategory = Category.other;

  void _presentDatePicker() async {
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(
            DateTime.now().year - 1, DateTime.now().month, DateTime.now().day),
        lastDate: DateTime.now());

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;

    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      //show error message
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text('Please make sure valid information is entered'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('Okay'))
          ],
        ),
      );
      return;
    } else {
      widget.onAddExpense(
        Expense(
            title: _titleController.text,
            amount: enteredAmount,
            date: _selectedDate!,
            category: _selectedCategory),
      );
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _titleController.dispose();
    super.dispose();
  } // Drops the data collected on the text fields when the overlay is closed

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
          Row(
            children: [
              Expanded(
                //takes as much space as it needs
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixText: '\$',
                    label: Text('Amount'),
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    _selectedDate == null
                        ? 'No Date Selected'
                        : formatter.format(_selectedDate!),
                  ),
                  IconButton(
                      onPressed: () {
                        _presentDatePicker();
                      },
                      icon: const Icon(Icons.calendar_month))
                ],
              ))
            ],
          ),
          Row(
            children: [
              DropdownButton(
                  value: _selectedCategory,
                  items: [
                    ...Category.values.map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(
                          category.name.toUpperCase(),
                        ),
                      ),
                    ),
                  ],
                  onChanged: (v) {
                    setState(() {
                      if (v == null) {
                        return;
                      }
                      _selectedCategory = v;
                    });
                  }),
              const Spacer(),
              ElevatedButton(
                onPressed: _submitExpenseData,
                child: const Text('Save Expense'),
              ),
              // Uses all the space available in between
              TextButton(
                  style: ElevatedButton.styleFrom(foregroundColor: Colors.red),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'))
            ],
          )
        ],
      ),
    );
  }
}
