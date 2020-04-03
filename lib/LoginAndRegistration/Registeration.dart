import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//void main() => runApp(new MyApp());
//
//class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return new MaterialApp(
//      title: 'Flutter Upload MySQL',
//      home: new RegistrationPage(),
//    );
//  }
//}

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {

//  String unknownuser = 'guest';
//  String unknownpass = 'default';
//
//  bool _validate1 = false;
//  bool _validate2 = false;
//
//  TextEditingController cUsername = new TextEditingController();
//  TextEditingController cPassword = new TextEditingController();

//  @override
//  void dispose() {
//    cUsername.dispose();
//    cPassword.dispose();
////    cLevel.dispose();
//    super.dispose();
//  }


  Future register(String username, String password, String level) async {
    var uri = Uri.parse("http://192.168.43.206/GPC_Project/registeration.php");

    var request = new http.MultipartRequest("POST", uri);

    request.fields['username'] = username;
    request.fields['password'] = password;
    request.fields['level'] = level;

    var response = await request.send();

    if (response.statusCode == 200) {
      Navigator.pop(context);
      _successful();
    print('successful');
    } else {
      print(" Failed");
    }
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }

  Future<bool> _successful() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Registered successfully"),
              actions: <Widget>[
                FlatButton(
                    child: Text("OK"),
                    textColor: Colors.green,
                    onPressed: () {
                      Navigator.pop(context);
                    })
              ],
            ));
  }

  Future<bool> _failed() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Registered Failed"),
          actions: <Widget>[
            FlatButton(
                child: Text("OK"),
                textColor: Colors.deepOrange,
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        ));
  }


  List<String> _locations = ['student', 'staff',]; // Option 2
  String level; // Option 2
  String username;
  String password;
  final _formKey = GlobalKey<FormState>();
  bool _autovalidate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registration"),
      ),
      body: Form(
        key: _formKey,
        autovalidate: _autovalidate,
        child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(hintText: 'Username'),
                  validator: (value) => value.isEmpty ? 'Userame is required' : null,
                  onSaved: (value) => username = value,
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: 'password'),
                  validator: (value) => value.isEmpty ? 'pssword is required' : null,
                  onSaved: (value) => password = value,
                  obscureText: true,
                ),
                DropdownButton(
                  hint: Text('Select your occupation'), // Not necessary for Option 1
                  value: level,
                  onChanged: (newValue) {
                    setState(() {
                      level = newValue;
//                    print(level);
                    });
                  },
                  items: _locations.map((location) {
                    return DropdownMenuItem(
                      child: new Text(location),
                      value: location,
                    );
                  }).toList(),
                ),


                RaisedButton(
                  child: Text("Register"),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      //form is valid, proceed further
                      _formKey.currentState.save();
                      register(username, password, level);//save once fields are valid, onSaved method invoked for every form fields

                    } else {
                      setState(() {
                        _autovalidate = true;//enable realtime validation
                      });
                    }
                  },
                ),
              ],
            ),
          ),
      ),
    );
  }
}
