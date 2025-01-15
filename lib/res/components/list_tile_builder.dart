import 'package:expanse_tracker_flutter/View_Models/currency_provider.dart';
import 'package:expanse_tracker_flutter/res/components/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:expanse_tracker_flutter/models/expense_&_balance_class.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:expanse_tracker_flutter/View_Models/expanse_provider.dart';

class ListTileBuilder extends StatefulWidget {
  final List<Expanses> expenses;
  final int itemCount;
  final Widget? widget;

  const ListTileBuilder({
    this.widget,
    required this.itemCount,
    required this.expenses,
    super.key,
  });

  @override
  State<ListTileBuilder> createState() => _ListTileBuilderState();
}

class _ListTileBuilderState extends State<ListTileBuilder> {
  void _deleteExpense(BuildContext context, Expanses expense) {
    Provider.of<ExpensesProvider>(context, listen: false)
        .removeExpense(expense);
    Provider.of<ExpensesProvider>(context, listen: false)
        .updateTotalBalance(expense.amount);
  }

  @override
  Widget build(BuildContext context) {
    final currencyProvider = Provider.of<CurrencyProvider>(context);
    String selectedCurrency = currencyProvider.selectedCurrency;
    return widget.expenses.isEmpty
        ? const Center(
            child: CustomText(
            text: 'Nothing to show',
            textColor: Colors.black,
            textLetterSpace: 1,
            textSize: 18,
            textWeight: FontWeight.bold,
          ))
        : SingleChildScrollView(
            child: Column(
              children: [
                if (widget.widget != null) widget.widget!,
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.itemCount <= widget.expenses.length
                      ? widget.itemCount
                      : widget.expenses.length,

                  // itemCount: widget.expenses.length,
                  itemBuilder: (context, index) {
                    final expense = widget.expenses[index];
                    return Slidable(
                      // key: ValueKey(expense.id), // Ensure a unique key for each expense

                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            borderRadius: const BorderRadius.horizontal(
                                left: Radius.circular(10)),
                            onPressed: (context) =>
                                _deleteExpense(context, expense),
                            backgroundColor: const Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                        ],
                      ),

                      child: Padding(
                        padding: const EdgeInsets.only(
                            bottom: 2, top: 0, left: 8, right: 8),
                        child: Card(
                          // shadowColor: Colors.black,
                          // color: Colors.blueGrey.shade200,
                          color: Colors.blueGrey.shade100,
                          shape: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.blueGrey.shade50, width: 2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(10),
                            leading: const Icon(
                              Icons.local_hospital_rounded,
                              color: Colors.black,
                              size: 50,
                            ),
                            title: CustomText(
                              text: expense.title,
                              textColor: Colors.black,
                              textLetterSpace: 1,
                              textSize: 24,
                              textWeight: FontWeight.w500,
                            ),
                            trailing: CustomText(
                              text: double.tryParse(
                                          expense.amount.toString()) !=
                                      null
                                  ? '$selectedCurrency${double.parse(expense.amount.toString()).toStringAsFixed(0)}'
                                  : '\$0.0',
                              textColor: Colors.black,
                              textLetterSpace: 1,
                              textSize: 24,
                              textWeight: FontWeight.w500,
                            ),
                            subtitle: CustomText(
                              text: expense.startDate.toString(),
                              textColor: Colors.grey.shade800,
                              textSize: 16,
                              textWeight: FontWeight.bold,
                            ),
                            // Column(
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   children: [
                            //     CustomText(
                            //       text: expense.description.toString(),
                            //       textColor: Colors.white,
                            //       textLetterSpace: 2,
                            //       textSize: 18,
                            //       textWeight: FontWeight.normal,
                            //     ),
                            //     CustomText(
                            //       text: expense.startDate.toString(),
                            //       textColor: Colors.white,
                            //       textSize: 14,
                            //       textWeight: FontWeight.normal,
                            //     ),
                            //   ],
                            // ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
  }
}
