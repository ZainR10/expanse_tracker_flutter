import 'package:expanse_tracker_flutter/res/components/colors.dart';
import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onPress;
  final bool loading;

  const RoundButton(
      {required this.title,
      this.loading = false,
      required this.onPress,
      super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: 60,
        margin: const EdgeInsets.all(24),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.buttonColor),
        child: Center(
          child: loading
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : Text(
                  title,
                  style: const TextStyle(
                      color: AppColors.whiteColor, fontSize: 24),
                ),
        ),
      ),
    );
  }
}
