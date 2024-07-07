import 'package:flutter/material.dart';

class DialogBox extends StatefulWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  State<DialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
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

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 255, 250, 248),
      content: Container(
        height: height * .55,
        width: width * .80,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Name
              TextField(
                controller: expanseController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.mode_edit_outline_outlined),
                  border: OutlineInputBorder(),
                  hintText: "Add a new expanse",
                ),
              ),
              SizedBox(
                height: height * .02,
              ),
              // category
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.description_outlined),
                  border: OutlineInputBorder(),
                  hintText: "Write about Expanse type",
                ),
              ),
              SizedBox(
                height: height * .02,
              ),
              // amount
              TextField(
                keyboardType: TextInputType.number,
                controller: amountController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.attach_money_rounded),
                  border: OutlineInputBorder(),
                  hintText: "Amount",
                ),
              ),
              SizedBox(
                height: height * .03,
              ),
              //date and time row
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
                              text: startDate.toString().split(' ')[0]),
                          decoration:
                              const InputDecoration(labelText: 'Start Date'),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width * .02,
                  ),
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
                              text: startTime.format(context)),
                          decoration:
                              const InputDecoration(labelText: 'Start Time'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * .02,
              ),
              // // buttons -> save + cancel
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // save button
                  Container(
                    height: height * .09,
                    width: width * .30,
                    decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Center(
                      child: Text(
                        'Save',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),

                  SizedBox(width: width * .08),

                  // cancel button
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: height * .09,
                      width: width * .30,
                      decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
