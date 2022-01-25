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
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0, bottom: 2.0),
                      child: Text('E-mail'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        autofocus: true,
                        onChanged: (value) {},
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.email,
                              color: Color.fromRGBO(50, 62, 72, 1.0)),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                    ),
                    Input(
                        label: "Título",
                        icon: Icons.title,
                        onChanged: (value) {},
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor digite um título';
                          }
                          return null;
                        }),
                    Input(
                        label: "Nome do devedor",
                        icon: Icons.account_circle,
                        onChanged: (value) {},
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor digite o nome do devedor';
                          }
                          return null;
                        }),
                    Input(
                        label: "Data do empréstimo",
                        icon: Icons.today,
                        onChanged: (value) {},
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor digite a data do empréstimo';
                          }
                          return null;
                        }),
                    Input(
                        label: "Data a receber",
                        icon: Icons.event,
                        onChanged: (value) {},
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor digite a data a receber';
                          }
                          return null;
                        }),
                    Input(
                        label: "Valor",
                        icon: Icons.paid,
                        onChanged: (value) {},
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor digite o valor';
                          }
                          return null;
                        }),
                    Input(
                        label: "Telefone",
                        icon: Icons.phone,
                        onChanged: (value) {},
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor digite um telefone';
                          }
                          return null;
                        }),
                    Input(
                      label: "Detalhes",
                      icon: Icons.description,
                      onChanged: (value) {},
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Process data.
                          }
                        },
                        child: const Text('Salvar'),
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
