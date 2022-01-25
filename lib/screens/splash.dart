import 'package:flutter/material.dart';

import 'package:paymeback/auth/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = AuthProvider();
    auth.currentUser(context);

    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Stack(
        children: [
          Center(child: Image.asset('assets/images/union.png')),
          Center(child: Image.asset('assets/images/logofull.png')),
        ],
      ),
    );
  }
}