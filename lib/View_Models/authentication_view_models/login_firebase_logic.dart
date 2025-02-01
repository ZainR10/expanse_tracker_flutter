import 'package:expanse_tracker_flutter/utils/general_utils.dart';
import 'package:expanse_tracker_flutter/utils/page_transtions.dart';
import 'package:expanse_tracker_flutter/view/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

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
      Navigator.push(
        context,
        PageTransitions.pageTransition(
            const HomeView(), PageTransitionType.bottomToTop),
      );
    }).catchError((error) {
      setloginLoading(false);
      GeneralUtils.snackBar(error.toString(), context);
    });
  }
}
