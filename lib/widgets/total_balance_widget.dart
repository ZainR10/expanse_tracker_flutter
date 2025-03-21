// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expanse_tracker_flutter/View_Models/balance_expenses_provider.dart';
import 'package:expanse_tracker_flutter/View_Models/currency_provider.dart';
import 'package:expanse_tracker_flutter/components/custom_container.dart';
import 'package:expanse_tracker_flutter/components/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class TotalBalanceWidget extends StatefulWidget {
  const TotalBalanceWidget({super.key});

  @override
  State<TotalBalanceWidget> createState() => _TotalBalanceWidgetState();
}

class _TotalBalanceWidgetState extends State<TotalBalanceWidget> {
  @override
  Widget build(BuildContext context) {
    final currencyProvider = Provider.of<CurrencyProvider>(context);
    String selectedCurrency = currencyProvider.selectedCurrency;
    final balanceAndExpensesProvider =
        Provider.of<BalanceAndExpensesProvider>(context);
    double totalBalance0 = balanceAndExpensesProvider.totalBalance;

    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;

    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 8, left: 8, bottom: 6),
      child: CustomContainer(
        color: Colors.grey.shade100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomText(
                  text: 'Total Balance',
                  textColor: Colors.black,
                  textLetterSpace: 2,
                  textSize: 28,
                  textWeight: FontWeight.w500,
                ),
                Icon(
                  Icons.account_balance,
                  color: Colors.greenAccent.shade200,
                  size: 35,
                  shadows: [
                    Shadow(
                      blurRadius: 2,
                      color: Colors.greenAccent.shade700,
                    )
                  ],
                ),
              ],
            ),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('balance')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SpinKitSpinningLines(
                      color: Colors.blueGrey,
                      size: 45,
                    );
                  }

                  // Calculate total balance
                  double totalBalance = 0.0;
                  if (snapshot.hasData) {
                    final documents = snapshot.data!.docs;
                    for (var doc in documents) {
                      final data = doc.data() as Map<String, dynamic>;
                      if (data['type'] == 'total') {
                        // Ensure we calculate only for "total balance" entries
                        totalBalance += data['amount'] ?? 0.0;
                      }
                    }
                  }

                  return Consumer<BalanceAndExpensesProvider>(
                    builder: (context, child, value) {
                      return CustomText(
                        text:
                            '$selectedCurrency${balanceAndExpensesProvider.totalBalance.toStringAsFixed(2)}',
                        textColor: Colors.black,
                        textSize: 24,
                        textWeight: FontWeight.w500,
                      );
                    },
                  );
                }),
          ],
        ),
      ),
    );
  }
}
