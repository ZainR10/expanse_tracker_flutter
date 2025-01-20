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
  final String id; // Add this field
  final String title;
  final double amount;
  final String description;
  final DateTime startDate;

  Expanses({
    required this.id, // Include it in the constructor
    required this.title,
    required this.amount,
    required this.description,
    required this.startDate,
  });

  factory Expanses.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Expanses(
      id: doc.id, // Assign document ID
      title: data['title'] ?? 'No Title',
      amount: data['amount'] != null ? (data['amount'] as num).toDouble() : 0.0,
      description: data['description'] ?? 'No Description',
      startDate: data['startDate'] != null
          ? (data['startDate'] as Timestamp).toDate() // Convert if not null
          : DateTime.now(), // Provide a default value if null
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'amount': amount,
      'description': description,
      'startDate': startDate,
    };
  }
}
