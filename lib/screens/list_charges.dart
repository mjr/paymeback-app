import 'package:flutter/material.dart';
import 'package:paymeback/components/charge_card.dart';

class ListChargesScreen extends StatelessWidget {
  const ListChargesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: TextButton(
        style: TextButton.styleFrom(
          primary: const Color(0xFF5DB075),
        ),
        onPressed: () {},
        child: ListView(
          scrollDirection: Axis.vertical,
          children: const [
            ChargeCard(
              debtorName: "Artur Santiago",
              endDate: "10/10/2022",
              title: "Lanche da Tarde",
              value: 20.34,
            ),
            ChargeCard(
              debtorName: "Artur Santiago",
              endDate: "10/10/2022",
              title: "Lanche da Tarde",
              value: 20.34,
            ),
            ChargeCard(
              debtorName: "Artur Santiago",
              endDate: "10/10/2022",
              title: "Lanche da Tarde",
              value: 20.34,
            ),
            ChargeCard(
              debtorName: "Artur Santiago",
              endDate: "10/10/2022",
              title: "Lanche da Tarde",
              value: 20.34,
            ),
            ChargeCard(
              debtorName: "Artur Santiago",
              endDate: "10/10/2022",
              title: "Lanche da Tarde",
              value: 20.34,
            ),
            ChargeCard(
              debtorName: "Artur Santiago",
              endDate: "10/10/2022",
              title: "Lanche da Tarde",
              value: 20.34,
            ),
            ChargeCard(
              debtorName: "Artur Santiago",
              endDate: "10/10/2022",
              title: "Lanche da Tarde",
              value: 20.34,
            ),
            ChargeCard(
              debtorName: "Artur Santiago",
              endDate: "10/10/2022",
              title: "Lanche da Tarde",
              value: 20.34,
            ),
            ChargeCard(
              debtorName: "Artur Santiago",
              endDate: "10/10/2022",
              title: "Lanche da Tarde",
              value: 20.34,
            ),
            ChargeCard(
              debtorName: "Artur Santiago",
              endDate: "10/10/2022",
              title: "Lanche da Tarde",
              value: 20.34,
            ),
            ChargeCard(
              debtorName: "Artur Santiago",
              endDate: "10/10/2022",
              title: "Lanche da Tarde",
              value: 20.34,
            ),
            ChargeCard(
              debtorName: "Artur Santiago",
              endDate: "10/10/2022",
              title: "Lanche da Tarde",
              value: 20.34,
            ),
            ChargeCard(
              debtorName: "Artur Santiago",
              endDate: "10/10/2022",
              title: "Lanche da Tarde",
              value: 20.34,
            ),
            ChargeCard(
              debtorName: "Artur Santiago",
              endDate: "10/10/2022",
              title: "Lanche da Tarde",
              value: 20.34,
            )
          ],
        ),
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
