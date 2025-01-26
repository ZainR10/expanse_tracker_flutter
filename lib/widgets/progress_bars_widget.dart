import 'package:expanse_tracker_flutter/components/progress_bar_component.dart';
import 'package:flutter/material.dart';
import 'package:expanse_tracker_flutter/View_Models/balance_expenses_provider.dart';
import 'package:provider/provider.dart';

class ProgressBarsWidget extends StatelessWidget {
  const ProgressBarsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BalanceAndExpensesProvider>(
      builder: (context, provider, child) {
        // Calculate total expenses
        final totalExpenses = provider.expenseHistory.fold<double>(
          0.0,
          (sum, item) => sum + item.amount,
        );

        // Calculate progress for each category
        final progressData = iconsData.map((data) {
          final category = data['label'];
          final categoryTotal = provider.expenseHistory
              .where((expense) => expense.icon == category)
              .fold<double>(0.0, (sum, expense) => sum + expense.amount);

          final percentage =
              totalExpenses > 0 ? categoryTotal / totalExpenses : 0.0;
          return {
            'title': category,
            'percentage': percentage,
            'color': _getCategoryColor(category),
          };
        }).toList();

        return Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: progressData.map((data) {
              return ProgressBar(
                title: data['title'],
                percentage: data['percentage'],
                color: data['color'],
              );
            }).toList(),
          ),
        );
      },
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
