import 'package:flutter/material.dart';

class PhoneCodeView extends StatefulWidget {
  const PhoneCodeView({super.key});

  @override
  State<PhoneCodeView> createState() => _PhoneCodeViewState();
}

class _PhoneCodeViewState extends State<PhoneCodeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter phone number'),
        backgroundColor: Colors.indigo,
        centerTitle: true,
      ),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [],
        ),
      ),
    );
  }
}
