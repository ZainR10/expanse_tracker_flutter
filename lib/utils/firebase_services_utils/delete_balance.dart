import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expanse_tracker_flutter/View_Models/balance_expenses_provider.dart';
import 'package:expanse_tracker_flutter/models/expense_&_balance_class.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void deleteBalance(BuildContext context, AddBalance balance) async {
  try {
    final docId =
        balance.documentId; // Assuming `AddBalance` has a `documentId` field.
    final balanceCollection = FirebaseFirestore.instance.collection('balance');

    // Delete the specific balance record
    await balanceCollection.doc(docId).delete();

    // Update total balance
    final totalBalanceDoc = balanceCollection.doc('total_balance');
    final totalBalanceData = await totalBalanceDoc.get();

    if (totalBalanceData.exists) {
      final currentTotal = totalBalanceData.data()?['amount'] ?? 0.0;
      await totalBalanceDoc.update({
        'amount': currentTotal - balance.amount,
      });
    }

    // Update local state using the provider
    final provider =
        Provider.of<BalanceAndExpensesProvider>(context, listen: false);
    provider.deleteBalanceFromProvider(docId, balance.amount);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Balance deleted successfully!')),
    );
  } catch (error) {
    debugPrint('Error deleting balance: $error');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Failed to delete balance.')),
    );
  }
}
