import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:intl/intl.dart';
import 'package:paymeback/auth/user.dart';
import 'package:paymeback/components/charge_card.dart';
import 'package:paymeback/model/charge.dart';
import 'package:paymeback/screens/detail_charge.dart';

class ListChargesScreen extends StatefulWidget {
  final User user;

  const ListChargesScreen({Key? key, required this.user}) : super(key: key);

  @override
  _ListChargesState createState() => _ListChargesState();
}

class _ListChargesState extends State<ListChargesScreen> {
  final List<Charge> chargeList = [
    Charge('Entrada do cinema', DateTime.now(), DateTime.now(), 50.0,
        "Adson Melo", 84987535387),
    Charge('Festa de Natal', DateTime.now(), DateTime.now(), 220.9,
        "Julio Ferreira", 81999353874),
    Charge('Viagem da faculdade', DateTime.now(), DateTime.now(), 39.0,
        "Sergio de Souza", 83987586386),
    Charge('Entrada do cinema', DateTime.now(), DateTime.now(), 50.0,
        "Adson Melo", 82987535387),
    Charge('Festa de Natal', DateTime.now(), DateTime.now(), 220.9,
        "Julio Ferreira", 81987535497),
    Charge('Viagem da faculdade', DateTime.now(), DateTime.now(), 39.0,
        "Sergio de Souza", 84987535097),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
          title: Row(
        children: [
          Text('Olá, ${widget.user.fullName}'),
          const Spacer(),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "charge-filters");
            },
            icon: const Icon(Icons.filter_alt),
          ),
        ],
      )),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: ListView.builder(
            itemCount: chargeList.length,
            itemBuilder: (BuildContext context, int index) => ChargeCard(
                  charge: chargeList[index],
                )),
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
