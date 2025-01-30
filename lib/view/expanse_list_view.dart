// ignore_for_file: unused_local_variable

import 'package:expanse_tracker_flutter/main.dart';
import 'package:expanse_tracker_flutter/utils/system_back_button_press.dart';
import 'package:expanse_tracker_flutter/widgets/appbar.dart';
import 'package:expanse_tracker_flutter/widgets/balance_list_widget.dart';
import 'package:expanse_tracker_flutter/widgets/expense_list_screen.dart';
import 'package:expanse_tracker_flutter/widgets/floating_nav_bar_widget.dart';
import 'package:flutter/material.dart';

class ExpanseListView extends StatefulWidget {
  const ExpanseListView({super.key});

  @override
  State<ExpanseListView> createState() => _ExpanseListViewState();
}

class _ExpanseListViewState extends State<ExpanseListView> {
  final int currentIndex = 3;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return SystemBackButtonPress(
      shouldExitApp: true,
      scaffoldMessengerKey: MyApp.scaffoldMessengerKey,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const PreferredSize(
            preferredSize: Size(0, 45),
            child: ReuseableAppBar(
              appBarTitle: 'Balance & Expense List',
            )),
        body: Stack(
          // alignment: Alignment.bottomCenter,
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: height * .04,
                  ),
                  const BalanceListScreen(),
                  const ExpenseListScreen(),
                  SizedBox(
                    height: height * .09,
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: FloatingNavBarWidget(
                pageIndex: currentIndex,
              ),
            )
          ],
        ),
      ),
    );
  }
}
