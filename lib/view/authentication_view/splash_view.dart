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
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade200,
      body: Center(
          child: Image.asset(
        'assets/expense splash image.jpeg',
        fit: BoxFit.cover,
        height: height * 1,
        width: width * 1,
      )),
    );
  }
}
