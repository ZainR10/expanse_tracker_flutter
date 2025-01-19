import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expanse_tracker_flutter/models/expense_&_balance_class.dart';
import 'package:flutter/material.dart';

class BalanceAndExpensesProvider with ChangeNotifier {
  double _totalBalance = 0.0;
  List<AddBalance> _balanceHistory = [];

  double get totalBalance => _totalBalance;
  List<AddBalance> get balanceHistory => _balanceHistory;

  /// Fetch initial data on app restart
  Future<void> preloadData() async {
    try {
      // Fetch Total Balance
      final totalBalanceDoc = await FirebaseFirestore.instance
          .collection('balance')
          .doc('total_balance')
          .get();

      if (totalBalanceDoc.exists) {
        _totalBalance = totalBalanceDoc.data()?['amount'] ?? 0.0;
      }

      // Fetch Balance History
      final historySnapshot = await FirebaseFirestore.instance
          .collection('balance')
          .where('type', isEqualTo: 'history') // Filter history documents
          .get();

      _balanceHistory = historySnapshot.docs.map((doc) {
        return AddBalance.fromFirestore(doc.data());
      }).toList();

      notifyListeners();
    } catch (error) {
      debugPrint('Error preloading data: $error');
    }
  }

  /// Add balance: update total balance and add a history record
  Future<void> addBalance(AddBalance balance) async {
    try {
      // Update Total Balance Document
      final totalBalanceDoc =
          FirebaseFirestore.instance.collection('balance').doc('total_balance');
      final totalBalanceData = await totalBalanceDoc.get();

      if (totalBalanceData.exists) {
        final currentTotal = totalBalanceData.data()?['amount'] ?? 0.0;
        await totalBalanceDoc.update({
          'amount': currentTotal + balance.amount,
        });
        _totalBalance = currentTotal + balance.amount;
      } else {
        await totalBalanceDoc.set({'amount': balance.amount});
        _totalBalance = balance.amount;
      }

      // Add Balance History Document
      final historyDoc = FirebaseFirestore.instance.collection('balance').doc();
      await historyDoc.set({
        'type': 'history', // Add a field to identify history records
        ...balance.toFirestore(),
      });

      // Update Local Data
      _balanceHistory.add(balance);
      notifyListeners();
    } catch (error) {
      debugPrint('Error adding balance: $error');
    }
  }
}
