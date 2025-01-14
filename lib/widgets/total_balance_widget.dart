// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expanse_tracker_flutter/View_Models/currency_provider.dart';
import 'package:expanse_tracker_flutter/res/components/custom_container.dart';
import 'package:expanse_tracker_flutter/res/components/text_widget.dart';
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

    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 8, left: 8, bottom: 6),
      child: CustomContainer(
        color: Colors.blueGrey.shade200,
        // height: height * 0.2,
        // width: width * 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: 'Total Balance',
                  textColor: Colors.grey.shade800,
                  textLetterSpace: 2,
                  textSize: 28,
                ),
                Icon(
                  Icons.energy_savings_leaf_outlined,
                  color: Colors.greenAccent,
                  size: 35,
                  shadows: [
                    Shadow(
                      blurRadius: 15,
                      color: Colors.greenAccent.shade700,
                    )
                  ],
                )
              ],
            ),

            //totall balance text:
            StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('balances')
                  .doc('main')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return CustomText(text: 'Error: ${snapshot.error}');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SpinKitSpinningLines(
                    color: Colors.blueGrey,
                    size: 45,
                  );
                }
                double totalBalance = 0.0;
                if (snapshot.hasData && snapshot.data!.exists) {
                  final data = snapshot.data!.data() as Map<String, dynamic>;
                  totalBalance = (data['totalBalance'] ?? 0).toDouble();
                }
                //balance amount:
                return CustomText(
                  text: "$selectedCurrency ${totalBalance.toStringAsFixed(0)}",
                  textColor: Colors.black,
                  textLetterSpace: 1,
                  textSize: 35,
                  textWeight: FontWeight.bold,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
