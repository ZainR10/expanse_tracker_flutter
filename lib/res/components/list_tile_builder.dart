import 'package:flutter/material.dart';
import 'package:expanse_tracker_flutter/View_Models/expanse_&_balance_class.dart';

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
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: widget.expenses.length,
        itemBuilder: (context, index) {
          final expense = widget.expenses[index];
          return Card(
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
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              leading: const Icon(Icons.attach_money_outlined),
              trailing: Text(
                double.tryParse(expense.amount.toString()) != null
                    ? '\$${double.parse(expense.amount.toString()).toStringAsFixed(2)}'
                    : '\$0.00',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
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
          );
        },
      ),
    );
  }
}
