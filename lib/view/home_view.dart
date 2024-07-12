import 'package:expanse_tracker_flutter/View_Models/currency_provider.dart';
import 'package:expanse_tracker_flutter/View_Models/expanse_provider.dart';
import 'package:expanse_tracker_flutter/models/expanse_&_balance_class.dart';
import 'package:expanse_tracker_flutter/res/components/custom_nav_bar.dart';
import 'package:expanse_tracker_flutter/res/components/list_tile_builder.dart';
import 'package:expanse_tracker_flutter/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
        Navigator.pushNamed(context, RoutesName.settingsView);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currencyProvider = Provider.of<CurrencyProvider>(context);
    String _selectedCurrency = currencyProvider.selectedCurrency;
    final expensesProvider = Provider.of<ExpensesProvider>(context);
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
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Container(
                  width: width * 1,
                  // margin: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black87
                            .withOpacity(.9), // Adjust opacity as needed
                        spreadRadius: 4,
                        blurRadius: 20,
                        offset:
                            const Offset(9, 9), // changes position of shadow
                      ),
                    ],
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
                        StreamBuilder<DocumentSnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('balances')
                              .doc('main')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator(
                                color: Colors.white,
                              );
                            }
                            double totalBalance = 0.0;
                            if (snapshot.hasData && snapshot.data!.exists) {
                              final data =
                                  snapshot.data!.data() as Map<String, dynamic>;
                              totalBalance =
                                  (data['totalBalance'] ?? 0).toDouble();
                            }
                            return Text(
                              "$_selectedCurrency ${totalBalance.toStringAsFixed(2)}",
                              style: const TextStyle(
                                wordSpacing: 2.5,
                                color: Colors.white,
                                fontSize: 36,
                                fontWeight: FontWeight.w400,
                              ),
                            );
                          },
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
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              "Remaining Balance",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('expenses')
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                }
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircularProgressIndicator(
                                    color: Colors.white,
                                  );
                                }
                                double totalExpenses = 0.0;
                                if (snapshot.hasData) {
                                  totalExpenses =
                                      snapshot.data!.docs.fold(0.0, (sum, doc) {
                                    final data =
                                        doc.data() as Map<String, dynamic>;
                                    return sum +
                                        (data['amount'] ?? 0.0).toDouble();
                                  });
                                }
                                return Text(
                                  "$_selectedCurrency ${totalExpenses.toStringAsFixed(2)}",
                                  style: const TextStyle(
                                    wordSpacing: 1,
                                    color: Colors.red,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w400,
                                  ),
                                );
                              },
                            ),
                            Text(
                              "$_selectedCurrency ${remainingBalance.toStringAsFixed(2)}",
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
            ),
            SizedBox(
              height: height * 0.04,
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Transactions:',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, RoutesName.expanseListView);
                      },
                      child: const Text(
                        'View all',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
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
                        return Expanses.fromFirestore(
                            doc); // Corrected this line to pass the DocumentSnapshot
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
