// ignore_for_file: unused_local_variable
import 'package:expanse_tracker_flutter/View_Models/balance_expenses_provider.dart';
import 'package:expanse_tracker_flutter/res/components/custom_container.dart';
import 'package:expanse_tracker_flutter/res/components/custom_nav_bar.dart';
import 'package:expanse_tracker_flutter/res/components/text_widget.dart';
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
            Navigator.pushNamed(context, RoutesName.homeView);
            break;
          case 1:
            Navigator.pushNamed(context, RoutesName.analyticsView);
            break;
          case 2:
            break;
          case 3:
            Navigator.pushNamed(context, RoutesName.expanseListView);
            break;
          case 4:
            Navigator.pushNamed(context, RoutesName.settingsView);
            break;
        }
      });
    }

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

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
        ),
      ),
      body: Column(
        children: [
          const TotalExpensesWidget(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Wrap(
              spacing: 12,
              runSpacing: 8,
              alignment: WrapAlignment.start,
              children: iconsData.map((data) {
                return CustomContainer(
                  height: height * .06,
                  width: width * .28, // Adjusted to fit better
                  color: _getCategoryColor(data['label']),
                  child: Center(
                    child: CustomText(
                      text: data['label'],
                      textWeight: FontWeight.bold,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: height * .03),
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
                    radius: 80, // Adjusted for better scaling
                    title: value > 0 ? value.toStringAsFixed(2) : '',
                    titleStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    borderSide: const BorderSide(color: Colors.white, width: 2),
                  );
                }).toList();

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PieChart(
                    PieChartData(
                      centerSpaceRadius: 40,
                      borderData: FlBorderData(show: false),
                      sections: sections,
                      sectionsSpace: 2,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

final List<Map<String, dynamic>> iconsData = [
  {'icon': Icons.directions_bus, 'label': 'Transport'},
  {'icon': Icons.shopping_cart, 'label': 'Grocery'},
  {'icon': Icons.fastfood, 'label': 'Food'},
  {'icon': Icons.local_hospital, 'label': 'Health'},
  {'icon': Icons.house, 'label': 'Rent'},
  {'icon': Icons.school, 'label': 'Education'},
  {'icon': Icons.more_horiz, 'label': 'Others'},
];

Color _getCategoryColor(String category) {
  switch (category) {
    case 'Transport':
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
