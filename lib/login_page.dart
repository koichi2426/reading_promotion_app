import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void validateAndSave() {}

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Flutter auth'),
      ),
      body: new Container(
          padding: EdgeInsets.all(16.0),
          child: new Form(
              child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              new TextFormField(
                decoration: new InputDecoration(labelText: 'Password'),
              ),
              new RaisedButton(
                child: new Text('Login', style: new TextStyle(fontSize: 20.0)),
                onPressed: validateAndSave,
              )
            ],
          ))),
    );
  }
}
