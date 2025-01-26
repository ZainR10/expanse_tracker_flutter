import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SystemBackButtonPress extends StatelessWidget {
  final Widget child;
  final bool shouldExitApp;
  final GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey;
  static DateTime? lastBackPressed; // Retain across builds

  const SystemBackButtonPress({
    this.scaffoldMessengerKey,
    required this.shouldExitApp,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        final now = DateTime.now();

        if (lastBackPressed == null ||
            now.difference(lastBackPressed!) > const Duration(seconds: 2)) {
          lastBackPressed = now;

          // Show SnackBar with a custom message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Press again to exit'),
              duration: Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.red,
              showCloseIcon: true,
            ),
          );
          return; // Do not exit yet
        }

        // Allow app to exit
        if (shouldExitApp) {
          SystemNavigator.pop(); // Close the app
          return; // Allow exit
        }

        return; // Continue normal back navigation
      },
      child: child,
    );
  }
}
