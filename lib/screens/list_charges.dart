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
        "Adson Melo", 999999999),
    Charge('Festa de Natal', DateTime.now(), DateTime.now(), 220.9,
        "Julio Ferreira", 888888888),
    Charge('Viagem da faculdade', DateTime.now(), DateTime.now(), 39.0,
        "Sergio de Souza", 999999999),
    Charge('Entrada do cinema', DateTime.now(), DateTime.now(), 50.0,
        "Adson Melo", 999999999),
    Charge('Festa de Natal', DateTime.now(), DateTime.now(), 220.9,
        "Julio Ferreira", 888888888),
    Charge('Viagem da faculdade', DateTime.now(), DateTime.now(), 39.0,
        "Sergio de Souza", 999999999),
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

  Widget buildTripCard(BuildContext context, int index) {
    Charge charge = chargeList[index];
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailCharge(charge: charge)));
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                child: Row(
                  children: [
                    Text(
                      charge.title,
                      style: const TextStyle(fontSize: 30),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
                child: Row(
                  children: [
                    Text(
                        "${DateFormat('dd/MM/yyyy').format(charge.startDate).toString()} - ${DateFormat('dd/MM/yyyy').format(charge.endDate).toString()}"),
                    const Spacer(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Row(
                  children: [
                    Text(
                      "\$${charge.value.toStringAsFixed(2)}",
                      style: const TextStyle(fontSize: 35),
                    ),
                    const Spacer(),
                    const Icon(Icons.directions_car),
                    Text(charge.debtor),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
