import 'package:cloud_firestore/cloud_firestore.dart';

class Balance {
  final double balanceAmount;

  Balance({required this.balanceAmount});

  Map<String, dynamic> toFirestore() {
    return {
      'balanceAmount': balanceAmount,
    };
  }

  static Balance fromFirestore(Map<String, dynamic> data) {
    final balanceAmount = data['balanceAmount'];
    return Balance(
      balanceAmount:
          balanceAmount is int ? balanceAmount.toDouble() : balanceAmount,
    );
  }
}

class Expanses {
  final String id; // Firestore document ID
  final String title;
  final String description;
  final double amount;
  final DateTime startDate;

  Expanses({
    this.id = '', // default to empty string, can be set later
    required this.title,
    required this.description,
    required this.amount,
    required this.startDate,
  });

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'description': description,
      'amount': amount,
      'startDate': startDate.toIso8601String(),
    };
  }

  static Expanses fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final amount = data['amount'];
    return Expanses(
      id: doc.id,
      title: data['title'],
      description: data['description'],
      amount: amount is int ? amount.toDouble() : amount,
      startDate: DateTime.parse(data['startDate']),
    );
  }

  @override
  String toString() {
    return 'Expanses(title: $title, description: $description, amount: $amount, startDate: $startDate)';
  }
}
