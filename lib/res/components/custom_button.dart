import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Color buttonColor;
  final double? width;
  final double? height;

  final VoidCallback onPress;
  final bool loading;

  const CustomButton(
      {this.width,
      required this.title,
      this.height,
      required this.buttonColor,
      this.loading = false,
      required this.onPress,
      super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: buttonColor, borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
