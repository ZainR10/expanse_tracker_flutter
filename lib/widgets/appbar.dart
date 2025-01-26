import 'package:expanse_tracker_flutter/components/text_widget.dart';
import 'package:flutter/material.dart';

class ReuseableAppBar extends StatelessWidget {
  final String appBarTitle;
  const ReuseableAppBar({required this.appBarTitle, super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      backgroundColor: Colors.blueGrey.shade200,
      title: CustomText(
        text: appBarTitle,
        textColor: Colors.black,
        textSize: 28,
        textLetterSpace: 1,
        textWeight: FontWeight.bold,
      ),
    );
  }
}
