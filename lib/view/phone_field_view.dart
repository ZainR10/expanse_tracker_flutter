import 'package:expanse_tracker_flutter/View_Models/validate.dart';
import 'package:expanse_tracker_flutter/View_Models/varification_firebase_logic.dart';
import 'package:expanse_tracker_flutter/res/components/round_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PhoneFieldView extends StatefulWidget {
  const PhoneFieldView({super.key});

  @override
  State<PhoneFieldView> createState() => _PhoneFieldViewState();
}

class _PhoneFieldViewState extends State<PhoneFieldView> {
  final TextEditingController phonecontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter phone number'),
        backgroundColor: Colors.indigo,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formkey,
              child: Column(
                children: [
                  TextFormField(
                    controller: phonecontroller,
                    validator: FormValidation.validatePhoneNumber,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      border: OutlineInputBorder(),
                      hintText: 'Enter your Number',
                      labelText: 'Phone Number',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Consumer<VerificationViewModel>(builder: (context, value, child) {
              return RoundButton(
                  title: 'Continue',
                  loading: value.verificationLoading,
                  onPress: () {
                    if (_formkey.currentState!.validate()) {
                      value.verification(
                          phoneController: phonecontroller, context: context);
                    }
                  });
            })
          ],
        ),
      ),
    );
  }
}
