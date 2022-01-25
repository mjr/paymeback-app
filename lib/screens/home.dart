import 'package:flutter/material.dart';

import 'package:paymeback/auth/user.dart';
import 'package:paymeback/screens/list-charges.dart';
import 'package:paymeback/screens/profile.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  const HomeScreen({ Key? key, required this.user }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final screens = [ListChargesScreen(), ProfileScreen()];

  var currentScreen = 0;

  void setScreen(int index) {
    currentScreen = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Olá, ${widget.user.fullName}'),
      ),
      body: screens[currentScreen],
      bottomNavigationBar: Container(
        height: 90,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                setScreen(0);
                setState(() {});
              },
              icon: Icon(
                Icons.home,
                color: currentScreen == 0 ? Color(0xFF5DB075) : Color(0xFF706E7A),
              )
            ),
            IconButton(
              onPressed: () {
                setScreen(1);
                setState(() {});
              },
              icon: Icon(
                Icons.insert_chart_outlined_outlined,
                color: currentScreen == 1 ? Color(0xFF5DB075) : Color(0xFF706E7A),
              )
            )
          ],
        ),
      ),
    );
  }
}