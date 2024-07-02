import 'dart:async';

import 'package:expanse_tracker_flutter/view/home_view.dart';
import 'package:expanse_tracker_flutter/view/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashViewLogic {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user != null) {
      Timer(const Duration(seconds: 3), () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const HomeView()));
      });
    } else {
      Timer(const Duration(seconds: 3), () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginView()));
      });
    }
  }
}
