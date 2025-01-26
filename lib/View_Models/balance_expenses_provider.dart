import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expanse_tracker_flutter/models/expense_and_balance_class.dart';
import 'package:flutter/material.dart';

class BalanceAndExpensesProvider with ChangeNotifier {
  double _totalBalance = 0.0;
  List<AddBalance> _balanceHistory = [];
  List<AddExpenses> _expenseHistory = []; // Declare _expenseHistory

  double get totalBalance => _totalBalance;
  List<AddBalance> get balanceHistory => _balanceHistory;
  List<AddExpenses> get expenseHistory => _expenseHistory;
  Future<void> updateBalance(double amount) async {
    try {
      _totalBalance += amount;

      // Update the balance in Firestore
      await FirebaseFirestore.instance
          .collection('balance')
          .doc('total_balance')
          .set({'amount': _totalBalance});

      notifyListeners();
    } catch (e) {
      debugPrint('Error updating balance: $e');
    }
  }

  // Fetch initial data
  Future<void> preloadData() async {
    try {
      // Fetch Total Balance
      final totalDoc = await FirebaseFirestore.instance
          .collection('balance')
          .doc('total_balance')
          .get();

      _totalBalance =
          totalDoc.exists ? (totalDoc.data()?['amount'] ?? 0.0) : 0.0;

      // Fetch Balance History
      final historySnapshot = await FirebaseFirestore.instance
          .collection('balance')
          .orderBy('date', descending: true)
          .get();

      _balanceHistory = historySnapshot.docs
          .map((doc) => AddBalance.fromFirestore(doc))
          .toList();
      final expensesSnapshot = await FirebaseFirestore.instance
          .collection('expenses')
          .orderBy('date', descending: true) // Order expenses by date
          .get();

      _expenseHistory = expensesSnapshot.docs
          .map((doc) => AddExpenses.fromFirestore(doc))
          .toList();
      notifyListeners();
    } catch (e) {
      debugPrint('Error preloading data: $e');
    }
  }

  // Add balance
  Future<void> addBalance(AddBalance newBalance) async {
    try {
      await FirebaseFirestore.instance
          .collection('balance')
          .doc(newBalance.documentId)
          .set(newBalance.toFirestore());

      _totalBalance += newBalance.amount;
      await FirebaseFirestore.instance
          .collection('balance')
          .doc('total_balance')
          .set({'amount': _totalBalance});

      _balanceHistory.insert(0, newBalance);
      notifyListeners();
    } catch (e) {
      debugPrint('Error adding balance: $e');
    }
  }

  // Delete balance
  Future<void> deleteBalance(String documentId, double amount) async {
    try {
      await FirebaseFirestore.instance
          .collection('balance')
          .doc(documentId)
          .delete();

      _totalBalance -= amount;
      await FirebaseFirestore.instance
          .collection('balance')
          .doc('total_balance')
          .set({'amount': _totalBalance});

      _balanceHistory
          .removeWhere((balance) => balance.documentId == documentId);
      notifyListeners();
    } catch (e) {
      debugPrint('Error deleting balance: $e');
    }
  }

  // Add expense
  Future<void> addExpense(AddExpenses expense) async {
    try {
      _expenseHistory.add(expense);
      notifyListeners();

      final totalDoc = FirebaseFirestore.instance
          .collection('expenses')
          .doc('total_expenses');
      final totalSnapshot = await totalDoc.get();
      double totalExpenses =
          totalSnapshot.exists ? totalSnapshot.data()!['amount'] ?? 0.0 : 0.0;
      totalExpenses += expense.amount;

      await totalDoc.set({'amount': totalExpenses});
    } catch (e) {
      debugPrint('Error adding expense: $e');
    }
  }

  // Delete expense
  Future<void> deleteExpense(String documentId, double amount) async {
    try {
      // Remove the expense from the local list
      _expenseHistory
          .removeWhere((expense) => expense.documentId == documentId);
      debugPrint("Updated expense history: $_expenseHistory");

      // Update the total expenses in Firestore
      final totalDoc = FirebaseFirestore.instance
          .collection('expenses')
          .doc('total_expenses');
      final totalSnapshot = await totalDoc.get();
      double totalExpenses =
          totalSnapshot.exists ? totalSnapshot.data()!['amount'] ?? 0.0 : 0.0;
      totalExpenses -= amount;

      await totalDoc.set({'amount': totalExpenses});

      // Add the amount back to the total balance
      _totalBalance += amount;
      await FirebaseFirestore.instance
          .collection('balance')
          .doc('total_balance')
          .set({'amount': _totalBalance});

      // Delete the expense from Firestore
      await FirebaseFirestore.instance
          .collection('expenses')
          .doc(documentId)
          .delete();

      notifyListeners();
    } catch (e) {
      debugPrint('Error deleting expense: $e');
    }
  }

  /// method to calculate expnses data for charts
  Map<String, Map<String, dynamic>> calculateCategoryData() {
    final Map<String, double> categoryTotals = {};
    double totalExpenses = 0.0;

    for (var expense in expenseHistory) {
      categoryTotals[expense.icon] =
          (categoryTotals[expense.icon] ?? 0.0) + expense.amount;
      totalExpenses += expense.amount;
    }

    // Calculate percentage for each category
    return categoryTotals.map((key, value) {
      final percentage = totalExpenses > 0 ? value / totalExpenses : 0.0;
      return MapEntry(
        key,
        {'total': value, 'percentage': percentage},
      );
    });
  }
}
