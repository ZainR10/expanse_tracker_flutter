// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expanse_tracker_flutter/View_Models/currency_provider.dart';
import 'package:expanse_tracker_flutter/View_Models/expanse_provider.dart';
import 'package:expanse_tracker_flutter/res/components/custom_container.dart';
import 'package:expanse_tracker_flutter/res/components/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class RemainingBalanceWidget extends StatefulWidget {
  const RemainingBalanceWidget({super.key});

  @override
  State<RemainingBalanceWidget> createState() => _RemainingBalanceWidgetState();
}

class _RemainingBalanceWidgetState extends State<RemainingBalanceWidget> {
  @override
  Widget build(BuildContext context) {
    final currencyProvider = Provider.of<CurrencyProvider>(context);
    final expensesProvider = Provider.of<ExpensesProvider>(context);
    final remainingBalance = expensesProvider.remainingBalance;

    String selectedCurrency = currencyProvider.selectedCurrency;

    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return Padding(
      padding: const EdgeInsets.only(top: 0, right: 6, left: 6, bottom: 8),
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
                  text: "Remaining Balance",
                  textColor: Colors.grey.shade800,
                  textLetterSpace: 0,
                  textSize: 16,
                  textWeight: FontWeight.w500,
                ),
                const Icon(
                  Icons.account_balance,
                  color: Colors.black,
                  size: 20,
                  shadows: [
                    Shadow(
                      blurRadius: 10,
                      color: Colors.green,
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
                  text:
                      "$selectedCurrency ${remainingBalance.toStringAsFixed(0)}",
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
