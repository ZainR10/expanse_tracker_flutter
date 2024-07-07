import 'package:expanse_tracker_flutter/utils/general_utils.dart';
import 'package:expanse_tracker_flutter/view/varification_code_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerificationViewModel with ChangeNotifier {
  bool _verificationLoading = false;
  bool get verificationLoading => _verificationLoading;

  void setverificationLoading(bool value) {
    _verificationLoading = value;
    notifyListeners();
  }

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> verification({
    required TextEditingController phoneController,
    required BuildContext context,
  }) async {
    setverificationLoading(true);

    _auth
        .verifyPhoneNumber(
      phoneNumber: phoneController.text.toString(),
      verificationCompleted: (_) {
        // Handle automatic verification completed
      },
      verificationFailed: (e) {
        setverificationLoading(false);
        GeneralUtils.snackBar(e.toString(), context);
        print('$GeneralUtils.snackBar(e.toString(), context)');
      },
      codeSent: (String verificationId, int? token) {
        setverificationLoading(false);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                VarificationCodeView(verificationId: verificationId),
          ),
        );
      },
      codeAutoRetrievalTimeout: (e) {
        setverificationLoading(false);
        print('$GeneralUtils.snackBar(e.toString(), context)');

        GeneralUtils.snackBar(e.toString(), context);
      },
    )
        .then((value) {
      setverificationLoading(false);
    }).catchError((error) {
      setverificationLoading(false);
      print('$GeneralUtils.snackBar(error.toString(), context)');
      GeneralUtils.snackBar(error.toString(), context);
    });
  }
}
