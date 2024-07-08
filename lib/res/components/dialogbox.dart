import 'package:flutter/material.dart';
import 'package:expanse_tracker_flutter/View_Models/expanse_&_balance_class.dart';
import 'package:expanse_tracker_flutter/res/components/custom_button.dart';
import 'package:expanse_tracker_flutter/utils/routes/routes_name.dart';

class DialogBox extends StatefulWidget {
  final void Function(Expanses newExpanse) addExpansesCallback;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  DialogBox({
    Key? key,
    required this.addExpansesCallback,
    required this.onSave,
    required this.onCancel,
  }) : super(key: key);

  @override
  State<DialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  bool isExpenseActive = true; // Track which button is active

  DateTime startDate = DateTime.now();
  TimeOfDay startTime = TimeOfDay.now();
  final TextEditingController expanseController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: startDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(3000),
    );
    if (pickedDate != null && pickedDate != startDate) {
      setState(() {
        startDate = pickedDate;
      });
    }
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: startTime,
    );
    if (pickedTime != null) {
      setState(() {
        startTime = pickedTime;
      });
    }
  }

  void _addExpenses() {
    Expanses newExpanse = Expanses(
      title: expanseController.text,
      description: descriptionController.text,
      startDate: startDate,
      startTime: startTime,
      amount: double.tryParse(amountController.text) ?? 0.0,
    );
    widget.addExpansesCallback(newExpanse);
    Navigator.pushNamed(context, RoutesName.homeView);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;

    return Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: AlertDialog(
          title: const Text('Add Expanse Details'),
          contentPadding: const EdgeInsets.all(20),
          shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 255, 250, 248),
          content: SizedBox(
            height: height * .55,
            width: width * .80,
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Toggle buttons for Expense and Balance

                    // Fields based on active button

                    // Name
                    TextField(
                      controller: expanseController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.mode_edit_outline_outlined),
                        border: OutlineInputBorder(),
                        hintText: "Add a new expense",
                      ),
                    ),
                    SizedBox(height: height * .02),
                    // Category
                    TextField(
                      controller: descriptionController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.description_outlined),
                        border: OutlineInputBorder(),
                        hintText: "Write about expense type",
                      ),
                    ),
                    SizedBox(height: height * .02),
                    // Amount
                    TextField(
                      keyboardType: TextInputType.number,
                      controller: amountController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.attach_money_rounded),
                        border: OutlineInputBorder(),
                        hintText: "Amount",
                      ),
                    ),
                    SizedBox(height: height * .03),
                    // Date and time row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.calendar_month_outlined),
                          onPressed: () => _selectStartDate(context),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _selectStartDate(context),
                            child: AbsorbPointer(
                              child: TextField(
                                controller: TextEditingController(
                                  text: startDate.toString().split(' ')[0],
                                ),
                                decoration: const InputDecoration(
                                  labelText: 'Start Date',
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: width * .02),
                        IconButton(
                          icon: const Icon(Icons.access_time),
                          onPressed: () => _selectStartTime(context),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _selectStartTime(context),
                            child: AbsorbPointer(
                              child: TextField(
                                controller: TextEditingController(
                                  text: startTime.format(context),
                                ),
                                decoration: const InputDecoration(
                                  labelText: 'Start Time',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: height * .02),
                    // Buttons: Save and Cancel
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Save button
                        Expanded(
                          child: CustomButton(
                            width: width * .30,
                            color: Colors.black87,
                            title: 'Save',
                            onPress: _addExpenses,
                          ),
                        ),
                        SizedBox(width: width * .06),
                        // Cancel button
                        Expanded(
                          child: CustomButton(
                            width: width * .30,
                            color: Colors.red,
                            title: 'Cancel',
                            onPress: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ]),
            ),
          ),
        ));
  }
}
