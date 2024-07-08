import 'package:flutter/material.dart';

class Balance {
  final double balanceAmount;

  Balance({required this.balanceAmount});
}

class Expanses {
  final String title;
  final String description;
  final double amount;
  final DateTime startDate;
  final TimeOfDay startTime;

  Expanses({
    required this.title,
    required this.description,
    required this.amount,
    required this.startDate,
    required this.startTime,
  });

  @override
  String toString() {
    return 'Expanses(title: $title, description: $description, amount: $amount, startDate: $startDate, startTime: $startTime)';
  }
}
