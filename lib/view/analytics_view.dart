// ignore_for_file: unused_local_variable
import 'package:expanse_tracker_flutter/res/components/custom_nav_bar.dart';
import 'package:expanse_tracker_flutter/utils/routes/routes_name.dart';
import 'package:expanse_tracker_flutter/widgets/appbar.dart';
import 'package:expanse_tracker_flutter/widgets/pie_chart_widget.dart';
import 'package:expanse_tracker_flutter/widgets/progress_bars_widget.dart';
import 'package:expanse_tracker_flutter/widgets/total_expenses_widget.dart';
import 'package:flutter/material.dart';

class AnalyticsView extends StatefulWidget {
  const AnalyticsView({super.key});

  @override
  State<AnalyticsView> createState() => _AnalyticsViewState();
}

class _AnalyticsViewState extends State<AnalyticsView> {
  bool showPieChart = true;

  @override
  Widget build(BuildContext context) {
    int selectedIndex = 1;

    void onItemTapped(int index) {
      setState(() {
        selectedIndex = index;
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
      });
    }

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade200,
      bottomNavigationBar: CustomBottomNavBar(
        onItemTapped: onItemTapped,
        selectedIndex: selectedIndex,
      ),
      appBar: const PreferredSize(
        preferredSize: Size(0, 45),
        child: ReuseableAppBar(
          appBarTitle: 'Expense Analytics',
        ),
      ),
      body: Column(
        children: [
          const TotalExpensesWidget(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  side: BorderSide(
                      color: showPieChart ? Colors.black : Colors.transparent,
                      width: 2),
                  backgroundColor: showPieChart ? Colors.white : Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    showPieChart = true;
                  });
                },
                child: const Text('Pie Chart'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  side: BorderSide(
                      color: showPieChart ? Colors.transparent : Colors.black,
                      width: 2),
                  backgroundColor: !showPieChart ? Colors.white : Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    showPieChart = false;
                  });
                },
                child: const Text('Progress Bars'),
              ),
            ],
          ),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: showPieChart
                  ? const PieChartWidget(key: ValueKey('PieChart'))
                  : const ProgressBarsWidget(key: ValueKey('ProgressBars')),
            ),
          ),
        ],
      ),
    );
  }
}
