import 'package:expanse_tracker_flutter/View_Models/currency_provider.dart';
import 'package:expanse_tracker_flutter/res/components/custom_nav_bar.dart';
import 'package:expanse_tracker_flutter/res/components/listitle_settings.dart';
import 'package:expanse_tracker_flutter/utils/general_utils.dart';
import 'package:expanse_tracker_flutter/utils/routes/routes_name.dart';
import 'package:expanse_tracker_flutter/widgets/appbar.dart';
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

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade200,
      appBar: const PreferredSize(
        preferredSize: Size(0, 45),
        child: ReuseableAppBar(
          appBarTitle: 'Settings',
        ),
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
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            SizedBox(
              height: height * .03,
            ),
            const Divider(
              color: Colors.white,
              thickness: 1,
            ),
            ListitleSettings(
              ontap: () {
                _showCurrencyDropdown(
                    context, currencyProvider, selectedCurrency);
              },
              icon: Icons.money_sharp,
              iconColor: Colors.black,
              titleText: 'Currencies',
            ),
            const Divider(
              color: Colors.white,
              thickness: 1,
            ),
            ListitleSettings(
              ontap: () {
                auth.signOut().then((value) {
                  Navigator.pushNamed(context, RoutesName.loginView);
                }).onError((error, stackTrace) {
                  GeneralUtils.snackBar(error.toString(), context);
                });
              },
              iconColor: Colors.black,
              icon: Icons.logout_rounded,
              titleText: 'Logout',
            ),
            const Divider(
              color: Colors.white,
              thickness: 1,
            ),
            ListitleSettings(
              ontap: () {},
              icon: Icons.delete_forever,
              iconColor: Colors.red,
              titleText: 'Delete your account',
              color: Colors.red,
            ),
            const Divider(
              color: Colors.white,
              thickness: 1,
            ),
          ],
        ),
      ),
    );
  }

  void _showCurrencyDropdown(BuildContext context,
      CurrencyProvider currencyProvider, String selectedCurrency) {
    showDialog(
      barrierColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          alignment: Alignment.center,
          shape: Border.all(color: Colors.white, width: 2, strokeAlign: 1),
          backgroundColor: Colors.blueGrey.shade200,
          title: const Text('Choose a Currency'),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: _currencies.map((currency) {
              return RadioListTile<String>(
                title: Text(currency),
                value: currency,
                groupValue: currencyProvider.selectedCurrency,
                onChanged: (String? value) {
                  if (value != null) {
                    currencyProvider.selectedCurrency = value;
                    Navigator.pop(context);
                  }
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
