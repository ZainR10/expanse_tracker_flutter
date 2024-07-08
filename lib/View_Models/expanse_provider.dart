import 'package:flutter/material.dart';
import 'package:expanse_tracker_flutter/View_Models/expanse_&_balance_class.dart';

class ExpensesProvider with ChangeNotifier {
  double _totalBalance = 0.0;
  double get totalBalance => _totalBalance;

  double _totalExpenses = 0.0;
  double get totalExpenses => _totalExpenses;

  double get remainingBalance => _totalBalance - _totalExpenses;

  List<Expanses> _expenses = [];

  List<Expanses> get expenses => _expenses;

  void addExpense(Expanses expense) {
    _expenses.add(expense);
    _totalExpenses += double.tryParse(expense.amount.toString()) ?? 0.0;
    // Assuming amount is a String that needs to be parsed
    notifyListeners();
  }

  void updateTotalBalance(double balance) {
    _totalBalance += balance;
    notifyListeners();
  }
}
