import 'package:expanse_tracker_flutter/View_Models/authentication_view_models/signup_firebase_logic.dart';
import 'package:expanse_tracker_flutter/components/custom_textfield.dart';
import 'package:expanse_tracker_flutter/components/round_button.dart';
import 'package:expanse_tracker_flutter/components/text_widget.dart';
import 'package:expanse_tracker_flutter/utils/validate.dart';
import 'package:expanse_tracker_flutter/utils/general_utils.dart';
import 'package:expanse_tracker_flutter/utils/routes/routes_name.dart';
import 'package:expanse_tracker_flutter/widgets/appbar.dart';
import 'package:flutter/foundation.dart';
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
    if (kDebugMode) {
      print('build');
    }
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
          preferredSize: Size(0, 45),
          child: ReuseableAppBar(
            appBarTitle: 'Create Account',
          )),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                SizedBox(
                  height: height * .03,
                ),
                Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      //name
                      CustomTextfield(
                          textStore: nameController,
                          keyboardType: TextInputType.emailAddress,
                          textFieldIcon: const Icon(Icons.person),
                          textsize: 20,
                          lebaltitle: 'Enter your name',
                          validator: FormValidation.validateName,
                          onfieldSubmission: (value) {
                            GeneralUtils.fieldFocusChange(
                                context, nameFocusNode, emailFocusNode);
                          }),

                      //email
                      CustomTextfield(
                          textStore: emailController,
                          keyboardType: TextInputType.emailAddress,
                          textFieldIcon: const Icon(Icons.alternate_email),
                          textsize: 20,
                          lebaltitle: 'Enter your email',
                          validator: FormValidation.validateEmail,
                          onfieldSubmission: (value) {
                            GeneralUtils.fieldFocusChange(
                                context, emailFocusNode, phoneNumberFocusNode);
                          }),

                      //phone number
                      CustomTextfield(
                          textStore: phoneNumberController,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true, signed: true),
                          textFieldIcon: const Icon(Icons.phone),
                          textsize: 20,
                          lebaltitle: 'Enter your phone number',
                          validator: FormValidation.validatePhoneNumber,
                          onfieldSubmission: (value) {
                            GeneralUtils.fieldFocusChange(context,
                                phoneNumberFocusNode, passwordFocusNode);
                          }),

                      //password
                      CustomTextfield(
                        textStore: passwordController,
                        keyboardType: TextInputType.emailAddress,
                        textFieldIcon: const Icon(Icons.lock),
                        textsize: 20,
                        lebaltitle: 'Enter your password',
                        validator: FormValidation.validatePassword,
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
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                            name: nameController.text.trim(),
                            phone: phoneNumberController.text.trim(),
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
                      text: 'Already have an account?',
                      textSize: 20,
                      textWeight: FontWeight.bold,
                    ),
                    // const Text(
                    //   "Already have an account?",
                    //   style:
                    //       TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                    // ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RoutesName.loginView);
                      },
                      child: const CustomText(
                        text: 'Login',
                        textSize: 20,
                        textWeight: FontWeight.bold,
                        textColor: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
