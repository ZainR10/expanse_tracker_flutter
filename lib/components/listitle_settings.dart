import 'package:expanse_tracker_flutter/components/text_widget.dart';
import 'package:flutter/material.dart';

class ListitleSettings extends StatelessWidget {
  final String titleText;
  final IconData? icon;
  final Color? color;
  final Color? iconColor;
  final VoidCallback? ontap;
  const ListitleSettings(
      {this.color,
      this.iconColor,
      required this.titleText,
      required this.icon,
      this.ontap,
      super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: ListTile(
        leading: Icon(
          icon,
          size: 30,
          color: iconColor,
        ),
        title: CustomText(
          text: titleText,
          textWeight: FontWeight.w500,
          textSize: 20,
          textLetterSpace: 1,
          textColor: color,
        ),
      ),
    );
  }
}
