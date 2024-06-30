import 'package:expanse_tracker_flutter/View_Models/signup_firebase_logic.dart';
import 'package:expanse_tracker_flutter/res/components/colors.dart';
import 'package:expanse_tracker_flutter/res/components/round_button.dart';
import 'package:expanse_tracker_flutter/utils/general_utils.dart';
import 'package:expanse_tracker_flutter/view/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  final _formkey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  FocusNode nameFocusNode = FocusNode();
  FocusNode phoneNumberFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
    passwordController.dispose();

    nameFocusNode.dispose();
    phoneNumberFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _signupViewModel = Provider.of<SignUpViewModel>(context);
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sign up'),
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.indigo,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * .15,
                ),
                Column(
                  children: [
                    Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            //name
                            TextFormField(
                              focusNode: nameFocusNode,
                              controller: nameController,
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return "Name field cannot be empty";
                                }
                                if (value.contains('@') ||
                                    value.contains('.com')) {
                                  return "Name can not contain words like these";
                                }
                                return null;
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.person_outline_outlined),
                                border: OutlineInputBorder(),
                                hintText: 'Enter your Name',
                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              onFieldSubmitted: (value) {
                                GeneralUtils.fieldFocusChange(
                                    context, nameFocusNode, emailFocusNode);
                              },
                            ),
                            SizedBox(
                              height: height * .03,
                            ),
                            //email
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
                                GeneralUtils.fieldFocusChange(context,
                                    emailFocusNode, phoneNumberFocusNode);
                              },
                            ),
                            SizedBox(
                              height: height * .03,
                            ),
                            //phone number
                            TextFormField(
                              focusNode: phoneNumberFocusNode,
                              controller: phoneNumberController,
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return "Phone number cannot be empty";
                                }
                                if (value.length <= 11) {
                                  return "phone number length must be 11";
                                }
                                return null;
                              },
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.phone),
                                border: OutlineInputBorder(),
                                hintText: 'Enter your Phone Number',
                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              onFieldSubmitted: (value) {
                                GeneralUtils.fieldFocusChange(context,
                                    phoneNumberFocusNode, passwordFocusNode);
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
                    title: 'Sign up',
                    onPress: () {
                      if (_formkey.currentState!.validate()) {
                        _signupViewModel.signUp(
                            email: emailController.text,
                            password: passwordController.text,
                            context: context);
                      }
                    }),

                // SizedBox(
                //   height: height * .0,
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginView()));
                        },
                        child: const Text(
                          'Log in',
                          style: TextStyle(
                              color: AppColors.buttonColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ))
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
