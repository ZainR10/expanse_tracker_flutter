import 'package:flutter/material.dart';

class ChartTypeProvider with ChangeNotifier {
  String _selectedChartType = 'Expenses vs Balance';

  String get selectedChartType => _selectedChartType;

  void setSelectedChartType(String chartType) {
    _selectedChartType = chartType;
    notifyListeners();
  }
}
