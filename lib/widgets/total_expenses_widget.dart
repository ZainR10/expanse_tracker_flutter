// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expanse_tracker_flutter/View_Models/currency_provider.dart';
import 'package:expanse_tracker_flutter/res/components/custom_container.dart';
import 'package:expanse_tracker_flutter/res/components/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class TotalExpensesWidget extends StatefulWidget {
  const TotalExpensesWidget({super.key});

  @override
  State<TotalExpensesWidget> createState() => _TotalExpensesWidgetState();
}

class _TotalExpensesWidgetState extends State<TotalExpensesWidget> {
  @override
  Widget build(BuildContext context) {
    final currencyProvider = Provider.of<CurrencyProvider>(context);

    String selectedCurrency = currencyProvider.selectedCurrency;

    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return Padding(
      padding: const EdgeInsets.only(top: 0, bottom: 8, right: 6, left: 6),
      child: CustomContainer(
        height: height * .12,
        width: width * .45,
        color: Colors.blueGrey.shade200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: 'Total Expenses',
                  textColor: Colors.grey.shade800,
                  textLetterSpace: 0,
                  textSize: 18,
                  textWeight: FontWeight.w500,
                ),
                const Icon(
                  Icons.horizontal_rule,
                  color: Colors.redAccent,
                  size: 20,
                  shadows: [
                    Shadow(
                      blurRadius: 10,
                      color: Colors.red,
                    )
                  ],
                )
              ],
            ),

            //totall expenses text:
            StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('expenses').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SpinKitSpinningLines(
                    color: Colors.blueGrey,
                    size: 30,
                  );
                }
                double totalExpenses = 0.0;
                if (snapshot.hasData) {
                  totalExpenses = snapshot.data!.docs.fold(0.0, (sum, doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    return sum + (data['amount'] ?? 0.0).toDouble();
                  });
                }
                return CustomText(
                  text: "$selectedCurrency ${totalExpenses.toStringAsFixed(0)}",
                  textColor: Colors.black,
                  textLetterSpace: 1,
                  textSize: 22,
                  textWeight: FontWeight.w500,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
