import 'package:flutter/material.dart';
import '../services/authentication_service.dart';
// import '../pages/error_page.dart';

class ResetPasswordPage extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPasswordPage> {
  final formKey = new GlobalKey<FormState>();

  String email;

  Color blueColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Form(key: formKey, child: _buildResetForm())));
  }

  _buildResetForm() {
    return Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: ListView(children: [
          SizedBox(height: 72.0),
          Container(
            child: Text(
              'Redefina a senha.',
              style: TextStyle(fontFamily: 'Lobster', fontSize: 40.0),
            ),
          ),
          SizedBox(height: 25.0),
          TextFormField(
              decoration: InputDecoration(
                  labelText: 'EMAIL',
                  labelStyle: TextStyle(fontSize: 12.0, color: Colors.grey.withOpacity(0.8)),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: blueColor),
                  )),
              onChanged: (value) {
                this.email = value;
              },
              validator: (value) => value.isEmpty ? 'Ups. O email deve ser preenchido.' : validateEmail(value)),
          SizedBox(height: 50.0),
          GestureDetector(
            onTap: () {
              if (checkFields()) AuthenticationService().resetPasswordLink(email);
              Navigator.of(context).pop();
            },
            child: Container(
                height: 50.0,
                child: Material(
                    borderRadius: BorderRadius.circular(12.0),
                    shadowColor: Colors.blueAccent,
                    color: blueColor,
                    elevation: 7.0,
                    child: Center(
                        child: Text('REDEFINIR',
                            style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold))))),
          ),
          SizedBox(height: 20.0),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Voltar',
                style: TextStyle(color: blueColor, fontSize: 16.0, decoration: TextDecoration.underline),
              ),
            ),
          ])
        ]));
  }

  //To check fields during submit
  checkFields() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  //To Validate email
  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }
}
