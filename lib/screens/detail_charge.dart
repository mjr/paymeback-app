import 'package:flutter/material.dart';
import 'package:paymeback/model/charge.dart';

class DetailCharge extends StatelessWidget {
  final Charge charge;

  const DetailCharge({Key? key, required this.charge}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: <Widget>[
            const SliverAppBar(
              title: Text("Detalhes da cobrança"),
              backgroundColor: Colors.green,
              expandedHeight: 350,
            ),
            SliverFixedExtentList(
                delegate: SliverChildListDelegate(
                    [Text(charge.title), Text(charge.value.toString())]),
                itemExtent: 200)
          ],
        ),
      ),
    );
  }
}
