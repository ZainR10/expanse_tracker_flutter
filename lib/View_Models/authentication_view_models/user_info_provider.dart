import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String _name = '';
  String _email = '';
  String _profilePic = '';

  String get name => _name;
  String get email => _email;
  String get profilePic => _profilePic;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> fetchUserData() async {
    User? user = _auth.currentUser;

    if (user != null) {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(user.uid).get();

      if (userDoc.exists) {
        _name = userDoc['name'] ?? '';
        _email = userDoc['email'] ?? '';
        _profilePic = userDoc['profilePic'] ?? '';

        notifyListeners();
      }
    }
  }
}
