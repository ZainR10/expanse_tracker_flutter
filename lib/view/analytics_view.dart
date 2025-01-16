import 'package:expanse_tracker_flutter/res/components/custom_nav_bar.dart';
import 'package:expanse_tracker_flutter/utils/routes/routes_name.dart';
import 'package:expanse_tracker_flutter/widgets/appbar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AnalyticsView extends StatefulWidget {
  const AnalyticsView({super.key});

  @override
  State<AnalyticsView> createState() => _AnalyticsViewState();
}

class _AnalyticsViewState extends State<AnalyticsView> {
  @override
  Widget build(BuildContext context) {
    int selectedIndex = 1;

    void onItemTapped(int index) {
      setState(() {
        selectedIndex = index;
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
            Navigator.pushNamed(context, RoutesName.settingsView);
            break;
        }
      });
    }

    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
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
            )),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: PieChart(PieChartData(
                  centerSpaceRadius: 25,
                  borderData: FlBorderData(show: false),
                  sections: [
                    PieChartSectionData(
                      value: 35,
                      borderSide: const BorderSide(
                        color: Colors.white,
                        width: 2,
                      ),
                      color: Colors.purple,
                      radius: 100,
                      titleStyle: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    PieChartSectionData(
                        value: 40,
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 2,
                        ),
                        color: Colors.amber,
                        radius: 100,
                        titleStyle: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        )),
                    PieChartSectionData(
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 2,
                        ),
                        value: 55,
                        color: Colors.green,
                        radius: 100,
                        titleStyle: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        )),
                    PieChartSectionData(
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 2,
                        ),
                        value: 70,
                        color: Colors.orange,
                        radius: 100,
                        titleStyle: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        )),
                  ])),
            ),
          ],
        ));
  }
}
