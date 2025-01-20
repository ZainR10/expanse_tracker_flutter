import 'package:cloud_firestore/cloud_firestore.dart';

class AddBalance {
  final String documentId; // Ensure this is properly initialized
  final double amount;
  final DateTime date;
  final String icon;

  AddBalance({
    required this.documentId,
    required this.amount,
    required this.date,
    required this.icon,
  });

  factory AddBalance.fromFirestore(Map<String, dynamic> data, String docId) {
    return AddBalance(
      documentId: docId,
      amount: data['amount'] ?? 0.0,
      date: (data['date'] as Timestamp).toDate(),
      icon: data['icon'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'amount': amount,
      'date': Timestamp.fromDate(date),
      'icon': icon,
    };
  }
}

class Expanses {
  final String id; // Firestore document ID
  final String title;
  final String description;
  final double amount;
  final DateTime startDate;
  final String
      type; // Add type here to specify whether it's an 'expense' or 'balance'

  Expanses({
    this.id = '', // default to empty string, can be set later
    required this.title,
    required this.description,
    required this.amount,
    required this.startDate,
    required this.type, // Ensure type is passed in the constructor
  });

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'description': description,
      'amount': amount,
      'startDate': startDate.toString(),
      'type': type, // Store type in Firestore
    };
  }

  static Expanses fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final amount = data['amount'];
    final type = data['type'] ?? 'expense'; // Default to 'expense' if null
    return Expanses(
      id: doc.id,
      title: data['title'],
      description: data['description'],
      amount: amount is int ? amount.toDouble() : amount,
      startDate: DateTime.parse(data['startDate']),
      type: type, // Set type here, with default if null
    );
  }

  @override
  String toString() {
    return 'Expanses(title: $title, description: $description, amount: $amount, startDate: $startDate, type: $type)';
  }
}
