import 'package:flutter/material.dart';
import 'package:expanse_tracker_flutter/View_Models/expanse_&_balance_class.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:expanse_tracker_flutter/View_Models/expanse_provider.dart';

class ListTileBuilder extends StatefulWidget {
  final List<Expanses> expenses;

  const ListTileBuilder({
    required this.expenses,
    Key? key,
  }) : super(key: key);

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
    return Expanded(
      child: ListView.builder(
        itemCount: widget.expenses.length,
        itemBuilder: (context, index) {
          final expense = widget.expenses[index];
          return Slidable(
            // key: ValueKey(expense.id), // Ensure a unique key for each expense

            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  borderRadius:
                      const BorderRadius.horizontal(left: Radius.circular(10)),
                  onPressed: (context) => _deleteExpense(context, expense),
                  backgroundColor: const Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
              ],
            ),

            child: Card(
              shadowColor: Colors.black,
              color: const Color.fromARGB(255, 255, 250, 248),
              shape: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black87),
                borderRadius: BorderRadius.circular(5),
              ),
              elevation: 8,
              margin: const EdgeInsets.all(8),
              child: ListTile(
                title: Text(
                  expense.title,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500),
                ),
                leading: const Icon(Icons.attach_money_outlined),
                trailing: Text(
                  double.tryParse(expense.amount.toString()) != null
                      ? '\$${double.parse(expense.amount.toString()).toStringAsFixed(2)}'
                      : '\$0.00',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      expense.description.toString(),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w300),
                    ),
                    Text(
                      expense.startDate.toString(),
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
