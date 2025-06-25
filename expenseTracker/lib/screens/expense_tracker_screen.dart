import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/expense_entry.dart';
import '../widgets/expense_chart.dart';
import 'package:intl/intl.dart';

class ExpenseTrackerScreen extends StatefulWidget {
  const ExpenseTrackerScreen({Key? key}) : super(key: key);

  @override
  State<ExpenseTrackerScreen> createState() => _ExpenseTrackerScreenState();
}

class _ExpenseTrackerScreenState extends State<ExpenseTrackerScreen> {
  final _amountController = TextEditingController();
  String _selectedType = 'income';
  DateTime _selectedDate = DateTime.now();
  Map<String, List<ExpenseEntry>> _entriesByDate = {};
  String _viewingDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  Future<void> _loadEntries() async {
    final prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString('entries');
    if (data != null) {
      final decoded = json.decode(data) as Map<String, dynamic>;
      final Map<String, List<ExpenseEntry>> loaded = {};
      decoded.forEach((key, value) {
        loaded[key] = (value as List)
            .map((item) => ExpenseEntry.fromJson(item))
            .toList();
      });
      setState(() {
        _entriesByDate = loaded;
      });
    }
  }

  Future<void> _saveEntries() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = _entriesByDate.map((key, value) =>
        MapEntry(key, value.map((e) => e.toJson()).toList()));
    await prefs.setString('entries', json.encode(encoded));
  }

  void _addEntry() {
    final amount = double.tryParse(_amountController.text);
    if (amount == null) return;

    final entry = ExpenseEntry(
      type: _selectedType,
      amount: amount,
      date: _selectedDate,
    );

    final dateKey = DateFormat('yyyy-MM-dd').format(_selectedDate);
    setState(() {
      _entriesByDate.putIfAbsent(dateKey, () => []);
      _entriesByDate[dateKey]!.add(entry);
      _viewingDate = dateKey;
      _amountController.clear();
    });

    _saveEntries();
  }

  double _getTotal(String date, String type) {
    final list = _entriesByDate[date] ?? [];
    return list
        .where((e) => e.type == type)
        .fold(0.0, (sum, e) => sum + e.amount);
  }

  @override
  Widget build(BuildContext context) {
    final income = _getTotal(_viewingDate, 'income');
    final expense = _getTotal(_viewingDate, 'expense');

    return Scaffold(
      appBar: AppBar(title: const Text('Expense Tracker')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Entry Form
            Row(
              children: [
        DropdownButton<String>(
          value: _selectedType,
          items: ['income', 'expense']
              .map((type) => DropdownMenuItem(value: type, child: Text(type)))
              .toList(),
          onChanged: (val) => setState(() {
            _selectedType = val!;
          }),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: TextField(
            controller: _amountController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(labelText: 'Amount'),
          ),
        ),
        const SizedBox(width: 12),
        TextButton(
          onPressed: () async {
            final pickedDate = await showDatePicker(
              context: context,
              initialDate: _selectedDate,
              firstDate: DateTime(2000),
              lastDate: DateTime.now(),
            );
            if (pickedDate != null) {
              setState(() {
                _selectedDate = pickedDate;
              });
            }
          },
          child: Text(DateFormat.yMd().format(_selectedDate)),
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: _addEntry,
        ),



              ],
            ),
            const SizedBox(height: 20),
            // Chart for selected day
            Text(
              'Details for: ${DateFormat.yMMMd().format(DateTime.parse(_viewingDate))}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ExpenseChart(income: income, expense: expense),
            const Divider(height: 32),
            // List of all days
            Expanded(
              child: ListView(
                children: (() {
                  final sortedDates = _entriesByDate.keys.toList();
                  sortedDates.sort((a, b) => b.compareTo(a));
                  return sortedDates.map((date) {
                    final incomeTotal = _getTotal(date, 'income');
                    final expenseTotal = _getTotal(date, 'expense');
                    final net = incomeTotal - expenseTotal;
                    return ListTile(
                      title: Text(DateFormat.yMMMd().format(DateTime.parse(date))),
                      // subtitle: Text('Net: Rs. ${net >= 0 ? '+' : ''}Rs.${net.toStringAsFixed(2)}'),
                      subtitle: Text('Net: ${net >= 0 ? '+' : '-'}\$${net.abs().toStringAsFixed(2)}'),

                      trailing: const Icon(Icons.bar_chart),
                      onTap: () {
                        setState(() {
                          _viewingDate = date;
                        });
                      },
                    );
                  }).toList();
                })(),
              ),

            ),
          ],
        ),
      ),
    );
  }
}
