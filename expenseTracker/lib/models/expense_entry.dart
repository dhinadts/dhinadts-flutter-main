class ExpenseEntry {
  final String type; // 'income' or 'expense'
  final double amount;
  final DateTime date;

  ExpenseEntry({
    required this.type,
    required this.amount,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'amount': amount,
      'date': date.toIso8601String(),
    };
  }

  factory ExpenseEntry.fromJson(Map<String, dynamic> json) {
    return ExpenseEntry(
      type: json['type'],
      amount: json['amount'],
      date: DateTime.parse(json['date']),
    );
  }
}
