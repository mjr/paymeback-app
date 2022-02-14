import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:paymeback/auth/provider.dart';
import 'package:paymeback/model/charge.dart';
import 'package:paymeback/utils/client.dart';

Future<Map<String, dynamic>> fetchData() async {
  final response = await Client().get('insights');

  return {
    'lateAmount': 'R\$ ${response["lateAmount"]}',
    'totalAmountBorrowed': 'R\$ ${response["totalAmountBorrowed"]}',
    'charges': response["charges"]
        .map<Charge>((charge) => Charge.fromJson(charge))
        .toList()
  };
}

class Insight extends StatefulWidget {
  @override
  _InsightState createState() => _InsightState();
}

class _InsightState extends State<Insight> {
  final Future<Map<String, dynamic>> _initialization = fetchData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        appBar: AppBar(
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 40),
              const Text('Insights', textAlign: TextAlign.center),
              IconButton(
                  onPressed: () {
                    final auth = AuthProvider();
                    auth.setUser(context, null);
                  },
                  icon: const Icon(Icons.logout))
            ],
          ),
        ),
        body: FutureBuilder(
            future: _initialization,
            builder: (BuildContext ctx, AsyncSnapshot<Map> snapshot) {
              if (snapshot.hasError) {
                return const Material(
                  child: Center(
                    child: Text('Não foi possível carregar os dados',
                        textDirection: TextDirection.ltr),
                  ),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                return Padding(
                  padding: const EdgeInsets.only(top: 36, left: 16, right: 16),
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          height: 196,
                          width: 196,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(100)),
                            border: Border.all(
                                width: 3,
                                color: const Color(0xFFE8E8E8),
                                style: BorderStyle.solid),
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  snapshot.data!['lateAmount'],
                                  style: GoogleFonts.inter(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.red),
                                ),
                                Text(
                                  snapshot.data!['totalAmountBorrowed'],
                                  style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: const Color(0xFFBDBDBD)),
                                )
                              ]),
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.only(top: 20),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Detalhes',
                                    style: GoogleFonts.inter(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  ),
                                ),
                                const SizedBox(height: 16),
                              ])),
                      Expanded(
                        child: ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemCount: snapshot.data!['charges'].length,
                            itemBuilder: (BuildContext context, index) {
                              Color color;
                              if (snapshot.data!['charges'][index].isLate) {
                                color = const Color(0xFFFF0000);
                              } else if (!snapshot
                                  .data!['charges'][index].paid) {
                                color = const Color(0xFF000000);
                              } else {
                                color = const Color(0xFF5DB075);
                              }
                              return Container(
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        width: 1.0, color: Color(0xFFE8E8E8)),
                                  ),
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                          child: Row(children: [
                                        Container(
                                          margin:
                                              const EdgeInsets.only(right: 14),
                                          width: 16,
                                          height: 16,
                                          decoration: BoxDecoration(
                                              color: color,
                                              shape: BoxShape.circle),
                                        ),
                                        Expanded(
                                          child: Text(
                                            snapshot
                                                .data!['charges'][index].debtor,
                                            style: GoogleFonts.inter(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ])),
                                      Text(
                                        'R\$ ${snapshot.data!['charges'][index].value}',
                                        textAlign: TextAlign.right,
                                        style: GoogleFonts.inter(
                                            fontSize: 14, color: color),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      )
                    ],
                  ),
                );
              } else {
                return const Material(
                    child: Center(child: CircularProgressIndicator()));
              }
            }));
  }
}
