import 'package:flutter/material.dart';
import 'package:flutter_fiap/services/authentication_service.dart';

import '../pages/reset_password_page.dart';
import '../pages/signup_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //
  // MARK: - Properties:
  final formKey = new GlobalKey<FormState>();
  String email;
  String password;
  Color blueColor = Colors.blue;

  // MARK: - Builders:
  @override
  Widget build(BuildContext context) {
    print("*** LoginPage ***");
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Form(key: formKey, child: _buildLoginForm()),
      ),
    );
  }

  // MARK: - Handle methods:
  _buildLoginForm() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: ListView(children: [
        SizedBox(height: 72.0),
        Container(
          child: Text('Olá!', style: TextStyle(fontFamily: 'Lobster', fontSize: 48.0)),
        ),
        Container(
          child: Text('Bora se logar?', style: TextStyle(fontFamily: 'Lobster', fontSize: 36.0)),
        ),
        SizedBox(height: 24.0),
        TextFormField(
          decoration: InputDecoration(
            labelText: 'EMAIL',
            labelStyle: TextStyle(fontSize: 12.0, color: Colors.grey.withOpacity(0.8)),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: blueColor),
            ),
          ),
          onChanged: (value) {
            this.email = value;
          },
          validator: (value) => value.isEmpty ? 'Ups. O email deve ser preenchido.' : validateEmail(value),
        ),
        TextFormField(
            decoration: InputDecoration(
              labelText: 'PASSWORD',
              labelStyle: TextStyle(fontSize: 12.0, color: Colors.grey.withOpacity(0.8)),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: blueColor),
              ),
            ),
            obscureText: true,
            onChanged: (value) {
              this.password = value;
            },
            validator: (value) => value.isEmpty ? 'Ups. A senha deve ser preenchida.' : null),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ResetPasswordPage(),
              ),
            );
          },
          child: Container(
            alignment: Alignment(1.0, 0.0),
            padding: EdgeInsets.only(top: 16.0),
            child: InkWell(
              child: Text(
                'Esqueci minha senha',
                style: TextStyle(
                  color: blueColor,
                  fontSize: 11.0,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 48.0),
        GestureDetector(
          onTap: () {
            if (checkFields()) {
              AuthenticationService().signIn(email, password, context);
            }
          },
          child: Container(
            height: 50.0,
            child: Material(
              borderRadius: BorderRadius.circular(12.0),
              shadowColor: Colors.blueAccent,
              color: Colors.blue,
              elevation: 4.0,
              child: Center(
                child: Text(
                  'LOGIN',
                  style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 16.0),
        GestureDetector(
          onTap: () {
            AuthenticationService().fbSignIn();
          },
          child: Container(
            height: 50.0,
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, style: BorderStyle.solid, width: 1.0),
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: ImageIcon(AssetImage('assets/facebook.png'), size: 16.0),
                  ),
                  SizedBox(width: 10.0),
                  Center(
                    child: Text('Login with facebook'),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 32.0),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('Novo por aqui?'),
          SizedBox(width: 5.0),
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignupPage()));
            },
            child: Text(
              'Cadastre-se agora',
              style: TextStyle(color: blueColor, decoration: TextDecoration.underline),
            ),
          ),
        ]),
      ]),
    );
  }

  //To check fields during submit
  checkFields() {
    final form = formKey.currentState;
    if (form.validate()) {
      print("form.validate YES");
      form.save();
      return true;
    }
    print("form.validate NO");
    return false;
  }

  //To Validate email
  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Digite um e-mail válido';
    else
      return null;
  }
}
