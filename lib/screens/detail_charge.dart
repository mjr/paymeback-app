import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:paymeback/model/charge.dart';

class DetailChargeScreen extends StatelessWidget {
  final Charge charge;

  const DetailChargeScreen({Key? key, required this.charge}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xFFFFFFFF),
          leading: const BackButton(color: Color(0xFFB1B0B8)),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 56, vertical: 24),
                ),
                const Text(
                  'Título',
                  textAlign: TextAlign.left,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                ),
                Text(
                  charge.title,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 20),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                ),
                const Text(
                  'Nome',
                  textAlign: TextAlign.left,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                ),
                Text(
                  charge.debtor,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 20),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                ),
                Row(
                  children: [
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Data do empréstimo',
                          textAlign: TextAlign.left,
                        ),
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                        ),
                        Text(
                          DateFormat('dd/MM/aaaa').format(charge.startDate),
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                        ),
                      ],
                    )),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat('dd/MM/aaaa').format(charge.endDate),
                          textAlign: TextAlign.left,
                        ),
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                        ),
                        const Text(
                          '10/12/2022',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                        ),
                      ],
                    )),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                ),
                Row(
                  children: [
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Valor',
                          textAlign: TextAlign.left,
                        ),
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                        ),
                        Text(
                          NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$')
                              .format(charge.value)
                              .toString(),
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                        ),
                      ],
                    )),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Telefone',
                          textAlign: TextAlign.left,
                        ),
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                        ),
                        Text(
                          charge.phoneNumber.toString(),
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                        ),
                      ],
                    )),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                ),
                const Text(
                  'Detalhes',
                  textAlign: TextAlign.left,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                ),
                const Text(
                  'Labore sunt veniam amet est. Minim nisi dolor eu ad incididunt cillum elit ex ut. Dolore exercitation nulla tempor consequat aliquip occaecat. Nisi id ipsum irure aute. Deserunt ',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton:
            Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.green,
            child: const Icon(Icons.delete),
          ),
          const SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.green,
            child: const Icon(Icons.share),
          )
        ]));
  }
}
