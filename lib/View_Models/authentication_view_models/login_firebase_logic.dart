import 'package:expanse_tracker_flutter/utils/general_utils.dart';
import 'package:expanse_tracker_flutter/utils/routes/routes_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginViewModel with ChangeNotifier {
  bool _loginLoading = false;
  bool get loginLoading => _loginLoading;

  void setloginLoading(bool value) {
    _loginLoading = value;
    notifyListeners();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    setloginLoading(true);
    _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      setloginLoading(false);
      GeneralUtils.snackBar(value.user!.email.toString(), context);
      Navigator.pushNamed(context, RoutesName.homeView);
    }).catchError((error) {
      setloginLoading(false);
      GeneralUtils.snackBar(error.toString(), context);
    });
  }
}
