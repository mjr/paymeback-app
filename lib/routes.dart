import 'package:flutter/material.dart';

import 'package:paymeback/auth/user.dart';
import 'package:paymeback/screens/splash.dart';
import 'package:paymeback/screens/login.dart';
import 'package:paymeback/screens/home.dart';
import 'package:paymeback/screens/new_charge.dart';

class Routes extends StatelessWidget {
  const Routes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'PayMeBack',
        theme: ThemeData(
            primarySwatch: Colors.green, primaryColor: const Color(0xFF5DB075)),
        initialRoute: 'splash',
        routes: {
          'splash': (context) => const SplashScreen(),
          'login': (context) => const LoginScreen(),
          'home': (context) => HomeScreen(
              user: ModalRoute.of(context)!.settings.arguments as User),
          'new-charge': (context) => const NewChargeScreen(),
        });
  }
}
