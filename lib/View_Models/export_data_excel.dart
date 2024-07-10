// import 'package:excel/excel.dart';
// import 'package:expanse_tracker_flutter/View_Models/expanse_provider.dart';
// import 'package:provider/provider.dart';
// import 'dart:io';
// import 'package:path_provider/path_provider.dart';
// import 'package:flutter/material.dart';

// Future<void> exportDataToExcel(BuildContext context) async {
//   // Create a new Excel document
//   var excel = Excel.createExcel();

//   // Get the provider
//   final expensesProvider = Provider.of<ExpensesProvider>(context, listen: false);

//   // Get the data
//   final expenses = expensesProvider.expenses;
//   final categories = expensesProvider.categories;
//   final totalBalance = expensesProvider.totalBalance;
//   final remainingBalance = expensesProvider.remainingBalance;
//   final totalExpenses = expensesProvider.totalExpenses;

//   // Create a sheet for summary
//   Sheet summarySheet = excel['Summary'];
//   summarySheet.appendRow([
//     CellValue(totalBalance.toString())
//   ]);
//   summarySheet.appendRow([
//     CellValue(remainingBalance.toString())
//   ]);
//   summarySheet.appendRow([
//     CellValue(totalExpenses.toString())
//   ]);

//   // Create a sheet for expenses
//   Sheet expenseSheet = excel['Expenses'];
//   expenseSheet.appendRow([
//     CellValue('Title'),
//     CellValue('Description'),
//     CellValue('Amount'),
//     CellValue('Category'),
//     CellValue('Date')
//   ]);
//   for (var expense in expenses) {
//     expenseSheet.appendRow([
//       CellValue(expense.title),
//       CellValue(expense.description),
//       CellValue(expense.amount.toString()),
//       CellValue(expense.categoryName), // Assuming you have category name in your expense model
//       CellValue(expense.startDate.toString()),
//     ]);
//   }

//   // Create a sheet for categories
//   Sheet categorySheet = excel['Categories'];
//   categorySheet.appendRow([
//     CellValue('Category Name')
//   ]);
//   for (var category in categories) {
//     categorySheet.appendRow([CellValue(category.name)]);
//   }

//   // Save the file
//   final directory = await getExternalStorageDirectory();
//   final path = '${directory!.path}/expenses_and_categories.xlsx';
//   File(path)
//     ..createSync(recursive: true)
//     ..writeAsBytesSync(excel.save()!);

//   // Show a success message
//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(content: Text('Data exported to $path')),
//   );
// }
