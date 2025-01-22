import 'package:expanse_tracker_flutter/View_Models/balance_expenses_provider.dart';
import 'package:expanse_tracker_flutter/View_Models/currency_provider.dart';
import 'package:expanse_tracker_flutter/res/components/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BalanceListScreen extends StatefulWidget {
  final Widget? widget;
  const BalanceListScreen({
    this.widget,
    super.key,
  });

  @override
  State<BalanceListScreen> createState() => _BalanceListScreenState();
}

class _BalanceListScreenState extends State<BalanceListScreen> {
  @override
  Widget build(BuildContext context) {
    final currencyProvider = Provider.of<CurrencyProvider>(context);
    String selectedCurrency = currencyProvider.selectedCurrency;
    return Consumer<BalanceAndExpensesProvider>(
      builder: (context, provider, value) {
        final balances = provider.balanceHistory;

        if (balances.isEmpty) {
          return const Center(
            child: CustomText(
              text: 'Nothing to show',
              textColor: Colors.black,
              textLetterSpace: 1,
              textSize: 18,
              textWeight: FontWeight.bold,
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(8),
          child: Column(children: [
            if (widget.widget != null) widget.widget!,
            Consumer<BalanceAndExpensesProvider>(
                builder: (context, balanceProvider, child) {
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: balanceProvider.balanceHistory.length,
                itemBuilder: (context, index) {
                  final balance = balances[index];
                  final iconIndex = iconsData
                      .indexWhere((icon) => icon['label'] == balance.icon);
                  return Slidable(
                    startActionPane:
                        ActionPane(motion: const ScrollMotion(), children: [
                      SlidableAction(
                        borderRadius: const BorderRadius.horizontal(
                            right: Radius.circular(10)),
                        onPressed: (context) => provider.deleteBalance(
                            balance.documentId, balance.amount),

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
                          onPressed: (context) => provider.deleteBalance(
                              balance.documentId!, balance.amount),
                          backgroundColor: const Color(0xFFFE4A49),
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        ),
                      ],
                    ),
                    child: Card(
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
                            color: Colors.green,
                            size: 35,
                          ),
                        ),
                        title: CustomText(
                          text:
                              '$selectedCurrency${balance.amount.toStringAsFixed(2)}',
                          textSize: 28,
                          textColor: Colors.black,
                          textWeight: FontWeight.bold,
                        ),
                        subtitle: CustomText(
                          text:
                              'Date: ${DateFormat('yyyy-MM-dd').format(balance.date)}',
                          textSize: 18,
                          textColor: Colors.grey.shade700,
                          textWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ]),
        );
      },
    );
  }

  int _getIconIndex(String iconLabel) {
    for (int i = 0; i < iconsData.length; i++) {
      if (iconsData[i]['label'] == iconLabel) return i;
    }
    return -1; // Default icon index if not found
  }
}

// Same iconsData list from the bottom sheet
final List<Map<String, dynamic>> iconsData = [
  {'icon': Icons.business_center, 'label': 'Salary'},
  {'icon': Icons.add_chart, 'label': 'Investments'},
  {'icon': Icons.laptop_chromebook, 'label': 'Freelancing'},
  {'icon': Icons.business, 'label': 'Business'},
  {'icon': Icons.savings_rounded, 'label': 'Savings'},
  {'icon': Icons.more_horiz, 'label': 'Others'},
];
