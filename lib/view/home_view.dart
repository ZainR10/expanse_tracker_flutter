import 'package:expanse_tracker_flutter/res/components/custom_nav_bar.dart';
import 'package:expanse_tracker_flutter/res/components/dialogbox.dart';
import 'package:expanse_tracker_flutter/utils/routes/routes_name.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final auth = FirebaseAuth.instance;
  final TextEditingController _controller = TextEditingController();

  int _selectedIndex = 0;

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
          // Show dialog
          showDialog(
            context: context,
            builder: (context) {
              return DialogBox(
                controller: _controller,
                onSave: () {
                  // Handle save logic
                  Navigator.of(context).pop();
                },
                onCancel: () => Navigator.of(context).pop(),
              );
            },
          );

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
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;

    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   automaticallyImplyLeading: false,
      //   backgroundColor: Colors.transparent,
      //   title: const Text('Home'),
      //   actions: [
      //     IconButton(
      //         onPressed: () {
      //           auth.signOut().then((value) {
      //             Navigator.push(
      //                 context,
      //                 MaterialPageRoute(
      //                     builder: (context) => const LoginView()));
      //           }).onError((error, stackTrace) {
      //             GeneralUtils.snackBar(error.toString(), context);
      //           });
      //         },
      //         icon: const Icon(Icons.settings))
      //   ],
      // ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),

      body: SafeArea(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.all(15),
                // height: height * .40,
                // width: width * 1,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black87),
                //Expanses and Balance
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //total balance
                      const Text(
                        "Total Balance ",
                        style: TextStyle(
                            wordSpacing: 2.5,
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.w300),
                      ),
                      const Text(
                        "Rs 100",
                        style: TextStyle(
                            wordSpacing: 2.5,
                            color: Colors.white,
                            fontSize: 36,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: height * .03,
                      ),
                      //Total expanses
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Expanses ",
                            style: TextStyle(
                                wordSpacing: 2.5,
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w300),
                          ),
                          Text(
                            "Remaining Balance",
                            style: TextStyle(
                                wordSpacing: 2.5,
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Rs 20",
                            style: TextStyle(
                                wordSpacing: 2.5,
                                color: Colors.red,
                                fontSize: 36,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            "Rs 70",
                            style: TextStyle(
                                wordSpacing: 2.5,
                                color: Colors.green,
                                fontSize: 36,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
