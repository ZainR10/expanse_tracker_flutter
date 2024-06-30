import 'dart:async';

import 'package:expanse_tracker_flutter/view/login_view.dart';
import 'package:flutter/material.dart';

class SplashViewLogic {
  void isLogin(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const LoginView()));
    });
  }
}
