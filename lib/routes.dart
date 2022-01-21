import 'package:flutter/material.dart';

import 'package:paymeback/auth/user.dart';
import 'package:paymeback/screens/splash.dart';
import 'package:paymeback/screens/login.dart';
import 'package:paymeback/screens/home.dart';
import 'package:paymeback/screens/new-charge.dart';

class Routes extends StatelessWidget {
  const Routes({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Paymeback',
      theme: ThemeData(primarySwatch: Colors.green, primaryColor: Color(0xFF5DB075)),
      initialRoute: 'splash',
      routes: {
        'splash': (context) => SplashScreen(),
        'login': (context) => LoginScreen(),
        'home': (context) => HomeScreen(user: ModalRoute.of(context)!.settings.arguments as User),
        'new-charge': (context) => NewChargeScreen(),
      }
    );
  }
}