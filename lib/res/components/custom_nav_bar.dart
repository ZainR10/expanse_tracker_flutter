import 'package:expanse_tracker_flutter/View_Models/expanse_provider.dart';
import 'package:expanse_tracker_flutter/res/components/balance_dialogbox.dart';
import 'package:expanse_tracker_flutter/res/components/dialogbox.dart';
import 'package:expanse_tracker_flutter/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:provider/provider.dart';

class CustomBottomNavBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      index: widget.selectedIndex,
      color: Colors.black,
      backgroundColor: Colors.transparent,
      buttonBackgroundColor: Colors.black87,
      items: const [
        Icon(
          Icons.home_sharp,
          size: 40,
          color: Colors.white,
          shadows: [Shadow(color: Colors.greenAccent, blurRadius: 10)],
        ),
        Icon(
          Icons.pie_chart,
          size: 40,
          color: Colors.white,
          shadows: [Shadow(color: Colors.greenAccent, blurRadius: 10)],
        ),
        Icon(
          Icons.add,
          size: 40,
          color: Colors.white,
          shadows: [Shadow(color: Colors.greenAccent, blurRadius: 10)],
        ),
        Icon(
          Icons.list_alt_sharp,
          size: 40,
          color: Colors.white,
          shadows: [Shadow(color: Colors.greenAccent, blurRadius: 10)],
        ),
        Icon(
          Icons.settings,
          size: 40,
          color: Colors.white,
          shadows: [Shadow(color: Colors.greenAccent, blurRadius: 10)],
        ),
      ],
      onTap: (index) {
        if (index == 2) {
          showModalBottomSheet(
            barrierColor: Colors.transparent,
            backgroundColor: Colors.black,
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
                        shadows: [
                          Shadow(
                            color: Colors.greenAccent,
                            blurRadius: 5,
                          )
                        ],
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
                        showDialog(
                          useSafeArea: true,
                          context: context,
                          builder: (context) => BalanceDialogbox(
                            addBalanceCallback: (newBalance) {
                              Provider.of<ExpensesProvider>(context,
                                      listen: false)
                                  .updateTotalBalance(newBalance);
                            },
                            onSave: () {
                              Navigator.pop(context);
                            },
                            onCancel: () => Navigator.of(context).pop(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        shadows: [
                          Shadow(
                            color: Colors.red,
                            blurRadius: 5,
                          )
                        ],
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
                        showDialog(
                          context: context,
                          builder: (context) => DialogBox(
                            addExpansesCallback: (newExpense) {
                              Provider.of<ExpensesProvider>(context,
                                      listen: false)
                                  .addExpense(newExpense);
                            },
                            onSave: () {
                              Navigator.pop(context);
                            },
                            onCancel: () => Navigator.of(context).pop(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          );
        } else {
          widget.onItemTapped(index);
        }
      },
    );
  }
}
