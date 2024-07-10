import 'package:expanse_tracker_flutter/View_Models/expanse_provider.dart';
import 'package:expanse_tracker_flutter/res/components/custom_nav_bar.dart';
import 'package:expanse_tracker_flutter/res/components/list_tile_builder.dart';
import 'package:expanse_tracker_flutter/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpanseListView extends StatefulWidget {
  const ExpanseListView({super.key});

  @override
  State<ExpanseListView> createState() => _ExpanseListViewState();
}

class _ExpanseListViewState extends State<ExpanseListView> {
  int _selectedIndex = 3;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          // Navigate to Home Screen
          Navigator.pushNamed(context, RoutesName.homeView);
          break;
        case 1:
          // Navigate to Analytics Screen
          Navigator.pushNamed(context, RoutesName.analyticsView);

          break;
        case 2:
          // Navigate to Add Screen

          break;
        case 3:
          // Navigate to Expanse list Screen
          Navigator.pushNamed(context, RoutesName.expanseListView);

          break;
        case 4:
          // Navigate to Settings Screen
          Navigator.pushNamed(context, RoutesName.settingsView);

          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final expensesProvider = Provider.of<ExpensesProvider>(context);
    final expenses = expensesProvider.expenses;
    final totalExpenses = expensesProvider.totalExpenses;
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: const Text('Expanses list'),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        onItemTapped: _onItemTapped,
        selectedIndex: _selectedIndex,
      ),
      body: Column(
        children: [
          ListTileBuilder(itemCount: expenses.length, expenses: expenses)
        ],
      ),
    );
  }
}
