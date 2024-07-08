import 'package:expanse_tracker_flutter/View_Models/expanse_provider.dart';

import 'package:expanse_tracker_flutter/res/components/custom_nav_bar.dart';

import 'package:expanse_tracker_flutter/res/components/list_tile_builder.dart';
import 'package:expanse_tracker_flutter/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, RoutesName.homeView);
        break;
      case 1:
        Navigator.pushNamed(context, RoutesName.analyticsView);
        break;
      case 2:
        break;
      case 3:
        Navigator.pushNamed(context, RoutesName.expanseListView);
        break;
      case 4:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final expensesProvider = Provider.of<ExpensesProvider>(context);
    final expenses = expensesProvider.expenses;
    final totalExpenses = expensesProvider.totalExpenses;
    final remainingBalance = expensesProvider.remainingBalance;
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: (int index) {
          setState(() {
            _selectedIndex = index;
          });
          _onItemTapped(index);
        },
      ),
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black87,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Text(
                        "Total Balance ",
                        style: TextStyle(
                          wordSpacing: 2.5,
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        "Rs ${expensesProvider.totalBalance.toStringAsFixed(2)}",
                        style: const TextStyle(
                          wordSpacing: 2.5,
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .03,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Expenses ",
                            style: TextStyle(
                              wordSpacing: 2.5,
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Text(
                            "Remaining Balance",
                            style: TextStyle(
                              wordSpacing: 2.5,
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Rs ${totalExpenses.toStringAsFixed(2)}",
                            style: const TextStyle(
                              wordSpacing: 1,
                              color: Colors.red,
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            "Rs ${remainingBalance.toStringAsFixed(2)}",
                            style: const TextStyle(
                              wordSpacing: 1,
                              color: Colors.lightGreen,
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * .02,
            ),
            ListTileBuilder(expenses: expenses)
          ],
        ),
      ),
    );
  }
}
