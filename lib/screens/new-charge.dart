import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:paymeback/auth/provider.dart';
import 'package:paymeback/components/input.dart';
import 'package:paymeback/utils/client.dart';


class NewChargeScreen extends StatefulWidget {
  const NewChargeScreen({ Key? key }) : super(key: key);

  @override
  _NewChargeScreenState createState() => _NewChargeScreenState();
}

class _NewChargeScreenState extends State<NewChargeScreen> {
  final auth = AuthProvider();
  final client = Client();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _title, _debtorName, _loanDate, _dateToReceive, _value, _debtorPhone, _details;
  TextEditingController _loanDateInput = TextEditingController();
  TextEditingController _dateToReceiveInput = TextEditingController();
  bool _isLoading = false;
  bool _isError = false;

  @override
  void initState() {
    _loanDateInput.text = '';
    _dateToReceiveInput.text = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFFFFFFF),
        leading: BackButton(color: Color(0xFFB1B0B8)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 16, left: 4, right: 4),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text('Título', style: TextStyle(color: Color(0xFF666666))),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        autofocus: true,
                        onChanged: (value) {
                          if (value != null) setState(() { _title = value; });
                        },
                        decoration: InputDecoration(
                          hintText: 'Digite o  título do empréstimo',
                          hintStyle: TextStyle(color: Color(0xFFBDBDBD)),
                          contentPadding: EdgeInsets.all(16),
                          filled: true,
                          fillColor: Color(0xFFF6F6F6),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: BorderSide(
                              color: Color(0xFFE8E8E8),
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: BorderSide(
                              color: Color(0xFF5DB075),
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text('Nome do devedor', style: TextStyle(color: Color(0xFF666666))),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        onChanged: (value) {
                          if (value != null) setState(() { _debtorName = value; });
                        },
                        decoration: InputDecoration(
                          hintText: 'Digite o nome do devedor',
                          hintStyle: TextStyle(color: Color(0xFFBDBDBD)),
                          contentPadding: EdgeInsets.all(16),
                          filled: true,
                          fillColor: Color(0xFFF6F6F6),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: BorderSide(
                              color: Color(0xFFE8E8E8),
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: BorderSide(
                              color: Color(0xFF5DB075),
                              width: 2.0,
                            ),
                          ),
                          suffixIcon: Icon(Icons.perm_contact_calendar, color: Color(0xFFBDBDBD)),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Text(
                                  'Data do empréstimo',
                                  style: TextStyle(color: Color(0xFF666666))
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: TextField(
                                  controller: _loanDateInput,
                                  readOnly: true,
                                  onTap: () async {
                                    DateTime? value = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2022),
                                      lastDate: DateTime(2050)
                                    );

                                    if (value != null ) {
                                      String date = DateFormat('yyyy-MM-dd').format(value);
                                      String formatted = DateFormat('dd/MM/yyyy').format(value);

                                      setState(() {
                                        _loanDate = date;
                                        _loanDateInput.text = formatted;
                                      });
                                    }
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'dd/mm/aa',
                                    hintStyle: TextStyle(color: Color(0xFFBDBDBD)),
                                    contentPadding: EdgeInsets.only(top: 16, left: 16, bottom: 16),
                                    filled: true,
                                    fillColor: Color(0xFFF6F6F6),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide: BorderSide(
                                        color: Color(0xFFE8E8E8),
                                        width: 1.0,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide: BorderSide(
                                        color: Color(0xFF5DB075),
                                        width: 2.0,
                                      ),
                                    ),
                                    suffixIcon: Icon(
                                      Icons.calendar_today,
                                      color: Color(0xFFBDBDBD)
                                    ),
                                  ),
                                ),
                              ),
                            ]
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Text(
                                  'Data a receber',
                                  style: TextStyle(color: Color(0xFF666666))
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: TextField(
                                  controller: _dateToReceiveInput,
                                  readOnly: true,
                                  onTap: () async {
                                    DateTime? value = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2022),
                                      lastDate: DateTime(2050)
                                    );

                                    if (value != null ) {
                                      String date = DateFormat('yyyy-MM-dd').format(value);
                                      String formatted = DateFormat('dd/MM/yyyy').format(value);

                                      setState(() {
                                        _dateToReceive = date;
                                        _dateToReceiveInput.text = formatted;
                                      });
                                    }
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'dd/mm/aa',
                                    hintStyle: TextStyle(color: Color(0xFFBDBDBD)),
                                    contentPadding: EdgeInsets.only(top: 16, left: 16, bottom: 16),
                                    filled: true,
                                    fillColor: Color(0xFFF6F6F6),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide: BorderSide(
                                        color: Color(0xFFE8E8E8),
                                        width: 1.0,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide: BorderSide(
                                        color: Color(0xFF5DB075),
                                        width: 2.0,
                                      ),
                                    ),
                                    suffixIcon: Icon(
                                      Icons.calendar_today,
                                      color: Color(0xFFBDBDBD)
                                    ),
                                  ),
                                ),
                              ),
                            ]
                          ),
                        ),
                      ]
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Text(
                                  'Valor',
                                  style: TextStyle(color: Color(0xFF666666))
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                  onChanged: (value) {
                                    if (value != null) setState(() { _value = value; });
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'R\$',
                                    hintStyle: TextStyle(color: Color(0xFFBDBDBD)),
                                    contentPadding: EdgeInsets.all(16),
                                    filled: true,
                                    fillColor: Color(0xFFF6F6F6),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide: BorderSide(
                                        color: Color(0xFFE8E8E8),
                                        width: 1.0,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide: BorderSide(
                                        color: Color(0xFF5DB075),
                                        width: 2.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ]
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Text(
                                  'Telefone',
                                  style: TextStyle(color: Color(0xFF666666))
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                  onChanged: (value) {
                                    if (value != null) setState(() { _debtorPhone = value; });
                                  },
                                  decoration: InputDecoration(
                                    hintText: '(xx) xxxxx-xxxx',
                                    hintStyle: TextStyle(color: Color(0xFFBDBDBD)),
                                    contentPadding: EdgeInsets.all(16),
                                    filled: true,
                                    fillColor: Color(0xFFF6F6F6),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide: BorderSide(
                                        color: Color(0xFFE8E8E8),
                                        width: 1.0,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide: BorderSide(
                                        color: Color(0xFF5DB075),
                                        width: 2.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ]
                          ),
                        ),
                      ]
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text('Detalhes', style: TextStyle(color: Color(0xFF666666))),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        maxLines: 5,
                        onChanged: (value) {
                          if (value != null) setState(() { _details = value; });
                        },
                        decoration: InputDecoration(
                          hintText: 'Digite os detalhes do empréstimo',
                          hintStyle: TextStyle(color: Color(0xFFBDBDBD)),
                          contentPadding: EdgeInsets.all(16),
                          filled: true,
                          fillColor: Color(0xFFF6F6F6),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Color(0xFFE8E8E8),
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
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
                            backgroundColor: MaterialStateProperty.all(Color(0xFF5DB075)),
                            foregroundColor: MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              )
                            ),
                            padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(vertical: 16, horizontal: 40)
                            ),
                          ),
                          onPressed: () async {
                            FocusScope.of(context).requestFocus(FocusNode());
                            setState(() { _isError = false; _isLoading = true; });

                            try {
                              final response = await client.post(
                                'charges',
                                {
                                  'title': _title,
                                  'debtorName': _debtorName,
                                  'loanDate': _loanDate,
                                  'dateToReceive': _dateToReceive,
                                  'value': _value,
                                  'debtorPhone': _debtorPhone,
                                  'details': _details,
                                }
                              );
                              final user = await auth.getUser();
                              Navigator.pushReplacementNamed(context, 'home', arguments: user);
                              setState(() { _isError = false; });
                            } catch (err) {
                              setState(() { _isError = true; });
                            } finally {
                              setState(() { _isLoading = false; });
                            }
                          },
                          child: Text(
                            _isLoading ? 'Salvando...' : 'Salvar',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)
                          ),
                        ),
                      ),
                    ),
                    _isError ? Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: Text('Ocorreu um erro', style: TextStyle(color: Colors.red)),
                      )
                    ) : SizedBox.shrink(),
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