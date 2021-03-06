// ignore: import_of_legacy_library_into_null_safe
import 'package:contact_picker/contact_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:intl/intl.dart';
import 'package:paymeback/auth/provider.dart';
import 'package:paymeback/model/charge.dart';
import 'package:paymeback/utils/client.dart';
import 'package:paymeback/utils/get_contact.dart';
import 'package:paymeback/utils/masks.dart';

class ChargeFormScreen extends StatefulWidget {
  final Charge? charge;

  const ChargeFormScreen({Key? key, this.charge}) : super(key: key);

  @override
  _ChargeFormScreenState createState() => _ChargeFormScreenState();
}

class _ChargeFormScreenState extends State<ChargeFormScreen> {
  final auth = AuthProvider();
  final client = Client();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late Map<String, dynamic> formCharge;

  final TextEditingController _loanDateInput = TextEditingController();
  final TextEditingController _dateToReceiveInput = TextEditingController();
  final TextEditingController _debtorInput = TextEditingController();
  final TextEditingController _phoneNumberInput = TextEditingController();
  bool _isLoading = false;
  bool _isError = false;

  Map<String, dynamic> chargeToForm(Charge? charge) {
    return {
      'id': charge?.id?.toString() ?? "",
      'title': charge?.title ?? "",
      'startDate': charge?.startDate,
      'endDate': charge?.endDate,
      'value': charge?.value != null ? convertDoubleToMoney(charge!.value) : "",
      'debtor': charge?.debtor ?? "",
      'phoneNumber': charge?.phoneNumber.toString() ?? "",
      'paid': charge?.paid.toString() ?? "",
      'description': charge?.description ?? "",
    };
  }

  @override
  void initState() {
    formCharge = chargeToForm(widget.charge);

    _loanDateInput.text = formCharge['startDate'] != null
        ? DateFormat('dd/MM/yyyy').format(formCharge['startDate'])
        : '';
    _dateToReceiveInput.text = formCharge['endDate'] != null
        ? DateFormat('dd/MM/yyyy').format(formCharge['endDate'])
        : '';

    _debtorInput.text = formCharge['debtor'] ?? '';
    _phoneNumberInput.text = formCharge['phoneNumber'] ?? '';

    formCharge['startDate'] = formCharge['startDate'].toString();
    formCharge['endDate'] = formCharge['endDate'].toString();
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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 56, vertical: 4),
                child: Text(
                  "Preencha os dados da cobran??a",
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text('T??tulo',
                          style: TextStyle(color: Color(0xFF666666))),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        autofocus: true,
                        initialValue: formCharge['title'],
                        onChanged: (value) {
                          setState(() {
                            formCharge['title'] = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Digite o  t??tulo do empr??stimo',
                          hintStyle: const TextStyle(color: Color(0xFFBDBDBD)),
                          contentPadding: const EdgeInsets.all(16),
                          filled: true,
                          fillColor: const Color(0xFFF6F6F6),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: const BorderSide(
                              color: Color(0xFFE8E8E8),
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: const BorderSide(
                              color: Color(0xFF5DB075),
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text('Nome do devedor',
                          style: TextStyle(color: Color(0xFF666666))),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _debtorInput,
                        onChanged: (value) {
                          setState(() {
                            formCharge['debtor'] = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Digite o nome do devedor',
                          hintStyle: const TextStyle(color: Color(0xFFBDBDBD)),
                          contentPadding: const EdgeInsets.all(16),
                          filled: true,
                          fillColor: const Color(0xFFF6F6F6),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: const BorderSide(
                              color: Color(0xFFE8E8E8),
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: const BorderSide(
                              color: Color(0xFF5DB075),
                              width: 2.0,
                            ),
                          ),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.perm_contact_calendar,
                                color: Color(0xFFBDBDBD)),
                            onPressed: () async {
                              Contact? selectedContact =
                                  await openContactBook();

                              if (selectedContact != null) {
                                setState(() {
                                  formCharge['debtor'] =
                                      selectedContact.fullName;
                                  _debtorInput.text = selectedContact.fullName;
                                  formCharge['phoneNumber'] = formatPhoneNumber(
                                      selectedContact.phoneNumber.number);
                                  _phoneNumberInput.text = formatPhoneNumber(
                                      selectedContact.phoneNumber.number);
                                });
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: Text('Data do empr??stimo',
                                        style: TextStyle(
                                            color: Color(0xFF666666))),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextField(
                                      controller: _loanDateInput,
                                      readOnly: true,
                                      onTap: () async {
                                        DateTime? value = await showDatePicker(
                                            context: context,
                                            initialDate: formCharge['startDate']
                                                        .isNotEmpty &&
                                                    DateTime.tryParse(
                                                            formCharge[
                                                                'startDate']) !=
                                                        null
                                                ? DateTime.parse(
                                                    formCharge['startDate'])
                                                : DateTime.now(),
                                            firstDate: DateTime(2022),
                                            lastDate: DateTime(2050));
                                        if (value != null) {
                                          String date = DateFormat('yyyy-MM-dd')
                                              .format(value);
                                          String formatted =
                                              DateFormat('dd/MM/yyyy')
                                                  .format(value);

                                          setState(() {
                                            formCharge['startDate'] = date;
                                            _loanDateInput.text = formatted;
                                          });
                                        }
                                      },
                                      decoration: InputDecoration(
                                        hintText: 'dd/mm/aa',
                                        hintStyle: const TextStyle(
                                            color: Color(0xFFBDBDBD)),
                                        contentPadding: const EdgeInsets.only(
                                            top: 16, left: 16, bottom: 16),
                                        filled: true,
                                        fillColor: const Color(0xFFF6F6F6),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          borderSide: const BorderSide(
                                            color: Color(0xFFE8E8E8),
                                            width: 1.0,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          borderSide: const BorderSide(
                                            color: Color(0xFF5DB075),
                                            width: 2.0,
                                          ),
                                        ),
                                        suffixIcon: const Icon(
                                            Icons.calendar_today,
                                            color: Color(0xFFBDBDBD)),
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                          Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: Text('Data a receber',
                                        style: TextStyle(
                                            color: Color(0xFF666666))),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: TextField(
                                      controller: _dateToReceiveInput,
                                      readOnly: true,
                                      onTap: () async {
                                        DateTime? value = await showDatePicker(
                                            context: context,
                                            initialDate: formCharge['endDate']
                                                        .isNotEmpty &&
                                                    DateTime.tryParse(
                                                            formCharge[
                                                                'endDate']) !=
                                                        null
                                                ? DateTime.parse(
                                                    formCharge['endDate'])
                                                : DateTime.now(),
                                            firstDate: DateTime(2022),
                                            lastDate: DateTime(2050));

                                        if (value != null) {
                                          String date = DateFormat('yyyy-MM-dd')
                                              .format(value);
                                          String formatted =
                                              DateFormat('dd/MM/yyyy')
                                                  .format(value);

                                          setState(() {
                                            formCharge['endDate'] = date;
                                            _dateToReceiveInput.text =
                                                formatted;
                                          });
                                        }
                                      },
                                      decoration: InputDecoration(
                                        hintText: 'dd/mm/aa',
                                        hintStyle: const TextStyle(
                                            color: Color(0xFFBDBDBD)),
                                        contentPadding: const EdgeInsets.only(
                                            top: 16, left: 16, bottom: 16),
                                        filled: true,
                                        fillColor: const Color(0xFFF6F6F6),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          borderSide: const BorderSide(
                                            color: Color(0xFFE8E8E8),
                                            width: 1.0,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          borderSide: const BorderSide(
                                            color: Color(0xFF5DB075),
                                            width: 2.0,
                                          ),
                                        ),
                                        suffixIcon: const Icon(
                                            Icons.calendar_today,
                                            color: Color(0xFFBDBDBD)),
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                        ]),
                    const SizedBox(height: 10),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: Text('Valor',
                                        style: TextStyle(
                                            color: Color(0xFF666666))),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        MoneyInputFormatter(
                                          leadingSymbol: "R\$",
                                          useSymbolPadding: true,
                                          thousandSeparator:
                                              ThousandSeparator.Period,
                                        )
                                      ],
                                      initialValue: formCharge['value'],
                                      onChanged: (value) {
                                        setState(() {
                                          formCharge['value'] = value;
                                        });
                                      },
                                      decoration: InputDecoration(
                                        hintText: 'R\$',
                                        hintStyle: const TextStyle(
                                            color: Color(0xFFBDBDBD)),
                                        contentPadding:
                                            const EdgeInsets.all(16),
                                        filled: true,
                                        fillColor: const Color(0xFFF6F6F6),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          borderSide: const BorderSide(
                                            color: Color(0xFFE8E8E8),
                                            width: 1.0,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          borderSide: const BorderSide(
                                            color: Color(0xFF5DB075),
                                            width: 2.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                          Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: Text('Telefone',
                                        style: TextStyle(
                                            color: Color(0xFF666666))),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      keyboardType: TextInputType.phone,
                                      inputFormatters: [
                                        MaskedInputFormatter('(##)#####-####'),
                                      ],
                                      controller: _phoneNumberInput,
                                      onChanged: (value) {
                                        setState(() {
                                          formCharge['phoneNumber'] = value;
                                        });
                                      },
                                      decoration: InputDecoration(
                                        hintText: '(xx) xxxxx-xxxx',
                                        hintStyle: const TextStyle(
                                            color: Color(0xFFBDBDBD)),
                                        contentPadding:
                                            const EdgeInsets.all(16),
                                        filled: true,
                                        fillColor: const Color(0xFFF6F6F6),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          borderSide: const BorderSide(
                                            color: Color(0xFFE8E8E8),
                                            width: 1.0,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          borderSide: const BorderSide(
                                            color: Color(0xFF5DB075),
                                            width: 2.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                        ]),
                    const SizedBox(height: 10),
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text('Detalhes',
                          style: TextStyle(color: Color(0xFF666666))),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        maxLines: 5,
                        initialValue: formCharge['description'],
                        onChanged: (value) {
                          setState(() {
                            formCharge['description'] = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Digite os detalhes do empr??stimo',
                          hintStyle: const TextStyle(color: Color(0xFFBDBDBD)),
                          contentPadding: const EdgeInsets.all(16),
                          filled: true,
                          fillColor: const Color(0xFFF6F6F6),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Color(0xFFE8E8E8),
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Color(0xFF5DB075),
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: Center(
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xFF5DB075)),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            )),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 40)),
                          ),
                          onPressed: () async {
                            saveCharge();
                          },
                          child: Text(_isLoading ? 'Salvando...' : 'Salvar',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600)),
                        ),
                      ),
                    ),
                    _isError
                        ? const Center(
                            child: Padding(
                            padding: EdgeInsets.only(top: 4),
                            child: Text('Ocorreu um erro',
                                style: TextStyle(color: Colors.red)),
                          ))
                        : const SizedBox.shrink(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void saveCharge() async {
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {
      _isError = false;
      _isLoading = true;
    });

    try {
      bool isUpdate =
          formCharge['id'] != null && formCharge['id'].toString().isNotEmpty;

      if (isUpdate) {
        await client.patch(
            'charges/' + formCharge['id'], Charge.fromForm(formCharge).toMap());
      } else {
        await client.post('charges', Charge.fromForm(formCharge).toMap());
      }

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
