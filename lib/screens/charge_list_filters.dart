import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:paymeback/components/input.dart';
import 'package:paymeback/components/input_range.dart';

class ChargeListFilterScreen extends StatefulWidget {
  const ChargeListFilterScreen({Key? key}) : super(key: key);

  @override
  _ChargeListFilterState createState() => _ChargeListFilterState();
}

class _ChargeListFilterState extends State<ChargeListFilterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xFFFFFFFF),
          leading: const BackButton(color: Color(0xFFB1B0B8)),
          title: const Text(
            "Filtros",
            style: TextStyle(color: Color(0xFF5DB075)),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: Expanded(
                child: Column(
                  children: [
                    Input(
                        label: "Nome",
                        hintText: "Digite o nome do devedor",
                        icon: const Icon(Icons.perm_contact_calendar,
                            color: Color(0xFFBDBDBD)),
                        onChanged: (value) {}),
                    Input(
                        label: "Telefone",
                        hintText: "Digite o telefone do devedor",
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          MaskedInputFormatter('(##)#####-####'),
                        ],
                        onChanged: (value) {}),
                    InputRange(
                        label: "Valor da cobrança",
                        hintText: "R\$ 0,00",
                        inputFormatters: [
                          MoneyInputFormatter(
                            leadingSymbol: "R\$",
                            useSymbolPadding: true,
                            thousandSeparator: ThousandSeparator.Period,
                          )
                        ],
                        onChanged1: (value) {},
                        onChanged2: (value) {}),
                    InputRange(
                        label: "Data de recebimento",
                        hintText: "dd/mm/aa",
                        icon: const Icon(Icons.calendar_today,
                            color: Color(0xFFBDBDBD)),
                        onChanged1: (value) {},
                        onChanged2: (value) {}),
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
                  ],
                ),
              )),
        ));
  }
}
