// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:expanse_tracker_flutter/models/expense_&_balance_class.dart';
// import 'package:flutter/material.dart';

// void testDelete() async {
//   try {
//     final path =
//         'balance/je2DN7sD3TyLLjqrZOCD'; // Replace with the printed path
//     await FirebaseFirestore.instance.doc(path).delete();
//     print('Successfully deleted document at: $path');
//   } catch (error) {
//     print('Error deleting document: $error');
//   }
// }

// void deleteBalance(String documentId) async {
//   try {
//     final docRef =
//         FirebaseFirestore.instance.collection('balance').doc(documentId);
//     await docRef.delete();
//     print('Successfully deleted document: $documentId');
//   } catch (error) {
//     print('Error deleting document: $error');
//   }
// }
// // void deleteBalance(BuildContext context, AddBalance balance) async {
// //   try {
// //     if (balance.documentId == null || balance.documentId!.isEmpty) {
// //       // Check for null or empty
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(content: Text('Cannot delete: Invalid balance ID.')),
// //       );
// //       return; // Important: Exit the function if the ID is invalid
// //     }

// //     final docId =
// //         balance.documentId!; // Now safe to use ! (null assertion operator)
// //     final balanceCollection = FirebaseFirestore.instance.collection('balance');
// //     await balanceCollection.doc(docId).delete();
// //     print('Attempting to delete balance with ID: $docId');

// //     // ... (rest of the deleteBalance function - updating total balance and provider)
// //   } catch (error) {
// //     debugPrint('Error deleting balance: $error');
// //     ScaffoldMessenger.of(context).showSnackBar(
// //       const SnackBar(content: Text('Failed to delete balance.')),
// //     );
// //   }
// // }
