import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expanse_tracker_flutter/models/expense_&_balance_class.dart';

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
    notifyListeners();
    try {
      await _firestore.collection('expenses').add(expense.toFirestore());
      await updateTotalsInFirestore(); // Update totals after adding an expense
    } catch (e) {
      print('Error adding expense: $e');
    }
  }

  void removeExpense(Expanses expense) async {
    _expenses.remove(expense);
    notifyListeners();
    try {
      await _firestore.collection('expenses').doc(expense.id).delete();
      await updateTotalsInFirestore(); // Update totals after removing an expense
    } catch (e) {
      print('Error removing expense: $e');
    }
  }

  void updateTotalBalance(double amount) async {
    _totalBalance = amount;
    await updateTotalsInFirestore(); // Update totals after updating the balance
    notifyListeners();
  }

  Future<void> updateTotalsInFirestore() async {
    double totalExpenses = _expenses.fold(0, (sum, item) => sum + item.amount);
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
        final data = snapshot.data();
        _totalBalance = data?['totalBalance'] ?? 0.0;
        // Note: totalExpenses and remainingBalance are not fetched as they are recalculated
      }
      notifyListeners();
    } catch (e) {
      print('Error fetching balance: $e');
    }
  }
}
