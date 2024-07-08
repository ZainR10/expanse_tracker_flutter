import 'package:expanse_tracker_flutter/View_Models/expanse_provider.dart';
import 'package:expanse_tracker_flutter/View_Models/login_firebase_logic.dart';
import 'package:expanse_tracker_flutter/View_Models/signup_firebase_logic.dart';
import 'package:expanse_tracker_flutter/View_Models/varification_firebase_logic.dart';
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
          create: (_) => VerificationViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => ExpensesProvider(),
        )
      ],
      child: MaterialApp(
        theme: appThemeData,
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        initialRoute: RoutesName.splashView,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
