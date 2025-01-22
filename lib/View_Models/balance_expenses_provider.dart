import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expanse_tracker_flutter/models/expense_&_balance_class.dart';
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
      _expenseHistory
          .removeWhere((expense) => expense.documentId == documentId);
      notifyListeners();

      final totalDoc = FirebaseFirestore.instance
          .collection('expenses')
          .doc('total_expenses');
      final totalSnapshot = await totalDoc.get();
      double totalExpenses =
          totalSnapshot.exists ? totalSnapshot.data()!['amount'] ?? 0.0 : 0.0;
      totalExpenses -= amount;

      await totalDoc.set({'amount': totalExpenses});
      await FirebaseFirestore.instance
          .collection('expenses')
          .doc(documentId)
          .delete();
    } catch (e) {
      debugPrint('Error deleting expense: $e');
    }
  }
}
