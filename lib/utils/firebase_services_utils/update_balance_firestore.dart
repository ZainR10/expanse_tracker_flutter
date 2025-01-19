// // balance_utils.dart
// import 'package:cloud_firestore/cloud_firestore.dart';

// Future<void> updateBalance(double enteredAmount) async {
//   // Fetch the current balance from Firestore
//   DocumentSnapshot snapshot =
//       await FirebaseFirestore.instance.collection('balances').doc('main').get();

//   double currentBalance = 0.0;
//   if (snapshot.exists) {
//     final data = snapshot.data() as Map<String, dynamic>;
//     currentBalance = (data['totalBalance'] ?? 0).toDouble();
//   }

//   // Update the balance
//   double newBalance = currentBalance + enteredAmount;

//   // Fetch current total expenses and calculate remaining balance
//   double totalExpenses = await _getTotalExpenses();
//   double remainingBalance = newBalance - totalExpenses;
// //
//   // Save the new balance and remaining balance to Firestore
//   await FirebaseFirestore.instance.collection('balances').doc('main').set(
//     {
//       'totalBalance': newBalance, // Update the total balance field
//       'remainingBalance': remainingBalance, // Update the remaining balance
//       'lastUpdated': Timestamp.now(), // Optionally, store the last updated time
//     },
//     SetOptions(merge: true), // Merge the new data with existing data
//   );
// }

// // Function to get total expenses from Firestore
// Future<double> _getTotalExpenses() async {
//   QuerySnapshot snapshot =
//       await FirebaseFirestore.instance.collection('expenses').get();
//   double totalExpenses = snapshot.docs.fold(0.0, (sum, doc) {
//     final data = doc.data() as Map<String, dynamic>;
//     return sum + (data['amount'] ?? 0.0).toDouble();
//   });
//   return totalExpenses;
// }
