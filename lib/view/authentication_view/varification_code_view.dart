import 'package:flutter/material.dart';

class VarificationCodeView extends StatefulWidget {
  final String verificationId;
  const VarificationCodeView({required this.verificationId, super.key});

  @override
  State<VarificationCodeView> createState() => _VarificationCodeViewState();
}

class _VarificationCodeViewState extends State<VarificationCodeView> {
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
