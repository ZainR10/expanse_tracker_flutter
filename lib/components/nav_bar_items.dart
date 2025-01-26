import 'package:expanse_tracker_flutter/components/text_widget.dart';
import 'package:expanse_tracker_flutter/utils/routes/routes_name.dart';
import 'package:expanse_tracker_flutter/widgets/add_balance_bottom_sheet.dart';
import 'package:expanse_tracker_flutter/widgets/add_expense_bottom_sheet_widget.dart';
import 'package:flutter/material.dart';

class NavBarItems extends StatelessWidget {
  final int selectedIndex; // Selected index to highlight the icon
  final Function(int) onItemTapped; // Callback for item tap

  const NavBarItems({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: () {
            onItemTapped(0); // Set index to 0 for Home
            Navigator.pushNamed(context, RoutesName.homeView);
          },
          child: Icon(
            Icons.home,
            size: 40,
            shadows: [
              Shadow(
                blurRadius: 20,
                color: selectedIndex == 0 ? Colors.black : Colors.transparent,
              )
            ],
            color: selectedIndex == 0
                ? Colors.white
                : Colors.black, // Change color
          ),
        ),
        InkWell(
          onTap: () {
            onItemTapped(1); // Set index to 1 for Analytics
            Navigator.pushNamed(context, RoutesName.analyticsView);
          },
          child: Icon(
            Icons.pie_chart,
            size: 40,
            shadows: [
              Shadow(
                blurRadius: 20,
                color: selectedIndex == 1
                    ? Colors.black
                    : Colors.transparent, // Change color
              )
            ],
            color: selectedIndex == 1
                ? Colors.white
                : Colors.black, // Change color
          ),
        ),
        InkWell(
          onTap: () => showModalBottomSheet(
            barrierColor: Colors.transparent,
            backgroundColor: Colors.blueGrey,
            useSafeArea: true,
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                        leading: const Icon(
                          Icons.account_balance,
                          color: Colors.green,
                          size: 35,
                        ),
                        title: const CustomText(
                          text: 'Add Balance',
                          textColor: Colors.white,
                          textSize: 28,
                          textLetterSpace: 1,
                          textWeight: FontWeight.w300,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          addBalanceBottomSheet(context);
                        }),
                    ListTile(
                      leading: const Icon(
                        Icons.money_off,
                        size: 35,
                        color: Colors.red,
                      ),
                      title: const CustomText(
                        text: 'Add Expense',
                        textColor: Colors.white,
                        textSize: 28,
                        textLetterSpace: 1,
                        textWeight: FontWeight.w300,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        expenseBottomSheet(context);
                      },
                    ),
                  ],
                ),
              );
            },
          ),
          child: Icon(
            Icons.add,
            size: 40,
            color:
                selectedIndex == 2 ? Colors.blue : Colors.black, // Change color
          ),
        ),
        InkWell(
          onTap: () {
            onItemTapped(3); // Set index to 3 for Expense List
            Navigator.pushNamed(context, RoutesName.expanseListView);
          },
          child: Icon(
            Icons.list_alt_outlined,
            size: 40,
            shadows: [
              Shadow(
                blurRadius: 20,
                color: selectedIndex == 3
                    ? Colors.black
                    : Colors.transparent, // Change color
              )
            ],
            color: selectedIndex == 3
                ? Colors.white
                : Colors.black, // Change color
          ),
        ),
        InkWell(
          onTap: () {
            onItemTapped(4); // Set index to 4 for Settings
            Navigator.pushNamed(context, RoutesName.settingsView);
          },
          child: Icon(
            Icons.settings,
            size: 40,
            shadows: [
              Shadow(
                blurRadius: 20,
                color: selectedIndex == 4
                    ? Colors.black
                    : Colors.transparent, // Change color
              )
            ],
            color: selectedIndex == 4
                ? Colors.white
                : Colors.black, // Change color
          ),
        ),
      ],
    );
  }
}
