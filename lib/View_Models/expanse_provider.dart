import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expanse_tracker_flutter/models/expanse_&_balance_class.dart';

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

  void addExpense(Expanses expense) async {
    _expenses.add(expense);
    _totalBalance -= expense.amount;
    notifyListeners();
    try {
      await _firestore.collection('expenses').add(expense.toFirestore());
      await updateTotalBalanceInFirestore();
    } catch (e) {
      print('Error adding expense: $e');
    }
  }

  void removeExpense(Expanses expense) async {
    _expenses.remove(expense);
    notifyListeners();
    try {
      await _firestore.collection('expenses').doc(expense.id).delete();
      await updateTotalBalanceInFirestore();
    } catch (e) {
      print('Error removing expense: $e');
    }
  }

  void updateTotalBalance(double amount) async {
    _totalBalance += amount;
    notifyListeners();
    await updateTotalBalanceInFirestore();
  }

  Future<void> updateTotalBalanceInFirestore() async {
    try {
      await _firestore.collection('balances').doc('main').set({
        'totalBalance': _totalBalance,
      });
    } catch (e) {
      print('Error updating balance: $e');
    }
  }

  double get totalExpenses {
    return _expenses.fold(0, (sum, item) => sum + item.amount);
  }

  double get remainingBalance {
    return _totalBalance - totalExpenses;
  }

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

  Future<void> fetchBalance() async {
    try {
      final snapshot =
          await _firestore.collection('balances').doc('main').get();
      if (snapshot.exists) {
        _totalBalance = snapshot.data()?['totalBalance'] ?? 0.0;
      }
      notifyListeners();
    } catch (e) {
      print('Error fetching balance: $e');
    }
  }
}
