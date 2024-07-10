import 'package:flutter/material.dart';

class CurrencyProvider with ChangeNotifier {
  String _selectedCurrency = 'Rs'; // Default currency

  String get selectedCurrency => _selectedCurrency;

  set selectedCurrency(String currency) {
    _selectedCurrency = currency;
    notifyListeners(); // Notify listeners to update widgets
  }
}
