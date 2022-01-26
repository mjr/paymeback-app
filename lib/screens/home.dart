import 'package:flutter/material.dart';
import 'package:paymeback/auth/user.dart';
import 'package:paymeback/screens/list_charges.dart';
import 'package:paymeback/screens/profile.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  const HomeScreen({Key? key, required this.user}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget getCurrentScreen() {
    List<Widget> screens = [
      ListChargesScreen(
        user: widget.user,
      ),
      const ProfileScreen()
    ];
    return screens[currentScreenIndex];
  }

  var currentScreenIndex = 0;

  void setScreen(int index) {
    currentScreenIndex = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getCurrentScreen(),
      bottomNavigationBar: SizedBox(
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
                  color: currentScreenIndex == 0
                      ? const Color(0xFF5DB075)
                      : const Color(0xFF706E7A),
                )),
            IconButton(
                onPressed: () {
                  setScreen(1);
                  setState(() {});
                },
                icon: Icon(
                  Icons.insert_chart_outlined_outlined,
                  color: currentScreenIndex == 1
                      ? const Color(0xFF5DB075)
                      : const Color(0xFF706E7A),
                ))
          ],
        ),
      ),
    );
  }
}
