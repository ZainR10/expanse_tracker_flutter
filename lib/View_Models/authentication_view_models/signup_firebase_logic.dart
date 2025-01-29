import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:expanse_tracker_flutter/utils/general_utils.dart';
import 'package:expanse_tracker_flutter/utils/routes/routes_name.dart';

class SignUpViewModel with ChangeNotifier {
  bool _signUpLoading = false;
  bool get signUpLoading => _signUpLoading;

  void setSignUpLoading(bool value) {
    _signUpLoading = value;
    notifyListeners();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signUp({
    required String name,
    required String email,
    required String phone,
    required String password,
    required BuildContext context,
  }) async {
    setSignUpLoading(true);

    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      // Store user details in Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'name': name,
        'email': email,
        'phone': phone,
        'profilePic': '', // Empty by default, user can update later
      });

      setSignUpLoading(false);
      GeneralUtils.snackBar('Account Created', context);
      Navigator.pushNamed(context, RoutesName.homeView);
    } catch (error) {
      setSignUpLoading(false);
      GeneralUtils.snackBar(error.toString(), context);
    }
  }
}
