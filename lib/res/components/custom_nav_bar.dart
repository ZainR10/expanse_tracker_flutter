import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

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
      backgroundColor: Colors.white,
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
      onTap: onItemTapped,
    );
  }
}
