import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final String title;
  final double percentage;
  final Color color;

  const ProgressBar({
    super.key,
    required this.title,
    required this.percentage,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: 24,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      // color: Colors.grey.shade300,
                      color: Colors.white),
                ),
                FractionallySizedBox(
                  widthFactor: percentage,
                  child: Container(
                    height: 24,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: color,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Text(
            '${(percentage * 100).toStringAsFixed(1)}%',
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
