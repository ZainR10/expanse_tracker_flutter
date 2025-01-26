import 'package:expanse_tracker_flutter/View_Models/balance_expenses_provider.dart';
import 'package:expanse_tracker_flutter/View_Models/currency_provider.dart';
import 'package:expanse_tracker_flutter/components/text_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PieChartWidget extends StatelessWidget {
  const PieChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final currencyProvider = Provider.of<CurrencyProvider>(context);
    String selectedCurrency = currencyProvider.selectedCurrency;

    return Consumer<BalanceAndExpensesProvider>(
      builder: (context, provider, child) {
        final Map<String, double> categoryTotals = {};
        for (var expense in provider.expenseHistory) {
          categoryTotals[expense.icon] =
              (categoryTotals[expense.icon] ?? 0.0) + expense.amount;
        }
// Check if there is data in categoryTotals
        if (categoryTotals.isEmpty) {
          return const Center(
              child: CustomText(
            text: 'No Data Available',
            textSize: 20,
            textWeight: FontWeight.bold,
          ));
        }
        final List<PieChartSectionData> sections = iconsData.map((data) {
          final label = data['label'];
          final value = categoryTotals[label] ?? 0.0;
          final isLarge =
              value > 0; // Check if the value is large enough to show the title

          return PieChartSectionData(
            value: value,
            color: _getCategoryColor(label),
            radius: 150,
            title: isLarge
                ? '$selectedCurrency${value.toStringAsFixed(0)}'
                : '', // Show title only if value is large enough
            titleStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            badgePositionPercentageOffset: 1,
            badgeWidget: isLarge
                ? _Badge(data['icon'] as IconData,
                    size: 20, color: _getCategoryColor(label))
                : null,
            // badgePosition: BadgePosition.outside,
            borderSide: const BorderSide(color: Colors.white, width: 2),
          );
        }).toList();

        return PieChart(
          PieChartData(
            sectionsSpace: 2,
            centerSpaceRadius: 0,
            borderData: FlBorderData(show: false),
            sections: sections,
          ),
        );
      },
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge(this.icon, {required this.size, required this.color});
  final IconData icon;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black,
            offset: Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.all(size * .3),
      child: Icon(
        icon,
        size: size,
        color: color,
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
      return Colors.yellow;
    case 'Others':
      return Colors.pink;
    default:
      return Colors.black;
  }
}
