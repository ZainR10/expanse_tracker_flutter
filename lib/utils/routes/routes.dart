import 'package:expanse_tracker_flutter/utils/page_transtions.dart';
import 'package:expanse_tracker_flutter/utils/routes/routes_name.dart';
import 'package:expanse_tracker_flutter/view/analytics_view.dart';
import 'package:expanse_tracker_flutter/view/expanse_list_view.dart';
import 'package:expanse_tracker_flutter/view/home_view.dart';
import 'package:expanse_tracker_flutter/view/authentication_view/login_view.dart';
import 'package:expanse_tracker_flutter/view/authentication_view/signup_view.dart';
import 'package:expanse_tracker_flutter/view/authentication_view/splash_view.dart';
import 'package:expanse_tracker_flutter/view/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splashView:
        return PageTransitions.fadeTransition(const SplashView());

      case RoutesName.loginView:
        return PageTransitions.pageTransition(
            const LoginView(), PageTransitionType.leftToRight);

      case RoutesName.signUpView:
        return PageTransitions.pageTransition(
            const SignupView(), PageTransitionType.rightToLeft);

      case RoutesName.homeView:
        return PageTransitions.pageTransition(
            const HomeView(), PageTransitionType.rightToLeft);

      case RoutesName.analyticsView:
        return PageTransitions.pageTransition(
            const AnalyticsView(), PageTransitionType.rightToLeft);

      case RoutesName.expanseListView:
        return PageTransitions.pageTransition(
            const ExpanseListView(), PageTransitionType.rightToLeft);

      case RoutesName.settingsView:
        return PageTransitions.pageTransition(
            const SettingsView(), PageTransitionType.rightToLeft);

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
