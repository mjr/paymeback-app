import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:paymeback/auth/provider.dart';
import 'package:paymeback/model/charge.dart';
import 'package:paymeback/screens/charge_form.dart';
import 'package:paymeback/utils/client.dart';
import 'package:paymeback/utils/masks.dart';
import 'package:paymeback/utils/share_charge.dart';

class DetailChargeScreen extends StatefulWidget {
  final Charge charge;
  const DetailChargeScreen({Key? key, required this.charge}) : super(key: key);

  @override
  _DetailChargeScreenState createState() => _DetailChargeScreenState();
}

class _DetailChargeScreenState extends State<DetailChargeScreen> {
  final auth = AuthProvider();
  final client = Client();
  bool _isLoading = false;
  bool _isError = false;

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
                  widget.charge.title,
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
                  widget.charge.debtor,
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
                          DateFormat('dd/MM/yyyy')
                              .format(widget.charge.startDate),
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
                        const Text("Data a receber"),
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                        ),
                        Text(
                          DateFormat('dd/MM/yyyy')
                              .format(widget.charge.endDate),
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
                              .format(widget.charge.value)
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
                          formatPhoneNumber(widget.charge.phoneNumber),
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                        ),
                      ],
                    )),
                  ],
                ),
                widget.charge.description == null ||
                        widget.charge.description == ""
                    ? const SizedBox()
                    : Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 15),
                          ),
                          const Text(
                            'Detalhes',
                            textAlign: TextAlign.left,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 5),
                          ),
                          Text(
                            widget.charge.description ?? '',
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 20),
                          ),
                        ],
                      )
              ],
            ),
          ),
        ),
        floatingActionButton:
            Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          FloatingActionButton(
            heroTag: "Editar",
            onPressed: () {
              if (_isLoading) return;

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ChargeFormScreen(charge: widget.charge)));
            },
            backgroundColor: Colors.green,
            child: const Icon(Icons.edit),
          ),
          const SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            heroTag: "Remover",
            onPressed: () async {
              removeCharge();
            },
            backgroundColor: Colors.green,
            child: const Icon(Icons.delete),
          ),
          const SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            heroTag: "Compartilhar",
            onPressed: () {
              if (_isLoading) return;

              shareCharge(context, widget.charge);
            },
            backgroundColor: Colors.green,
            child: const Icon(Icons.share),
          )
        ]));
  }

  void removeCharge() async {
    try {
      if (_isLoading) return;

      FocusScope.of(context).requestFocus(FocusNode());
      setState(() {
        _isError = false;
        _isLoading = true;
      });

      await client.delete('charges/${widget.charge.id}');
      final user = await auth.getUser();
      Navigator.pushReplacementNamed(context, 'home', arguments: user);
      setState(() {
        _isError = false;
      });
    } catch (err) {
      setState(() {
        _isError = true;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
