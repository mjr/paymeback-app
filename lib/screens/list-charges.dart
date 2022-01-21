import 'package:flutter/material.dart';

class ListChargesScreen extends StatelessWidget {
  const ListChargesScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: TextButton(
        style: TextButton.styleFrom(
          primary: Color(0xFF5DB075),
        ),
        onPressed: () {},
        child: Text('Listar cobranças'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'new-charge');
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}