import 'package:expanse_tracker_flutter/View_Models/currency_provider.dart';
import 'package:expanse_tracker_flutter/res/components/custom_nav_bar.dart';
import 'package:expanse_tracker_flutter/utils/general_utils.dart';
import 'package:expanse_tracker_flutter/utils/routes/routes_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  int _selectedIndex = 4;
  final List<String> _currencies = ['₨', '\$', '€', '£'];

  @override
  void initState() {
    super.initState();
    _loadCurrency();
  }

  Future<void> _loadCurrency() async {
    // You can load initial currency if needed
  }

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
    String selectedCurrency = currencyProvider.selectedCurrency;
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
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
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
            const Text(
              'Choose Currency',
              style: TextStyle(
                  fontSize: 20, letterSpacing: 3, fontWeight: FontWeight.w600),
            ),
            SizedBox(
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
                    child: Center(
                      child: DropdownButton<String>(
                        value: selectedCurrency,
                        onChanged: (String? newValue) {
                          currencyProvider.selectedCurrency = newValue!;
                        },
                        items: _currencies
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
