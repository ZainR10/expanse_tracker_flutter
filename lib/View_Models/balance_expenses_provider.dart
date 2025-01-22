import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expanse_tracker_flutter/models/expense_&_balance_class.dart';
import 'package:flutter/material.dart';

class BalanceAndExpensesProvider with ChangeNotifier {
  double _totalBalance = 0.0;
  List<AddBalance> _balanceHistory = [];

  double get totalBalance => _totalBalance;
  List<AddBalance> get balanceHistory => _balanceHistory;

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
      // Update Firestore
      await FirebaseFirestore.instance
          .collection('balance')
          .doc(newBalance.documentId)
          .set(newBalance.toFirestore());

      // Update total balance
      _totalBalance += newBalance.amount;
      await FirebaseFirestore.instance
          .collection('balance')
          .doc('total_balance')
          .set({'amount': _totalBalance});

      // Update local state
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

      // Update total balance
      _totalBalance -= amount;
      await FirebaseFirestore.instance
          .collection('balance')
          .doc('total_balance')
          .set({'amount': _totalBalance});

      // Update local state
      _balanceHistory
          .removeWhere((balance) => balance.documentId == documentId);
      notifyListeners();
    } catch (e) {
      debugPrint('Error deleting balance: $e');
    }
  }
}
