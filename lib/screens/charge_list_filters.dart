import 'package:flutter/material.dart';
import 'package:paymeback/components/input.dart';
import 'package:paymeback/components/input_range.dart';

class ChargeListFilterScreen extends StatefulWidget {
  const ChargeListFilterScreen({Key? key}) : super(key: key);

  @override
  _ChargeListFilterState createState() => _ChargeListFilterState();
}

class _ChargeListFilterState extends State<ChargeListFilterScreen> {
  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Filtros"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Expanded(
                child: Column(
                  children: [
                    Input(
                        label: "Nome",
                        hintText: "Digite o nome do devedor",
                        onChanged: (value) {}),
                    Input(
                        label: "Telefone",
                        hintText: "Digite o telefone do devedor",
                        icon: Icons.account_circle,
                        onChanged: (value) {}),
                    InputRange(
                        label: "Valor da cobrança",
                        hintText: "R\$ 0,00",
                        onChanged1: (value) {},
                        onChanged2: (value) {}),
                    InputRange(
                        label: "Data de recebimento",
                        hintText: "dd/mm/yyyy",
                        icon: Icons.event,
                        onChanged1: (value) {},
                        onChanged2: (value) {}),
                    // Expanded(
                    // child:
                    Row(
                      children: [
                        Expanded(
                          child: MaterialButton(
                            onPressed: () {},
                            textColor: const Color(0xFF5DB075),
                            height: 51,
                            child: const Text('Resetar',
                                textAlign: TextAlign.center),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100))),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: MaterialButton(
                            onPressed: () {},
                            textColor: Colors.white,
                            color: const Color(0xFF5DB075),
                            child: const Text('Filtrar',
                                textAlign: TextAlign.center),
                            height: 51,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100))),
                          ),
                        ),
                      ],
                    ),
                    // )
                  ],
                ),
              )),
        ));
  }
}
