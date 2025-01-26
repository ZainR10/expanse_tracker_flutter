// ignore_for_file: unused_local_variable

import 'package:expanse_tracker_flutter/components/text_widget.dart';
import 'package:expanse_tracker_flutter/main.dart';
import 'package:expanse_tracker_flutter/utils/routes/routes_name.dart';
import 'package:expanse_tracker_flutter/utils/system_back_button_press.dart';
import 'package:expanse_tracker_flutter/widgets/appbar.dart';
import 'package:expanse_tracker_flutter/widgets/balance_list_widget.dart';
import 'package:expanse_tracker_flutter/widgets/expense_list_screen.dart';
import 'package:expanse_tracker_flutter/widgets/floating_nav_bar_widget.dart';
import 'package:expanse_tracker_flutter/widgets/total_balance_widget.dart';
import 'package:expanse_tracker_flutter/widgets/total_expenses_widget.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;

    return SystemBackButtonPress(
      shouldExitApp: false,
      scaffoldMessengerKey: MyApp.scaffoldMessengerKey,
      child: Scaffold(
        backgroundColor: Colors.blueGrey.shade200,
        appBar: const PreferredSize(
            preferredSize: Size(0, 45),
            child: ReuseableAppBar(
              appBarTitle: 'Expense Tracker',
            )),
        body: Stack(
          // alignment: Alignment.bottomCenter,
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  //total balance custom widget:
                  const Center(child: TotalBalanceWidget()),
                  const Center(child: TotalExpensesWidget()),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CustomText(
                              text: 'Transactions',
                              textSize: 28,
                              textColor: Colors.black,
                              textWeight: FontWeight.w500,
                            ),
                            InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, RoutesName.expanseListView);
                                },
                                child: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black,
                                )),
                          ],
                        ),
                      ),
                      const BalanceListScreen(),
                      const ExpenseListScreen(),
                    ],
                  ),
                  SizedBox(
                    height: height * .09,
                  )
                ],
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: FloatingNavBarWidget(pageIndex: currentIndex))
          ],
        ),
      ),
    );
  }
}
