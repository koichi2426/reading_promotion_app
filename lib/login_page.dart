import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum FormType { login, register }

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = new GlobalKey<FormState>();

  String _email = 'test@test.com';
  String _password = "";

  FormType _formType = FormType.login;

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      print('Form is valid. password: $_password');
      return true;
    } else {
      print('Form is Invalid. password: $_password');
      return false;
    }
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        print('here come');
        if (_formType == FormType.login) {
          print('upper come');
          final UserCredential = (await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: _email, password: _password));
          final user = UserCredential.user;
          if (user != null) {
            print('Signed in: ${user.uid}');
          } else {
            print('Failed to sign in');
          }
        } else {
          print('lower come');
          final UserCredential = (await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: _email, password: _password));
          final user = UserCredential.user;
          if (user != null) {
            print('Registered User: ${user.uid}');
          } else {
            print('Failed to register user');
          }
        }
      } catch (e) {
        print('Error user auth: $e');
      }
    }
  }

  void moveToRegister() {
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    formKey.currentState?.reset();
    setState(() {
      _formType = FormType.login;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Flutter auth'),
      ),
      body: new Container(
          padding: EdgeInsets.all(16.0),
          child: new Form(
              key: formKey,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: buildInputs() + buildSubmitButtons(),
              ))),
    );
  }

  List<Widget> buildInputs() {
    return [
      new TextFormField(
        decoration: new InputDecoration(labelText: 'Password'),
        obscureText: true,
        validator: (value) =>
            value == null || value.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (value) => _password = value!,
      ),
    ];
  }

  List<Widget> buildSubmitButtons() {
    if (_formType == FormType.login) {
      return [
        new ElevatedButton(
          onPressed: validateAndSubmit,
          child: new Text('Login', style: new TextStyle(fontSize: 20.0)),
        ),
        new TextButton(
          onPressed: moveToRegister,
          child: new Text('Create an account',
              style: new TextStyle(fontSize: 20.0)),
        ),
      ];
    } else {
      return [
        new ElevatedButton(
          onPressed: validateAndSubmit,
          child: new Text('Create an account',
              style: new TextStyle(fontSize: 20.0)),
        ),
        new TextButton(
          onPressed: moveToLogin,
          child: new Text('Have an Account? Login',
              style: new TextStyle(fontSize: 20.0)),
        ),
      ];
    }
  }
}
