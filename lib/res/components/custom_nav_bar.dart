import 'package:expanse_tracker_flutter/widgets/add_balance_bottom_sheet.dart';
import 'package:expanse_tracker_flutter/widgets/expense_bottom_sheet_widget.dart';
import 'package:expanse_tracker_flutter/res/components/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

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
      color: Colors.blueGrey.shade300,
      backgroundColor: Colors.transparent,
      buttonBackgroundColor: Colors.blueGrey,
      items: const [
        Icon(
          Icons.home_sharp,
          size: 40,
          color: Colors.black,
          // shadows: [Shadow(color: Colors.greenAccent, blurRadius: 10)],
        ),
        Icon(
          Icons.pie_chart,
          size: 40,
          color: Colors.black,
          // shadows: [Shadow(color: Colors.greenAccent, blurRadius: 10)],
        ),
        Icon(
          Icons.add,
          size: 40,
          color: Colors.black,
          // shadows: [Shadow(color: Colors.greenAccent, blurRadius: 10)],
        ),
        Icon(
          Icons.list_alt_sharp,
          size: 40,
          color: Colors.black,
          // shadows: [Shadow(color: Colors.greenAccent, blurRadius: 10)],
        ),
        Icon(
          Icons.settings,
          size: 40,
          color: Colors.black,
          // shadows: [Shadow(color: Colors.greenAccent, blurRadius: 10)],
        ),
      ],
      onTap: (index) {
        if (index == 2) {
          showModalBottomSheet(
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
                          addBalanceBottomSheet(context);
                        }),
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
                        expenseBottomSheet(context);
                        // // showDialog(
                        // //   context: context,
                        // //   builder: (context) => DialogBox(
                        // //     addExpansesCallback: (newExpense) {
                        // //       Provider.of<ExpensesProvider>(context,
                        // //               listen: false)
                        // //           .addExpense(newExpense);
                        // //     },
                        // //     onSave: () {
                        // //       Navigator.pop(context);
                        // //     },
                        // //     onCancel: () => Navigator.of(context).pop(),
                        // //   ),
                        // );
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
