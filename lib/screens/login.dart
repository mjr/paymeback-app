import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:paymeback/auth/provider.dart';
import 'package:paymeback/auth/user.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
        child: LoginForm()
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({ Key? key }) : super(key: key);

  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final auth = AuthProvider();
  final _formKey = GlobalKey<FormState>();
  String? _username, _password;
  bool _isObscure = true;
  bool _isLoading = false;
  bool _isError = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 40, bottom: 20),
            child: Center(
              child: Text(
                'Entrar',
                style: GoogleFonts.inter(
                  fontSize: 30, fontWeight: FontWeight.w600, color: Colors.black
                )
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              autofocus: true,
              onChanged: (value) {
                if (value != null) setState(() { _username = value; });
              },
              decoration: InputDecoration(
                hintText: 'E-mail',
                hintStyle: TextStyle(color: Color(0xFFBDBDBD)),
                contentPadding: EdgeInsets.all(16),
                filled: true,
                fillColor: Color(0xFFF6F6F6),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Color(0xFFE8E8E8),
                    width: 1.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Colors.green,
                    width: 2.0,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 2),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              obscureText: true,
              onChanged: (value) {
                if (value != null) setState(() { _password = value; });
              },
              decoration: InputDecoration(
                hintText: 'Senha',
                hintStyle: TextStyle(color: Color(0xFFBDBDBD)),
                contentPadding: EdgeInsets.all(16),
                filled: true,
                fillColor: Color(0xFFF6F6F6),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Color(0xFFE8E8E8),
                    width: 1.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Colors.green,
                    width: 2.0,
                  ),
                ),
                suffixIcon: IconButton(
                  icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() { _isObscure = !_isObscure; });
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: 60),
          MaterialButton(
            onPressed: () async {
              FocusScope.of(context).requestFocus(FocusNode());
              setState(() { _isError = false; _isLoading = true; });

              try {
                final response = await auth.login(_username, _password);
                final user = User(
                  fullName: response['fullName'],
                  nickname: response['nickname'],
                  token: response['token'],
                );
                auth.setUser(context, user);
                setState(() { _isError = false; });
              } catch (err) {
                setState(() { _isError = true; });
              } finally {
                setState(() { _isLoading = false; });
              }
            },
            textColor: Colors.white,
            color: Color(0xFF5DB075),
            child: SizedBox(
              width: double.infinity,
              child: Text(_isLoading ? 'Entrando...' : 'Entrar', textAlign: TextAlign.center),
            ),
            height: 51,
            minWidth: 600,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(100))),
          ),
          _isError ? Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Text('Usuário ou senha inválidos', style: TextStyle(color: Colors.red)),
          ) : SizedBox.shrink(),
          Padding(
            padding: EdgeInsets.only(top: 50.0),
            child: Center(
              child: FlatButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, 'register');
                },
                child: Text(
                  'Não tem uma conta? Cadastre-se',
                  style: TextStyle(color: Color(0xFF5DB075), fontSize: 15),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
