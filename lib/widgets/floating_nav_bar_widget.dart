import 'package:expanse_tracker_flutter/components/custom_container.dart';
import 'package:expanse_tracker_flutter/components/nav_bar_items.dart';
import 'package:flutter/material.dart';

class FloatingNavBarWidget extends StatefulWidget {
  final int pageIndex;
  const FloatingNavBarWidget({required this.pageIndex, super.key});

  @override
  _FloatingNavBarWidgetState createState() => _FloatingNavBarWidgetState();
}

class _FloatingNavBarWidgetState extends State<FloatingNavBarWidget> {
  late int _selectedIndex; // Track the selected index

  @override
  void initState() {
    super.initState();
    _selectedIndex =
        widget.pageIndex; // Set initial value from widget.pageIndex
  }
// Track the selected index

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 10, bottom: 10, left: 10),
      child: CustomContainer(
        color: Colors.blueGrey.shade200,
        height: height * .08,
        width: width * 1,
        child: NavBarItems(
          selectedIndex: _selectedIndex,
          onItemTapped: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
