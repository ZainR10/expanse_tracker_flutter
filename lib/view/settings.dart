import 'package:expanse_tracker_flutter/res/components/custom_nav_bar.dart';
import 'package:expanse_tracker_flutter/utils/general_utils.dart';
import 'package:expanse_tracker_flutter/utils/routes/routes_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  int _selectedIndex = 4;

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
    final auth = FirebaseAuth.instance;
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: const Text('Settings'),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: (int index) {
          setState(() {
            _selectedIndex = index;
          });
          _onItemTapped(index);
        },
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: width * 1,
              height: height * .10,
              child: InkWell(
                onTap: () {
                  auth.signOut().then((value) {
                    Navigator.pushNamed(context, RoutesName.loginView);
                  }).onError((error, stackTrace) {
                    GeneralUtils.snackBar(error.toString(), context);
                  });
                },
                child: Card(
                  shadowColor: Colors.red,
                  color: Colors.red[600],
                  // color: const Color.fromARGB(255, 255, 250, 248),
                  shape: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black87),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  elevation: 8,
                  margin: const EdgeInsets.all(8),
                  child: const Center(
                      child: Text(
                    'Log out',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 2),
                  )),
                ),
              ),
            ),
            SizedBox(
              height: height * .03,
            ),
            Container(
              width: width * 1,
              height: height * .10,
              child: InkWell(
                onTap: () {},
                child: Card(
                  shadowColor: Colors.green,
                  color: Colors.lightGreen[400],
                  // color: const Color.fromARGB(255, 255, 250, 248),
                  shape: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black87),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  elevation: 8,
                  margin: const EdgeInsets.all(8),
                  child: const Center(
                      child: Text(
                    'Export Data to Excel Sheets',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 2),
                  )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
