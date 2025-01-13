import 'package:expanse_tracker_flutter/res/components/text_widget.dart';
import 'package:flutter/material.dart';

class ReuseableAppBar extends StatelessWidget {
  const ReuseableAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      backgroundColor: Colors.blueGrey.shade200,
      title: const CustomText(
        text: 'Expanse Tracker',
        textColor: Colors.black,
        textSize: 28,
        textLetterSpace: 1,
        textWeight: FontWeight.bold,
      ),
    );
  }
}
