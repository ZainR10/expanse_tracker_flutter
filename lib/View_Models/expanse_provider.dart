import 'package:flutter/foundation.dart';
import 'package:expanse_tracker_flutter/View_Models/expanse_&_balance_class.dart';

class ExpensesProvider with ChangeNotifier {
  List<Expanses> _expenses = [];
  double _totalBalance = 0.0;

  List<Expanses> get expenses => _expenses;
  double get totalBalance => _totalBalance;

  void addExpense(Expanses expense) {
    _expenses.add(expense);
    _totalBalance -= expense.amount;
    notifyListeners();
  }

  void removeExpense(Expanses expense) {
    _expenses.remove(expense);
    notifyListeners();
  }

  void updateTotalBalance(double amount) {
    _totalBalance += amount;
    notifyListeners();
  }

  double get totalExpenses {
    return _expenses.fold(0, (sum, item) => sum + item.amount);
  }

  double get remainingBalance {
    return _totalBalance - totalExpenses;
  }
}
