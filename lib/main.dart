/*
iOS
PRODUCT_BUNDLE_IDENTIFIER = com.example.flutterFiap;

Android
package="com.example.flutter_fiap">

teste@teste.com.br
123456

facebook
123456
*/

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'services/authentication_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

final customTheme = ThemeData(
  // Colors
  brightness: Brightness.light,
  primaryColor: Colors.black87,
  accentColor: Colors.red,
  // Default font family
  fontFamily: 'Georgia',
  // Custom fonts
  textTheme: TextTheme(
    headline1: TextStyle(fontSize: 72.0, fontFamily: 'Lobster', fontWeight: FontWeight.bold),
    headline2: TextStyle(fontSize: 36.0, fontFamily: 'Lobster', fontStyle: FontStyle.italic),
    bodyText1: TextStyle(fontSize: 14.0),
  ),
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var materialApp = MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthenticationService().checkIfTheUserIsAuthenticatedAndRedirectToPage(),
    );
    return materialApp;
  }
}
