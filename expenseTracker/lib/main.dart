import 'package:flutter/material.dart';
import 'screens/expense_tracker_screen.dart';

void main() => runApp(ExpenseApp());

class ExpenseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
    MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        scaffoldBackgroundColor: Color(0xFFE1F5FE), // soft baby blue background
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF81D4FA), // a slightly darker baby blue for app bar
          foregroundColor: Colors.white, // white text/icons on app bar
        ),

      ),
      home: ExpenseTrackerScreen(),
    );

  }
}
