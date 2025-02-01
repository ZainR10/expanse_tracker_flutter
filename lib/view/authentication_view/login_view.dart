import 'package:expanse_tracker_flutter/View_Models/authentication_view_models/login_firebase_logic.dart';
import 'package:expanse_tracker_flutter/components/custom_textfield.dart';
import 'package:expanse_tracker_flutter/components/round_button.dart';
import 'package:expanse_tracker_flutter/components/text_widget.dart';
import 'package:expanse_tracker_flutter/main.dart';
import 'package:expanse_tracker_flutter/utils/system_back_button_press.dart';
import 'package:expanse_tracker_flutter/utils/validate.dart';
import 'package:expanse_tracker_flutter/utils/general_utils.dart';
import 'package:expanse_tracker_flutter/utils/routes/routes_name.dart';
import 'package:expanse_tracker_flutter/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formkey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    return SystemBackButtonPress(
      shouldExitApp: true,
      scaffoldMessengerKey: MyApp.scaffoldMessengerKey,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const PreferredSize(
            preferredSize: Size(0, 45),
            child: ReuseableAppBar(
              appBarTitle: 'Welcome Back',
            )),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(children: [
            SizedBox(
              height: height * .03,
            ),
            Form(
                key: _formkey,
                child: Column(
                  children: [
                    CustomTextfield(
                        textStore: emailController,
                        keyboardType: TextInputType.emailAddress,
                        textFieldIcon: const Icon(Icons.alternate_email),
                        textsize: 20,
                        lebaltitle: 'Enter your email',
                        validator: FormValidation.validateEmail,
                        onfieldSubmission: (value) {
                          GeneralUtils.fieldFocusChange(
                              context, emailFocusNode, passwordFocusNode);
                        }),
                    CustomTextfield(
                      textStore: passwordController,
                      keyboardType: TextInputType.emailAddress,
                      textFieldIcon: const Icon(Icons.lock),
                      textsize: 20,
                      lebaltitle: 'Enter your password',
                      validator: FormValidation.validatePassword,
                    ),
                  ],
                )),
            Consumer<LoginViewModel>(
              builder: (context, value, child) {
                return RoundButton(
                  title: 'Log in',
                  loading: value.loginLoading,
                  onPress: () {
                    if (_formkey.currentState!.validate()) {
                      value.login(
                        email: emailController.text.toString(),
                        password: passwordController.text.toString(),
                        context: context,
                      );
                    }
                  },
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomText(
                  text: 'Dont have an account?',
                  textSize: 20,
                  textWeight: FontWeight.bold,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RoutesName.signUpView);
                  },
                  child: const CustomText(
                    text: 'Register',
                    textSize: 20,
                    textWeight: FontWeight.bold,
                    textColor: Colors.black,
                  ),
                )
              ],
            ),
          ]),
        )),
      ),
    );
  }
}
