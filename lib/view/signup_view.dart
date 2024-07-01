import 'package:expanse_tracker_flutter/View_Models/signup_firebase_logic.dart';
import 'package:expanse_tracker_flutter/View_Models/validate.dart';
import 'package:expanse_tracker_flutter/res/components/colors.dart';
import 'package:expanse_tracker_flutter/res/components/round_button.dart';
import 'package:expanse_tracker_flutter/utils/general_utils.dart';
import 'package:expanse_tracker_flutter/view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
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
    print('build');
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
              Form(
                key: _formkey,
                child: Column(
                  children: [
                    //name
                    TextFormField(
                      focusNode: nameFocusNode,
                      controller: nameController,
                      validator: FormValidation.validateName,
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
                      validator: FormValidation.validateEmail,
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
                            context, emailFocusNode, phoneNumberFocusNode);
                      },
                    ),
                    SizedBox(
                      height: height * .03,
                    ),
                    //phone number
                    TextFormField(
                      focusNode: phoneNumberFocusNode,
                      controller: phoneNumberController,
                      validator: FormValidation.validatePhoneNumber,
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
                        GeneralUtils.fieldFocusChange(
                            context, phoneNumberFocusNode, passwordFocusNode);
                      },
                    ),
                    SizedBox(
                      height: height * .03,
                    ),
                    //password
                    TextFormField(
                      focusNode: passwordFocusNode,
                      controller: passwordController,
                      validator: FormValidation.validatePassword,
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
                ),
              ),
              Consumer<SignUpViewModel>(
                builder: (context, value, child) {
                  return RoundButton(
                    title: 'Sign up',
                    loading: value.signUpLoading,
                    onPress: () {
                      if (_formkey.currentState!.validate()) {
                        value.signUp(
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
                  const Text(
                    "Already have an account?",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginView(),
                        ),
                      );
                    },
                    child: const Text(
                      'Log in',
                      style: TextStyle(
                        color: AppColors.buttonColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
