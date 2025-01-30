// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expanse_tracker_flutter/View_Models/currency_provider.dart';
import 'package:expanse_tracker_flutter/components/custom_container.dart';
import 'package:expanse_tracker_flutter/components/text_widget.dart';
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
      padding: const EdgeInsets.only(top: 0, right: 8, left: 8, bottom: 6),
      child: CustomContainer(
        // height: height * .12,
        // width: width * .45,
        color: Colors.grey.shade100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: 'Total Expenses',
                  textColor: Colors.black,
                  textLetterSpace: 0,
                  textSize: 28,
                  textWeight: FontWeight.w500,
                ),
                Icon(
                  Icons.do_not_disturb_on_total_silence_outlined,
                  color: Colors.redAccent,
                  size: 35,
                  shadows: [
                    Shadow(
                      blurRadius: 1,
                      color: Colors.red,
                    )
                  ],
                )
              ],
            ),

            //totall expenses text:
            StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('expenses')
                  .doc('total_expenses')
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

                double totalExpenses = 0.0;
                if (snapshot.hasData && snapshot.data!.exists) {
                  final data = snapshot.data!.data() as Map<String, dynamic>;
                  totalExpenses = data['amount'] ?? 0.0;
                }

                return CustomText(
                  text: '$selectedCurrency${totalExpenses.toStringAsFixed(2)}',
                  textSize: 24,
                  textWeight: FontWeight.w500,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
