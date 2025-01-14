import 'package:expanse_tracker_flutter/View_Models/chart_provider.dart';
import 'package:expanse_tracker_flutter/View_Models/expanse_provider.dart';

import 'package:expanse_tracker_flutter/models/expense_&_balance_class.dart';
import 'package:expanse_tracker_flutter/res/components/custom_nav_bar.dart';
import 'package:expanse_tracker_flutter/utils/routes/routes_name.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpensePieChart extends StatefulWidget {
  const ExpensePieChart({super.key});

  @override
  State<ExpensePieChart> createState() => _ExpensePieChartState();
}

class _ExpensePieChartState extends State<ExpensePieChart> {
  @override
  Widget build(BuildContext context) {
    int selectedIndex = 1;
    final expensesProvider = Provider.of<ExpensesProvider>(context);
    final chartTypeProvider = Provider.of<ChartTypeProvider>(context);
    final totalBalance = expensesProvider.totalBalance;
    final totalExpenses = expensesProvider.totalExpenses;
    final remainingBalance = totalBalance - totalExpenses;
    final mostCostlyCategory =
        _getMostCostlyCategory(expensesProvider.expenses);

    void onItemTapped(int index) {
      setState(() {
        selectedIndex = index;
        switch (index) {
          case 0:
            // Navigate to Home Screen
            Navigator.pushNamed(context, RoutesName.homeView);
            break;
          case 1:
            // Navigate to Analytics Screen
            Navigator.pushNamed(context, RoutesName.analyticsView);
            break;
          case 2:
            // Navigate to Add Screen
            break;
          case 3:
            // Navigate to Expanse list Screen
            Navigator.pushNamed(context, RoutesName.expanseListView);
            break;
          case 4:
            Navigator.pushNamed(context, RoutesName.settingsView);
            break;
        }
      });
    }

    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
      bottomNavigationBar: CustomBottomNavBar(
        onItemTapped: onItemTapped,
        selectedIndex: selectedIndex,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Expense Analysis',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: height * .02),
            DropdownButton<String>(
              value: chartTypeProvider.selectedChartType,
              onChanged: (String? newValue) {
                chartTypeProvider.setSelectedChartType(newValue!);
              },
              items: <String>['Expenses vs Balance', 'Categories']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: _buildChart(
                    chartTypeProvider.selectedChartType,
                    totalBalance,
                    totalExpenses,
                    remainingBalance,
                    expensesProvider.expenses),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                'Most Costly Category: $mostCostlyCategory',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChart(String chartType, double totalBalance,
      double totalExpenses, double remainingBalance, List<Expanses> expenses) {
    switch (chartType) {
      case 'Categories':
        return Stack(
          alignment: Alignment.center,
          children: [
            PieChart(
              PieChartData(
                sections: _showingCategorySections(expenses),
                centerSpaceRadius: 60,
                centerSpaceColor: Colors.white,
                sectionsSpace: 0,
                pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {}),
              ),
            ),
          ],
        );
      case 'Expenses vs Balance':
      default:
        return Stack(
          alignment: Alignment.center,
          children: [
            PieChart(
              PieChartData(
                sections: _showingSections(totalExpenses, remainingBalance),
                centerSpaceRadius: 60,
                centerSpaceColor: Colors.white,
                sectionsSpace: 0,
                pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {}),
              ),
            ),
            Text(
              '${(remainingBalance / totalBalance * 100).toStringAsFixed(1)}%',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
    }
  }

  List<PieChartSectionData> _showingSections(double expenses, double balance) {
    return [
      PieChartSectionData(
        color: Colors.green,
        value: balance,
        title: '${(balance / (balance + expenses) * 100).toStringAsFixed(1)}%',
        radius: 50,
        titleStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      PieChartSectionData(
        color: Colors.red,
        value: expenses,
        title: '${(expenses / (balance + expenses) * 100).toStringAsFixed(1)}%',
        radius: 50,
        titleStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    ];
  }

  List<PieChartSectionData> _showingCategorySections(List<Expanses> expenses) {
    Map<String, double> categoryTotals = {};

    for (var expense in expenses) {
      if (categoryTotals.containsKey(expense.description)) {
        categoryTotals[expense.description] =
            categoryTotals[expense.description]! + expense.amount;
      } else {
        categoryTotals[expense.description] = expense.amount;
      }
    }

    List<PieChartSectionData> sections = [];
    categoryTotals.forEach((category, amount) {
      sections.add(
        PieChartSectionData(
          color: Colors.primaries[sections.length % Colors.primaries.length],
          value: amount,
          title: category,
          radius: 50,
          titleStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      );
    });

    return sections;
  }

  String _getMostCostlyCategory(List<Expanses> expenses) {
    Map<String, double> categoryTotals = {};

    for (var expense in expenses) {
      if (categoryTotals.containsKey(expense.description)) {
        categoryTotals[expense.description] =
            categoryTotals[expense.description]! + expense.amount;
      } else {
        categoryTotals[expense.description] = expense.amount;
      }
    }

    String mostCostlyCategory = '';
    double highestAmount = 0.0;

    categoryTotals.forEach((category, amount) {
      if (amount > highestAmount) {
        mostCostlyCategory = category;
        highestAmount = amount;
      }
    });

    return mostCostlyCategory;
  }
}
