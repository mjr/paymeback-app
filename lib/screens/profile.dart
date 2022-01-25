import 'package:flutter/material.dart';

import 'package:paymeback/auth/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: TextButton(
        style: TextButton.styleFrom(
          primary: const Color(0xFF5DB075),
        ),
        onPressed: () {
          final auth = AuthProvider();
          auth.setUser(context, null);
        },
        child: const Text('Sair'),
      ),
    );
  }
}
