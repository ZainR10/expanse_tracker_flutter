import 'package:expanse_tracker_flutter/View_Models/authentication_view_models/user_info_provider.dart';
import 'package:expanse_tracker_flutter/View_Models/currency_provider.dart';
import 'package:expanse_tracker_flutter/components/listitle_settings.dart';
import 'package:expanse_tracker_flutter/components/text_widget.dart';
import 'package:expanse_tracker_flutter/main.dart';
import 'package:expanse_tracker_flutter/utils/general_utils.dart';
import 'package:expanse_tracker_flutter/utils/routes/routes_name.dart';
import 'package:expanse_tracker_flutter/utils/system_back_button_press.dart';
import 'package:expanse_tracker_flutter/widgets/appbar.dart';
import 'package:expanse_tracker_flutter/widgets/floating_nav_bar_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    Provider.of<UserProvider>(context, listen: false).fetchUserData();
  }

  final int currentIndex = 4;

  final List<String> _currencies = ['₨', '\$', '€', '£'];

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    final currencyProvider = Provider.of<CurrencyProvider>(context);

    final auth = FirebaseAuth.instance;
    final height = MediaQuery.of(context).size.height * 1;

    return SystemBackButtonPress(
      shouldExitApp: true,
      scaffoldMessengerKey: MyApp.scaffoldMessengerKey,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const PreferredSize(
          preferredSize: Size(0, 45),
          child: ReuseableAppBar(
            appBarTitle: 'Settings',
          ),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  // PROFILE PIC
                  CircleAvatar(
                    backgroundColor: Colors.grey.shade300,
                    radius: 65,
                    backgroundImage: userProvider.profilePic.isNotEmpty
                        ? NetworkImage(userProvider.profilePic)
                        : null, // Load image if available
                    child: userProvider.profilePic.isEmpty
                        ? Text(
                            userProvider.name.isNotEmpty
                                ? userProvider.name[0].toUpperCase()
                                : '?', // Show first letter of name
                            style: const TextStyle(
                                fontSize: 40, color: Colors.black),
                          )
                        : null,
                  ),
                  const SizedBox(height: 10),
                  //USER NAME
                  CustomText(
                    text: userProvider.name.isNotEmpty
                        ? userProvider.name
                        : 'User',
                    textLetterSpace: 1,
                    textSize: 28,
                    textWeight: FontWeight.w500,
                  ),
                  const SizedBox(height: 5),
                  //USER EMAIL
                  CustomText(
                    text: userProvider.email.isNotEmpty
                        ? userProvider.email
                        : 'No email',
                    textLetterSpace: 1,
                    textSize: 18,
                    textWeight: FontWeight.normal,
                  ),
                  SizedBox(
                    height: height * .01,
                  ),
                  const Divider(
                    color: Colors.black,
                    thickness: 1,
                  ),
                  ExpansionTile(
                    leading: const Icon(
                      Icons.monetization_on,
                      color: Colors.black,
                      size: 30,
                    ),
                    title: const Text(
                      'Currencies',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    trailing: AnimatedRotation(
                      turns: isExpanded ? 0.5 : 0, // 180 degrees rotation
                      duration: const Duration(milliseconds: 300),
                      child: const Icon(Icons.keyboard_arrow_down,
                          color: Colors.black),
                    ),
                    onExpansionChanged: (bool expanded) {
                      setState(() {
                        isExpanded = expanded;
                      });
                    },
                    children: _currencies.map((currency) {
                      return RadioListTile<String>(
                        title: Text(currency),
                        value: currency,
                        groupValue: currencyProvider.selectedCurrency,
                        onChanged: (String? value) {
                          if (value != null) {
                            currencyProvider.selectedCurrency = value;
                            setState(() {});
                          }
                        },
                      );
                    }).toList(),
                  ),
                  //LOG OUT
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
                  //DELETE ACCOUNT
                  ListitleSettings(
                    ontap: () {},
                    icon: Icons.delete_forever,
                    iconColor: Colors.red,
                    titleText: 'Delete account',
                    color: Colors.red,
                  ),
                ],
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: FloatingNavBarWidget(pageIndex: currentIndex))
          ],
        ),
      ),
    );
  }
}
