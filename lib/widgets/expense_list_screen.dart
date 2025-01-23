import 'package:expanse_tracker_flutter/View_Models/balance_expenses_provider.dart';
import 'package:expanse_tracker_flutter/View_Models/currency_provider.dart';
import 'package:expanse_tracker_flutter/res/components/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ExpenseListScreen extends StatefulWidget {
  const ExpenseListScreen({super.key});

  @override
  State<ExpenseListScreen> createState() => _ExpenseListScreenState();
}

class _ExpenseListScreenState extends State<ExpenseListScreen> {
  @override
  Widget build(BuildContext context) {
    final currencyProvider = Provider.of<CurrencyProvider>(context);
    String selectedCurrency = currencyProvider.selectedCurrency;

    return Consumer<BalanceAndExpensesProvider>(
      builder: (context, provider, value) {
        final expenses = provider.expenseHistory;

        if (expenses.isEmpty) {
          return const Center(
            child: CustomText(
              text: 'No expenses to show',
              textColor: Colors.black,
              textLetterSpace: 1,
              textSize: 18,
              textWeight: FontWeight.bold,
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.only(top: 0, bottom: 5, right: 8, left: 8),
          child: Consumer<BalanceAndExpensesProvider>(
              builder: (context, provider, child) {
            debugPrint("Expenses in provider: $expenses.length");
            return Column(
              children: [
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: provider.expenseHistory.length,
                  itemBuilder: (context, index) {
                    final expense = expenses[index];
                    final iconIndex = iconsData
                        .indexWhere((icon) => icon['label'] == expense.icon);

                    return Slidable(
                      startActionPane:
                          ActionPane(motion: const ScrollMotion(), children: [
                        SlidableAction(
                          borderRadius: const BorderRadius.horizontal(
                              right: Radius.circular(10)),
                          onPressed: (context) => provider.deleteExpense(
                              expense.documentId, expense.amount),

                          // onPressed: (context) =>
                          //     _deleteExpense(context, expense),
                          backgroundColor: const Color(0xFFFE4A49),
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        ),
                      ]),
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        dragDismissible: true,
                        children: [
                          SlidableAction(
                            borderRadius: const BorderRadius.horizontal(
                                left: Radius.circular(10)),
                            onPressed: (context) => provider.deleteExpense(
                                expense.documentId, expense.amount),
                            backgroundColor: const Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                        ],
                      ),
                      child: Card(
                        key: ValueKey(expense.documentId),
                        color: Colors.blueGrey.shade100,
                        shape: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 3),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListTile(
                          horizontalTitleGap: 50,
                          leading: CircleAvatar(
                            backgroundColor: Colors.blueGrey.shade100,
                            child: Icon(
                              iconsData[iconIndex]['icon'],
                              color: Colors.red,
                              size: 35,
                            ),
                          ),
                          title: CustomText(
                            text: expense.title,
                            textSize: 28,
                            textColor: Colors.black,
                            textWeight: FontWeight.bold,
                          ),
                          subtitle: CustomText(
                            text:
                                'Date: ${DateFormat('yyyy-MM-dd').format(expense.date)}',
                            textSize: 15,
                            textColor: Colors.grey.shade700,
                            textWeight: FontWeight.bold,
                          ),
                          trailing: CustomText(
                            // title: CustomText(
                            text:
                                '$selectedCurrency${expense.amount.toStringAsFixed(2)}',
                            textSize: 22,
                            textWeight: FontWeight.bold,
                            textColor: Colors.black,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          }),
        );
      },
    );
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
