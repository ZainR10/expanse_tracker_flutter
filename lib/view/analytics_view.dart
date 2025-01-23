// ignore_for_file: unused_local_variable

import 'package:expanse_tracker_flutter/View_Models/balance_expenses_provider.dart';
import 'package:expanse_tracker_flutter/res/components/custom_nav_bar.dart';
import 'package:expanse_tracker_flutter/utils/routes/routes_name.dart';
import 'package:expanse_tracker_flutter/widgets/appbar.dart';
import 'package:expanse_tracker_flutter/widgets/total_expenses_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnalyticsView extends StatefulWidget {
  const AnalyticsView({super.key});

  @override
  State<AnalyticsView> createState() => _AnalyticsViewState();
}

class _AnalyticsViewState extends State<AnalyticsView> {
  @override
  Widget build(BuildContext context) {
    int selectedIndex = 1;

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
        backgroundColor: Colors.blueGrey.shade200,
        bottomNavigationBar: CustomBottomNavBar(
          onItemTapped: onItemTapped,
          selectedIndex: selectedIndex,
        ),
        appBar: const PreferredSize(
            preferredSize: Size(0, 45),
            child: ReuseableAppBar(
              appBarTitle: 'Expense Analytics',
            )),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TotalExpensesWidget(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 10.0),
              child: Wrap(
                spacing: 10,
                children: iconsData.map((data) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                          color: _getCategoryColor(data['label']),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        data['label'],
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
            Expanded(
              child: Consumer<BalanceAndExpensesProvider>(
                builder: (context, provider, child) {
                  // Aggregate data for chart
                  final Map<String, double> categoryTotals = {};
                  for (var expense in provider.expenseHistory) {
                    categoryTotals[expense.icon] =
                        (categoryTotals[expense.icon] ?? 0.0) + expense.amount;
                  }

                  // Create PieChartSectionData for each category
                  final List<PieChartSectionData> sections =
                      iconsData.map((data) {
                    final label = data['label'];
                    final value = categoryTotals[label] ?? 0.0;

                    return PieChartSectionData(
                      value: value,
                      color: _getCategoryColor(label),
                      radius: 100,
                      title: value > 0 ? value.toStringAsFixed(2) : '0',
                      titleStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 2),
                    );
                  }).toList();

                  return PieChart(
                    PieChartData(
                      centerSpaceRadius: 25,
                      borderData: FlBorderData(show: false),
                      sections: sections,
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }
}

final List<Map<String, dynamic>> iconsData = [
  {'icon': Icons.directions_bus, 'label': 'Transportation'},
  {'icon': Icons.shopping_cart, 'label': 'Grocery'},
  {'icon': Icons.fastfood, 'label': 'Food'},
  {'icon': Icons.local_hospital, 'label': 'Health'},
  {'icon': Icons.house, 'label': 'Rent'},
  {'icon': Icons.school, 'label': 'Education'},
  {'icon': Icons.more_horiz, 'label': 'Others'},
];
Color _getCategoryColor(String category) {
  switch (category) {
    case 'Transportation':
      return Colors.purple;
    case 'Grocery':
      return Colors.amber;
    case 'Food':
      return Colors.green;
    case 'Health':
      return Colors.red;
    case 'Rent':
      return Colors.blue;
    case 'Education':
      return Colors.orange;
    case 'Others':
      return Colors.grey;
    default:
      return Colors.black;
  }
}
