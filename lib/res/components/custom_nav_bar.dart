import 'package:expanse_tracker_flutter/View_Models/expanse_provider.dart';
import 'package:expanse_tracker_flutter/res/components/balance_dialogbox.dart';
import 'package:expanse_tracker_flutter/res/components/dialogbox.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:provider/provider.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      index: selectedIndex,
      color: Colors.black87,
      backgroundColor: Colors.transparent,
      buttonBackgroundColor: Colors.black87,
      items: const [
        Icon(
          Icons.home_sharp,
          size: 40,
          color: Colors.white,
        ),
        Icon(
          Icons.pie_chart,
          size: 40,
          color: Colors.white,
        ),
        Icon(
          Icons.add,
          size: 40,
          color: Colors.white,
        ),
        Icon(
          Icons.transform_outlined,
          size: 40,
          color: Colors.white,
        ),
        Icon(
          Icons.settings,
          size: 40,
          color: Colors.white,
        ),
      ],
      onTap: (index) {
        if (index == 2) {
          showMenu(
            context: context,
            position: RelativeRect.fromLTRB(100, 100, 100, 100),
            items: [
              PopupMenuItem<String>(
                value: 'Balance',
                child: Text('Add Balance'),
              ),
              PopupMenuItem<String>(
                value: 'Expense',
                child: Text('Add Expense'),
              ),
            ],
          ).then((value) {
            if (value != null) {
              if (value == 'Balance') {
                showDialog(
                  context: context,
                  builder: (context) => BalanceDialogbox(
                    addBalanceCallback: (newBalance) {
                      Provider.of<ExpensesProvider>(context, listen: false)
                          .updateTotalBalance(newBalance);
                    },
                    onSave: () {
                      Navigator.pop(context);
                    },
                    onCancel: () => Navigator.of(context).pop(),
                  ),
                );
              } else if (value == 'Expense') {
                showDialog(
                  context: context,
                  builder: (context) => DialogBox(
                    addExpansesCallback: (newExpense) {
                      Provider.of<ExpensesProvider>(context, listen: false)
                          .addExpense(newExpense);
                    },
                    onSave: () {
                      Navigator.pop(context);
                    },
                    onCancel: () => Navigator.of(context).pop(),
                  ),
                );
              }
            }
          });
        } else {
          onItemTapped(index);
        }
      },
    );
  }
}
