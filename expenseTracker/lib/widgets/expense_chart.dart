import 'package:flutter/material.dart';

class ExpenseChart extends StatelessWidget {
  final double income;
  final double expense;

  const ExpenseChart({required this.income, required this.expense, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double maxValue = (income > expense ? income : expense).clamp(1, double.infinity);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Income: \$${income.toStringAsFixed(2)}"),
        Container(
          height: 20,
          width: MediaQuery.of(context).size.width * 0.9 * (income / maxValue),
          color: Colors.green,
          margin: const EdgeInsets.only(bottom: 8),
        ),
        Text("Expense: \$${expense.toStringAsFixed(2)}"),
        Container(
          height: 20,
          width: MediaQuery.of(context).size.width * 0.9 * (expense / maxValue),
          color: Colors.red,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
