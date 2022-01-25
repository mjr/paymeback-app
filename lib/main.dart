import 'package:flutter/material.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:firebase_core/firebase_core.dart';

import 'routes.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(Routes());
}


// class App extends StatefulWidget {
//   @override
//   _AppState createState() => _AppState();
// }

// class _AppState extends State<App> {
//   final Future<FirebaseApp> _initialization = Firebase.initializeApp();

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: _initialization,
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return Material(
//             child: Center(
//               child: Text(
//                 'Não foi possível inicializar o Firebase',
//                 textDirection: TextDirection.ltr
//               ),
//             ),
//           );
//         } else if (snapshot.connectionState == ConnectionState.done) {
//           return Routes();
//         } else {
//           return Material(child: Center(child: CircularProgressIndicator()));
//         }
//       }
//     );
//   }
// }