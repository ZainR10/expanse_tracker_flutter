import 'package:expanse_tracker_flutter/View_Models/balance_expenses_provider.dart';
import 'package:expanse_tracker_flutter/View_Models/chart_provider.dart';
import 'package:expanse_tracker_flutter/View_Models/currency_provider.dart';
import 'package:expanse_tracker_flutter/View_Models/authentication_view_models/login_firebase_logic.dart';
import 'package:expanse_tracker_flutter/View_Models/authentication_view_models/signup_firebase_logic.dart';
import 'package:expanse_tracker_flutter/utils/routes/routes.dart';
import 'package:expanse_tracker_flutter/utils/routes/routes_name.dart';
import 'package:expanse_tracker_flutter/utils/theme.dart';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SignUpViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => LoginViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => CurrencyProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ChartTypeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => BalanceAndExpensesProvider()..preloadData(),
        )
      ],
      child: MaterialApp(
        theme: appThemeData,
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        scaffoldMessengerKey: scaffoldMessengerKey,
        initialRoute: RoutesName.homeView,
        onGenerateRoute: Routes.generateRoute,
        // home: SplashView(),
      ),
    );
  }
}
