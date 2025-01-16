import 'package:expanse_tracker_flutter/utils/routes/routes_name.dart';
import 'package:expanse_tracker_flutter/view/analytics_view.dart';
import 'package:expanse_tracker_flutter/view/expanse_list_view.dart';
import 'package:expanse_tracker_flutter/view/home_view.dart';
import 'package:expanse_tracker_flutter/view/authentication_view/login_view.dart';
import 'package:expanse_tracker_flutter/view/authentication_view/signup_view.dart';
import 'package:expanse_tracker_flutter/view/authentication_view/splash_view.dart';
import 'package:expanse_tracker_flutter/view/settings_view.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splashView:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashView());

      case RoutesName.loginView:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginView());

      case RoutesName.signUpView:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SignupView());

      case RoutesName.homeView:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeView());

      case RoutesName.analyticsView:
        return MaterialPageRoute(
            builder: (BuildContext context) => const AnalyticsView());

      case RoutesName.expanseListView:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ExpanseListView());

      case RoutesName.settingsView:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SettingsView());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return const Scaffold(
        body: Center(
          child: Text('No Routes Defined'),
        ),
      );
    });
  }
}

class VerificationCodeViewArguments {
  final String verificationId;

  VerificationCodeViewArguments({
    required this.verificationId,
  });
}
