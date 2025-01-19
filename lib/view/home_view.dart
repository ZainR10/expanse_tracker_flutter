// ignore_for_file: unused_local_variable

import 'package:expanse_tracker_flutter/res/components/custom_nav_bar.dart';
import 'package:expanse_tracker_flutter/utils/routes/routes_name.dart';
import 'package:expanse_tracker_flutter/widgets/appbar.dart';
import 'package:expanse_tracker_flutter/widgets/balance_list_widget.dart';
import 'package:expanse_tracker_flutter/widgets/remaining_balance_widget.dart';
import 'package:expanse_tracker_flutter/widgets/total_balance_widget.dart';
import 'package:expanse_tracker_flutter/widgets/total_expenses_widget.dart';
import 'package:flutter/material.dart';

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
        Navigator.pushNamed(context, RoutesName.settingsView);
        break;
    }
  }

  @override
  // void initState() {
  //   super.initState();
  //   final provider =
  //       Provider.of<BalanceAndExpensesProvider>(context, listen: false);
  //   provider.fetchBalances();
  // }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade200,
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: (int index) {
          setState(() {
            _selectedIndex = index;
          });
          _onItemTapped(index);
        },
      ),
      appBar: const PreferredSize(
          preferredSize: Size(0, 45),
          child: ReuseableAppBar(
            appBarTitle: 'Expense Tracker',
          )),
      body: SafeArea(
        child: Column(
          children: [
            //total balance custom widget:
            const Center(child: TotalBalanceWidget()),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Center(child: TotalExpensesWidget()),
                Center(child: RemainingBalanceWidget()),
              ],
            ),

            Expanded(child: BalanceListScreen())
          ],
        ),
      ),
    );
  }
}
