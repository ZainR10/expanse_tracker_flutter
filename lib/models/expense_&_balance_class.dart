import 'package:cloud_firestore/cloud_firestore.dart';

class AddBalance {
  final String documentId;
  final double amount;
  final DateTime date;
  final String icon;

  AddBalance({
    required this.documentId,
    required this.amount,
    required this.date,
    required this.icon,
  });

  // Factory method for Firestore
  factory AddBalance.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return AddBalance(
      documentId: doc.id, // Use Firestore's document ID
      amount: data['amount'],
      date: (data['date'] as Timestamp).toDate(),
      icon: data['icon'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'amount': amount,
      'date': date,
      'icon': icon,
    };
  }
}

class AddExpenses {
  final String documentId;
  final String title;
  final double amount;
  final DateTime date;
  final String icon;

  AddExpenses({
    required this.documentId,
    required this.title,
    required this.amount,
    required this.date,
    required this.icon,
  });

  // Convert to Firestore format
  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'amount': amount,
      'date': date.toIso8601String(),
      'icon': icon,
    };
  }

  // Create from Firestore
  factory AddExpenses.fromFirestore(String id, Map<String, dynamic> data) {
    return AddExpenses(
      documentId: id,
      title: data['title'],
      amount: (data['amount'] as num).toDouble(),
      date: DateTime.parse(data['date']),
      icon: data['icon'],
    );
  }
}
