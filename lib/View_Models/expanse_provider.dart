import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expanse_tracker_flutter/models/expense_&_balance_class.dart';
import 'package:flutter/material.dart';

class ExpensesProvider with ChangeNotifier {
  List<Expanses> _expenses = [];
  double _totalBalance = 0.0;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Expanses> get expenses => _expenses;
  double get totalBalance => _totalBalance;

  ExpensesProvider() {
    fetchExpenses();
    fetchBalance();
  }

  // Add expense and update balance
  void addExpense(Expanses expense) async {
    _expenses.add(expense);
    notifyListeners();
    try {
      await _firestore.collection('expenses').add(expense.toFirestore());
      await updateTotalsInFirestore();
    } catch (e) {
      print('Error adding expense: $e');
    }
  }

  // Remove expense and update balance
  void removeExpense(Expanses expense) async {
    _expenses.remove(expense);
    notifyListeners();
    try {
      await _firestore.collection('expenses').doc(expense.id).delete();
      await updateTotalsInFirestore();
    } catch (e) {
      print('Error removing expense: $e');
    }
  }

  // Update balance in Firestore
  Future<void> updateTotalsInFirestore() async {
    double totalExpenses =
        _expenses.fold(0.0, (sum, item) => sum + item.amount);
    double remainingBalance = _totalBalance - totalExpenses;
    try {
      await _firestore.collection('balances').doc('main').set({
        'totalBalance': _totalBalance,
        'totalExpenses': totalExpenses,
        'remainingBalance': remainingBalance,
      });
    } catch (e) {
      print('Error updating totals: $e');
    }
  }

  // Fetch expenses from Firestore
  Future<void> fetchExpenses() async {
    try {
      final snapshot = await _firestore.collection('expenses').get();
      _expenses = snapshot.docs.map((doc) {
        return Expanses.fromFirestore(doc);
      }).toList();
      notifyListeners();
    } catch (e) {
      print('Error fetching expenses: $e');
    }
  }

  // Fetch balance from Firestore
  Future<void> fetchBalance() async {
    try {
      final snapshot =
          await _firestore.collection('balances').doc('main').get();
      if (snapshot.exists) {
        final data = snapshot.data();
        _totalBalance = data?['totalBalance'] ?? 0.0;
        // Total expenses and remaining balance will be recalculated
      }
      notifyListeners();
    } catch (e) {
      print('Error fetching balance: $e');
    }
  }

  double get totalExpenses {
    return _expenses.fold(0.0, (sum, item) => sum + item.amount);
  }

  double get remainingBalance {
    return _totalBalance - totalExpenses;
  }
}
