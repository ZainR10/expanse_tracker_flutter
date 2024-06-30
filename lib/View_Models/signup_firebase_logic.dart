import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpViewModel with ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signUp(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account Created')),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.toString())),
      );
    }
  }
}
