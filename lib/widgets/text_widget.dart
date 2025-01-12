import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? textSize;
  final FontWeight? textWeight;
  final Color? textColor;
  final double? textLetterSpace;
  final int? textMaxLines;
  final TextOverflow? textOverflow;
  final List<Shadow>? textShadow;

  const CustomText(
      {this.textSize,
      this.textShadow,
      this.textOverflow,
      this.textLetterSpace,
      this.textWeight,
      this.textColor,
      this.textMaxLines,
      required this.text,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: textMaxLines,
      style: TextStyle(
          overflow: textOverflow,
          letterSpacing: textLetterSpace,
          color: textColor,
          fontSize: textSize,
          fontWeight: textWeight,
          shadows: textShadow),
    );
  }
}
