import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:paymeback/components/input.dart';

class NewChargeScreen extends StatefulWidget {
  const NewChargeScreen({Key? key}) : super(key: key);

  @override
  _NewChargeScreenState createState() => _NewChargeScreenState();
}

class _NewChargeScreenState extends State<NewChargeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 56, vertical: 24),
                child: Text(
                  "Preencha os dados da cobrança",
                  style: GoogleFonts.lexendDeca(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF585666),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Input(
                        label: "Título",
                        hintText: "Digite o título do empréstimo",
                        onChanged: (value) {},
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor digite um título';
                          }
                          return null;
                        }),
                    Input(
                        label: "Nome",
                        hintText: 'Digite o nome do devedor',
                        icon: Icons.account_circle,
                        onChanged: (value) {},
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor digite o nome do devedor';
                          }
                          return null;
                        }),
                    Row(
                      children: [
                        Expanded(
                          child: Input(
                              label: "Data do empréstimo",
                              hintText: 'dd/mm/aa',
                              icon: Icons.today,
                              keyboardType: TextInputType.datetime,
                              onChanged: (value) {},
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor digite a data do empréstimo';
                                }
                                return null;
                              }),
                        ),
                        Expanded(
                            child: Input(
                                label: "Data a receber",
                                hintText: 'dd/mm/aa',
                                icon: Icons.event,
                                keyboardType: TextInputType.datetime,
                                onChanged: (value) {},
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor digite a data a receber';
                                  }
                                  return null;
                                }))
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Input(
                              label: "Valor",
                              icon: Icons.attach_money,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {},
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor digite o valor';
                                }
                                return null;
                              }),
                        ),
                        Expanded(
                          child: Input(
                              label: "Telefone",
                              hintText: '(xx) xxxxx-xxxx',
                              keyboardType: TextInputType.phone,
                              onChanged: (value) {},
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor digite um telefone';
                                }
                                return null;
                              }),
                        )
                      ],
                    ),
                    Input(
                      label: "Detalhes",
                      hintText: 'Digite os detalhes do empréstimo',
                      maxLines: 8,
                      onChanged: (value) {},
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4, bottom: 16),
                      child: MaterialButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Process data.
                          }
                        },
                        textColor: Colors.white,
                        color: const Color(0xFF5DB075),
                        height: 51,
                        minWidth: 200,
                        child:
                            const Text('Salvar', textAlign: TextAlign.center),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(100))),
                      ),
                    ),
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
