import 'package:expanse_tracker_flutter/View_Models/expanse_provider.dart';
import 'package:expanse_tracker_flutter/models/expense_&_balance_class.dart';
import 'package:expanse_tracker_flutter/res/components/custom_button.dart';
import 'package:expanse_tracker_flutter/utils/validate.dart';
import 'package:flutter/material.dart';
import 'package:expanse_tracker_flutter/res/components/custom_textfield.dart';
import 'package:expanse_tracker_flutter/res/components/text_widget.dart';
import 'package:provider/provider.dart';

void expenseBottomSheet(BuildContext context) {
  final _formkey = GlobalKey<FormState>();

  DateTime startDate = DateTime.now();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  Future<void> selectStartDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: startDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(3000),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.black, // Header background color
              onPrimary: Colors.white, // Header text color
              onSurface: Colors.black, // Text color
            ),
            dialogBackgroundColor:
                Colors.white, // Background color of the calendar
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null && pickedDate != startDate) {
      startDate = pickedDate;
      dateController.text = "${pickedDate.toLocal()}".split(' ')[0];
    }
  }

  // Icon data with corresponding labels
  final List<Map<String, dynamic>> iconsData = [
    {'icon': Icons.directions_bus, 'label': 'Transportation'},
    {'icon': Icons.shopping_cart, 'label': 'Grocery'},
    {'icon': Icons.fastfood, 'label': 'Food'},
    {'icon': Icons.local_hospital, 'label': 'Health'},
    {'icon': Icons.house, 'label': 'Rent'},
    {'icon': Icons.school, 'label': 'Education'},
    {'icon': Icons.more_horiz, 'label': 'Others'},
  ];

  int selectedIndex = -1;

  showModalBottomSheet(
    barrierColor: Colors.transparent,
    showDragHandle: true,
    useSafeArea: true,
    shape: const OutlineInputBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(50),
        topLeft: Radius.circular(50),
      ),
    ),
    enableDrag: true,
    isScrollControlled: true,
    backgroundColor: Colors.blueGrey.shade50,
    context: context,
    builder: (BuildContext context) {
      final height = MediaQuery.of(context).size.height * 1;
      final width = MediaQuery.of(context).size.width * 1;

      return StatefulBuilder(
        builder: (BuildContext context, setState) {
          return SizedBox(
            width: width,
            height: height * .65,
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextfield(
                    validator: FormValidation.generalValidation,
                    textsize: 28,
                    textFieldIcon: const Icon(
                      Icons.edit,
                      color: Colors.black,
                      size: 30,
                    ),
                    lebaltitle: 'Type Expense Title',
                    textStore: titleController,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      children: [
                        const SizedBox(width: 5),
                        Expanded(
                          child: CustomTextfield(
                            validator: FormValidation.generalValidation,
                            textsize: 15,
                            textFieldIcon: const Icon(
                              Icons.money_sharp,
                              color: Colors.black,
                              size: 30,
                            ),
                            lebaltitle: 'Amount',
                            keyboardType:
                                const TextInputType.numberWithOptions(),
                            textStore: amountController,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => selectStartDate(context),
                            child: AbsorbPointer(
                              child: CustomTextfield(
                                validator: FormValidation.generalValidation,
                                textsize: 15,
                                textFieldIcon: const Icon(
                                  Icons.calendar_today,
                                  color: Colors.black,
                                  size: 30,
                                ),
                                lebaltitle: 'Date',
                                keyboardType: TextInputType.datetime,
                                textStore: dateController,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    color: Colors.black,
                    height: 2,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8),
                            child: CustomText(
                              text: 'Select Relevant Icon',
                              textColor: Colors.black,
                              textLetterSpace: 1,
                              textSize: 28,
                              textWeight: FontWeight.bold,
                            ),
                          ),
                          FormField<int>(
                            validator: (value) {
                              if (selectedIndex == -1) {
                                return 'Please select an icon.';
                              }
                              return null;
                            },
                            builder: (FormFieldState<int> state) {
                              return Column(
                                children: [
                                  GridView.builder(
                                    padding: const EdgeInsets.all(8.0),
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 12,
                                      mainAxisSpacing: 12,
                                    ),
                                    itemCount: iconsData.length,
                                    itemBuilder: (context, index) {
                                      final iconData = iconsData[index];
                                      final isSelected = selectedIndex == index;

                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedIndex = index;
                                            state.didChange(
                                                selectedIndex); // Update form state
                                          });
                                        },
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            CircleAvatar(
                                              radius: 35,
                                              backgroundColor: isSelected
                                                  ? Colors.greenAccent
                                                  : Colors.blueGrey.shade100,
                                              child: Icon(
                                                iconData['icon'],
                                                size: 35,
                                                color: isSelected
                                                    ? Colors.white
                                                    : Colors.black,
                                                shadows: [
                                                  Shadow(
                                                      color: isSelected
                                                          ? Colors
                                                              .green.shade900
                                                          : Colors.blueGrey
                                                              .shade800,
                                                      blurRadius: 20)
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            CustomText(
                                              text: iconData['label'],
                                              textColor: isSelected
                                                  ? Colors.greenAccent.shade700
                                                  : Colors.blueGrey.shade600,
                                              textSize: 18,
                                              textWeight: FontWeight.w500,
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                  if (state.hasError)
                                    CustomText(
                                      text: state.errorText!,
                                      textColor: Colors.red,
                                      textSize: 18,
                                      textWeight: FontWeight.w500,
                                    ),
                                ],
                              );
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CustomButton(
                                  title: 'Cancel',
                                  buttonColor: Colors.red,
                                  onPress: () {},
                                  height: height * .07,
                                  width: width * .40,
                                ),
                                CustomButton(
                                  title: 'Save',
                                  buttonColor: Colors.green,
                                  onPress: () {
                                    if (_formkey.currentState!.validate()) {
                                      if (_formkey.currentState!.validate()) {
                                        // Create the Expanses object
                                        final expense = Expanses(
                                          title: titleController.text,
                                          description:
                                              'Some description', // Add a description if needed
                                          amount: double.parse(amountController
                                              .text), // Amount entered by the user
                                          startDate: DateTime.parse(dateController
                                              .text), // Date entered by the user
                                          type:
                                              'expense', // Assuming this is an expense
                                        );

                                        // Call the provider's addExpense method
                                        context
                                            .read<ExpensesProvider>()
                                            .addExpense(expense);
                                      }
                                      Navigator.pop(context);
                                    }
                                  },
                                  height: height * .07,
                                  width: width * .40,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
