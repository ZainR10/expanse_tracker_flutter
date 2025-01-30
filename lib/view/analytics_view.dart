// ignore_for_file: unused_local_variable
import 'package:expanse_tracker_flutter/main.dart';
import 'package:expanse_tracker_flutter/utils/system_back_button_press.dart';
import 'package:expanse_tracker_flutter/widgets/appbar.dart';
import 'package:expanse_tracker_flutter/widgets/floating_nav_bar_widget.dart';
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
  final int currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SystemBackButtonPress(
      shouldExitApp: true,
      scaffoldMessengerKey: MyApp.scaffoldMessengerKey,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const PreferredSize(
          preferredSize: Size(0, 45),
          child: ReuseableAppBar(
            appBarTitle: 'Expense Analytics',
          ),
        ),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                const TotalExpensesWidget(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(
                            color: showPieChart
                                ? Colors.black
                                : Colors.transparent,
                            width: 2),
                        backgroundColor:
                            showPieChart ? Colors.white : Colors.grey,
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
                            color: showPieChart
                                ? Colors.transparent
                                : Colors.black,
                            width: 2),
                        backgroundColor:
                            !showPieChart ? Colors.white : Colors.grey,
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
                        : const ProgressBarsWidget(
                            key: ValueKey('ProgressBars')),
                  ),
                ),
              ],
            ),
            FloatingNavBarWidget(
              pageIndex: currentIndex,
            ),
          ],
        ),
      ),
    );
  }
}
