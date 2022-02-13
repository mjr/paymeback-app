import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:paymeback/components/input.dart';
import 'package:paymeback/components/input_range.dart';
import 'package:paymeback/model/charge_filters.dart';
import 'package:paymeback/utils/masks.dart';

class ChargeListFilterScreen extends StatefulWidget {
  ChargeFilters previousFilters;
  Function updateFilters;
  Function loadCharges;

  ChargeListFilterScreen(
      {Key? key,
      required this.previousFilters,
      required this.updateFilters,
      required this.loadCharges})
      : super(key: key);

  @override
  _ChargeListFilterState createState() => _ChargeListFilterState();
}

class _ChargeListFilterState extends State<ChargeListFilterScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _isError = false;
  late ChargeFilters _innerFilters;

  @override
  void initState() {
    _innerFilters = widget.previousFilters;
    super.initState();
  }

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
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
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
                          initalValue: _innerFilters.debtor,
                          onChanged: (value) {
                            setState(() {
                              _innerFilters.debtor = value;
                            });
                          }),
                      Input(
                          label: "Telefone",
                          hintText: "Digite o telefone do devedor",
                          inputFormatters: [
                            MaskedInputFormatter('(##)#####-####'),
                          ],
                          initalValue: _innerFilters.phoneNumber,
                          onChanged: (value) {
                            setState(() {
                              _innerFilters.phoneNumber =
                                  sanitizePhoneNumber(value);
                            });
                          }),
                      InputRange(
                        label: "Valor da cobrança",
                        hintText: "R\$ 0,00",
                        initalValue1: _innerFilters.fromValue,
                        initalValue2: _innerFilters.untilValue,
                        inputFormatters: [
                          MoneyInputFormatter(
                            leadingSymbol: "R\$",
                            useSymbolPadding: true,
                            thousandSeparator: ThousandSeparator.Period,
                          )
                        ],
                        onChanged1: (value) {
                          setState(() {
                            _innerFilters.fromValue = value;
                          });
                        },
                        onChanged2: (value) {
                          setState(() {
                            _innerFilters.untilValue = value;
                          });
                        },
                      ),
                      InputRange(
                          label: "Data de recebimento",
                          hintText: "dd/mm/aa",
                          icon: const Icon(Icons.calendar_today,
                              color: Color(0xFFBDBDBD)),
                          initalValue1: _innerFilters.fromEndDate.toString(),
                          initalValue2: _innerFilters.untilEndDate.toString(),
                          onChanged1: (value) {
                            setState(() {
                              _innerFilters.fromEndDate =
                                  DateTime.parse(value).toString();
                            });
                          },
                          onChanged2: (value) {
                            setState(() {
                              _innerFilters.untilEndDate =
                                  DateTime.parse(value).toString();
                            });
                          }),
                      Row(
                        children: [
                          Expanded(
                            child: MaterialButton(
                              onPressed: () {
                                _formKey.currentState?.reset();
                                _innerFilters.reset();
                                widget.updateFilters(_innerFilters);
                              },
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
                              onPressed: () async {
                                setState(() {
                                  _isLoading = true;
                                });
                                try {
                                  widget.updateFilters(_innerFilters);
                                  await widget.loadCharges(_innerFilters);
                                  Navigator.pop(context);
                                } catch (err) {
                                  if (kDebugMode) {
                                    print(err);
                                  }
                                  setState(() {
                                    _isError = true;
                                    true;
                                  });
                                } finally {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                }
                              },
                              textColor: Colors.white,
                              color: const Color(0xFF5DB075),
                              child: Text(
                                  _isLoading ? 'Filtrando...' : 'Filtrar',
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
          ),
        ));
  }
}
