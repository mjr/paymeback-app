import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:paymeback/auth/provider.dart';
import 'package:paymeback/auth/user.dart';

class GoogleLoginButton extends StatelessWidget {
  final VoidCallback onTap;

  const GoogleLoginButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(
          height: 56,
          decoration: BoxDecoration(
              color: const Color(0xFFFAFAFC),
              borderRadius: BorderRadius.circular(5),
              border: const Border.fromBorderSide(
                  BorderSide(color: Color(0xFFE3E3E6)))),
          child: Row(
            children: [
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/google.png'),
                  const SizedBox(width: 16),
                  Container(
                      height: 56, width: 1, color: const Color(0xFFE3E3E6))
                ],
              )),
              Expanded(
                  flex: 4,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Entrar com Google',
                            style: GoogleFonts.inter(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF585666)))
                      ])),
            ],
          ),
        ));
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Container(
              width: size.width,
              height: size.height * 0.36,
              color: const Color(0xFF5DB075),
            ),
            Positioned(
                top: 70,
                left: 0,
                right: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/logomini.png'),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 70, right: 70),
                      child: Text(
                        'PayMeBack',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lexendDeca(
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFFFFFFFF),
                        ),
                      ),
                    ),
                  ],
                )),
            Positioned(
              bottom: size.height * 0.05,
              left: 0,
              right: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 70, right: 70),
                    child: Text(
                      'Mapeie seus empréstimos e nunca mais perca dinheiro com seu "amigo"!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lexendDeca(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF585666),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 40, left: 40, right: 40),
                    child: GoogleLoginButton(onTap: () async {
                      final auth = AuthProvider();

                      GoogleSignIn _googleSignIn =
                          GoogleSignIn(scopes: ['email']);

                      try {
                        final response = await _googleSignIn.signIn();

                        final user = User(
                            name: response!.displayName!,
                            photoURL: response.photoUrl);

                        auth.setUser(context, user);
                        if (kDebugMode) {
                          print(response);
                        }
                      } catch (error) {
                        auth.setUser(context, null);
                        if (kDebugMode) {
                          print(error);
                        }
                      }
                    }),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
