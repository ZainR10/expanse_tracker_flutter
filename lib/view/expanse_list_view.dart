import 'package:expanse_tracker_flutter/res/components/custom_nav_bar.dart';
import 'package:expanse_tracker_flutter/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';

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

          break;
      }
      // Add your navigation logic here
      // For example, you can use a switch statement to navigate to different screens
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Export data'),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        onItemTapped: _onItemTapped,
        selectedIndex: _selectedIndex,
      ),
    );
  }
}
