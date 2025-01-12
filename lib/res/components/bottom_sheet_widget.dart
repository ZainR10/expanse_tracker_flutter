import 'package:flutter/material.dart';
import 'package:expanse_tracker_flutter/res/components/custom_textfield.dart';
import 'package:expanse_tracker_flutter/res/components/text_widget.dart';

void showMyBottomSheet(BuildContext context) {
  DateTime startDate = DateTime.now();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  Future<void> _selectStartDate(BuildContext context) async {
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
    {'icon': Icons.directions_bus, 'label': 'Bus Fare'},
    {'icon': Icons.shopping_cart, 'label': 'Grocery'},
    {'icon': Icons.fastfood, 'label': 'Food'},
    {'icon': Icons.local_hospital, 'label': 'Health'},
    {'icon': Icons.house, 'label': 'Rent'},
    {'icon': Icons.school, 'label': 'Education'},
    {'icon': Icons.more_horiz, 'label': 'Others'},
  ];

  int selectedIndex = -1;

  showModalBottomSheet(
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
          return Container(
            width: width,
            height: height * .75,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextfield(
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
                          textsize: 15,
                          textFieldIcon: const Icon(
                            Icons.money_sharp,
                            color: Colors.black,
                            size: 30,
                          ),
                          lebaltitle: 'Amount',
                          keyboardType: const TextInputType.numberWithOptions(),
                          textStore: amountController,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _selectStartDate(context),
                          child: AbsorbPointer(
                            child: CustomTextfield(
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
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(8.0),
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
                          });
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircleAvatar(
                              radius: 35,
                              backgroundColor: isSelected
                                  ? Colors.blueGrey
                                  : Colors.grey[500],
                              child: Icon(
                                iconData['icon'],
                                size: 35,
                                color: isSelected ? Colors.white : Colors.black,
                                shadows: [
                                  Shadow(
                                      color: isSelected
                                          ? Colors.blueGrey.shade900
                                          : Colors.blueGrey,
                                      blurRadius: 20)
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            CustomText(
                              text: iconData['label'],
                              textColor: isSelected
                                  ? Colors.blueGrey.shade900
                                  : Colors.black,
                              textSize: 20,
                              textWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
