// ignore_for_file: unused_local_variable

import 'package:expanse_tracker_flutter/models/expanse_&_balance_class.dart';
import 'package:expanse_tracker_flutter/res/components/custom_nav_bar.dart';
import 'package:expanse_tracker_flutter/res/components/list_tile_builder.dart';
import 'package:expanse_tracker_flutter/utils/routes/routes_name.dart';
import 'package:expanse_tracker_flutter/widgets/remaining_balance_widget.dart';
import 'package:expanse_tracker_flutter/widgets/text_widget.dart';
import 'package:expanse_tracker_flutter/widgets/total_balance_widget.dart';
import 'package:expanse_tracker_flutter/widgets/total_expenses_widget.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;

    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent.shade400,
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
            //total balance custom widget:
            const Center(child: TotalBalanceWidget()),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Center(child: TotalExpensesWidget()),
                Center(child: RemainingBalanceWidget()),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomText(
                    text: 'Transactions',
                    textSize: 28,
                    textColor: Colors.white,
                    textWeight: FontWeight.w500,
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                            context, RoutesName.expanseListView);
                      },
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      )),
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('expenses')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(
                      color: Colors.black87,
                    );
                  }
                  final expenses = snapshot.data?.docs.map((doc) {
                        final data = doc.data() as Map<String, dynamic>;
                        return Expanses.fromFirestore(doc);
                      }).toList() ??
                      [];
                  return ListTileBuilder(
                    itemCount: 3,
                    expenses: expenses,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
