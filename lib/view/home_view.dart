import 'package:expanse_tracker_flutter/utils/general_utils.dart';
import 'package:expanse_tracker_flutter/view/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('home'),
        actions: [
          IconButton(
              onPressed: () {
                auth.signOut().then((value) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginView()));
                }).onError((error, stackTrace) {
                  GeneralUtils.snackBar(error.toString(), context);
                });
              },
              icon: const Icon(Icons.logout_outlined))
        ],
      ),
    );
  }
}
