import 'package:expanse_tracker_flutter/res/components/colors.dart';
import 'package:expanse_tracker_flutter/res/components/round_button.dart';
import 'package:expanse_tracker_flutter/utils/general_utils.dart';
import 'package:expanse_tracker_flutter/view/signup_view.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
        appBar: AppBar(
          title: const Text('Log in'),
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.indigo,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          TextFormField(
                            focusNode: emailFocusNode,
                            controller: emailController,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Email field cannot be empty";
                              }
                              if (!value.contains('@') ||
                                  !value.contains('.com')) {
                                return "Invalid email address";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.alternate_email),
                              border: OutlineInputBorder(),
                              hintText: 'Enter your Email',
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            onFieldSubmitted: (value) {
                              GeneralUtils.fieldFocusChange(
                                  context, emailFocusNode, passwordFocusNode);
                            },
                          ),
                          SizedBox(
                            height: height * .03,
                          ),
                          TextFormField(
                            focusNode: passwordFocusNode,
                            controller: passwordController,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Password field cannot be empty";
                              }
                              if (value.length <= 8) {
                                return "Password length must be greater than 8";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.lock_person_rounded),
                              border: OutlineInputBorder(),
                              hintText: 'Enter your Password',
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ))
                ],
              ),
              RoundButton(
                  title: 'Log in',
                  onPress: () {
                    if (_formkey.currentState!.validate()) {}
                  }),
              // SizedBox(
              //   height: height * .0,
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignupView()));
                      },
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                            color: AppColors.buttonColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ))
                ],
              )
            ],
          ),
        ));
  }
}
