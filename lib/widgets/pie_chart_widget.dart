import 'package:expanse_tracker_flutter/View_Models/balance_expenses_provider.dart';
import 'package:expanse_tracker_flutter/View_Models/currency_provider.dart';
import 'package:expanse_tracker_flutter/res/components/custom_container.dart';
import 'package:expanse_tracker_flutter/res/components/text_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PieChartWidget extends StatelessWidget {
  const PieChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final currencyProvider = Provider.of<CurrencyProvider>(context);
    String selectedCurrency = currencyProvider.selectedCurrency;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
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
              final List<PieChartSectionData> sections = iconsData.map((data) {
                final label = data['label'];
                final value = categoryTotals[label] ?? 0.0;

                return PieChartSectionData(
                  value: value,
                  color: _getCategoryColor(label),
                  radius: 65, // Adjusted for better scaling
                  title: value > 0
                      ? '$selectedCurrency${value.toStringAsFixed(2)}'
                      : '',

                  titleStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  borderSide: const BorderSide(color: Colors.white, width: 2),
                );
              }).toList();

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: PieChart(
                  PieChartData(
                    titleSunbeamLayout: true,
                    centerSpaceRadius: 55,
                    borderData: FlBorderData(show: false),
                    sections: sections,
                    sectionsSpace: 3,
                  ),
                ),
              );
            },
          ),
        ),
      ],
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
      return Colors.teal;
    case 'Grocery':
      return Colors.green;
    case 'Food':
      return Colors.red;
    case 'Health':
      return Colors.lightBlueAccent.shade200;
    case 'Rent':
      return Colors.brown;
    case 'Education':
      return Colors.blue.shade600;
    case 'Others':
      return Colors.blueGrey;
    default:
      return Colors.black;
  }
}
