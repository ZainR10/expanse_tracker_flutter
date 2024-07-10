import 'package:expanse_tracker_flutter/View_Models/authentication_view_models/validate.dart';
import 'package:flutter/material.dart';
import 'package:expanse_tracker_flutter/models/expanse_&_balance_class.dart';
import 'package:expanse_tracker_flutter/res/components/custom_button.dart';
import 'package:expanse_tracker_flutter/utils/routes/routes_name.dart';
import 'package:intl/intl.dart';

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
  String? selectedCategory;
  final _formkey = GlobalKey<FormState>();

  DateTime startDate = DateTime.now();

  final TextEditingController expanseController = TextEditingController();
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

  void _addExpenses() {
    Expanses newExpanse = Expanses(
      title: expanseController.text,
      description: selectedCategory.toString(),
      startDate: startDate,
      amount: double.tryParse(amountController.text) ?? 0.0,
    );
    widget.addExpansesCallback(newExpanse);
    Navigator.pushNamed(context, RoutesName.homeView);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

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
                Form(
                    key: _formkey,
                    child: Column(children: [
                      TextFormField(
                        validator: FormValidation.validateExpanseName,
                        controller: expanseController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.mode_edit_outline_outlined),
                          border: OutlineInputBorder(),
                          hintText: "Add a new expense",
                        ),
                      ),
                      SizedBox(height: height * .02),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.description_outlined),
                          border: OutlineInputBorder(),
                          hintText: 'Please select your Category',
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        value: selectedCategory,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedCategory = newValue;
                          });
                        },
                        items: <String>[
                          'Food',
                          'Travel Expense',
                          'Bills',
                          'Shopping',
                          'Education',
                          'Health',
                          'Grocery'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: height * .02),
                      TextFormField(
                        validator: FormValidation.validateamount,
                        keyboardType: TextInputType.number,
                        controller: amountController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.attach_money_rounded),
                          border: OutlineInputBorder(),
                          hintText: "Amount",
                        ),
                      ),
                      SizedBox(height: height * .03),
                      GestureDetector(
                        onTap: () => _selectStartDate(context),
                        child: AbsorbPointer(
                          child: TextField(
                            controller: TextEditingController(
                              text: dateFormat.format(startDate),
                            ),
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.calendar_month)),
                          ),
                        ),
                      ),
                      SizedBox(height: height * .02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: CustomButton(
                                width: width * .30,
                                color: Colors.black87,
                                title: 'Save',
                                onPress: () {
                                  if (_formkey.currentState!.validate()) {
                                    _addExpenses();
                                  }
                                }),
                          ),
                          SizedBox(width: width * .06),
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
                    ]))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
