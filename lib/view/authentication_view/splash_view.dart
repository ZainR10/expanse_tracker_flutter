import 'package:expanse_tracker_flutter/View_Models/authentication_view_models/splash_view_logic.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  SplashViewLogic splashViewLogic = SplashViewLogic();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashViewLogic.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'WELCOME',
          style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
