import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gpc/HomeUI/MemberHomePage.dart';
import 'package:gpc/LoginAndRegistration/Registeration.dart';
import 'package:gpc/notice_module/AdminPostPage.dart';
import 'package:gpc/HomeUI/HomePage.dart';
import 'package:gpc/notice_module/CrudNotice.dart';
import 'package:gpc/notice_module/MemberViewPage.dart';
import 'package:gpc/notice_module/PostUpload.dart';
import 'package:http/http.dart' as http;

String username;

class LoginHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: LoginPage(),
        routes: <String, WidgetBuilder>{
          '/AdminPostPage': (BuildContext context) => new AdminPostPage(
                username: username,
              ),
          '/MemberViewPage': (BuildContext context) => new MemberViewPage(
                username: username,
              ),
          '/HomePage': (BuildContext context) => new HomePage(
                username: username,
              ),
          '/CrudNotice': (BuildContext context) => new CrudNotice(
            username: username,
          ),
          '/MemberHomePage': (BuildContext context) => new MemberHomePage(),
          '/Uploadpage': (BuildContext context) => new Uploadpage(),
        });
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController user = new TextEditingController();
  TextEditingController pass = new TextEditingController();

  String msg = '';

  Future<List> _login() async {
    final response =
        await http.post("http://192.168.43.206/Gpc_Project/login.php", body: {
      "username": user.text,
      "password": pass.text,
    });
    print(response.body);
    var datauser = jsonDecode(response.body);

    if (datauser.length == 0) {
      setState(() {
        msg = "Login Fail";
      });
    } else {
      if (datauser[0]['level'] == 'admin' || datauser[0]['level'] == 'staff') {
        print("welcome admin");
        Navigator.pushReplacementNamed(context, '/HomePage');
      } else if (datauser[0]['level'] == 'member' ||
          datauser[0]['level'] == 'student' ||
          datauser[0]['level'] == 'parent') {
        Navigator.pushReplacementNamed(context, '/MemberHomePage');
        print("welcome member");
      }
      setState(() {
        username = datauser[0]['username'];
      });
    }

    return datauser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login "),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      backgroundColor: Colors.blue,
      body: ListView(
        children: <Widget>[
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                Card(
                  elevation: 25,
                  child: Text('Government Polytechnic Curchorem'),
                ),
                SizedBox(
                  height: 10,
                ),
                ListTile(
                  title: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    color: Colors.white,
                    elevation: 25,
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 10),
                          Text(
                            "Username",
                            style: TextStyle(fontSize: 15.0),
                          ),
                          TextField(
                            controller: user,
                            decoration: InputDecoration(
                                hintText: 'Username',
                                icon: Icon(Icons.account_circle)),
                          ),
                          Text(
                            "Password",
                            style: TextStyle(fontSize: 15.0),
                          ),
                          TextField(
                            controller: pass,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'password',
                              icon: Icon(Icons.lock),
                            ),
                          ),
                          RaisedButton(
                              color: Colors.blue,
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.blue)),
                              child: Text(
                                "Login",
                                style: new TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              onPressed: () {
                                _login();
                              }),
                          FlatButton(
                              child:
                                  Text("Not have an Account? Create account?"),
                              textColor: Colors.blue,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => RegistrationPage()),
                                );
                              }),
                          Text(
                            msg,
                            style: TextStyle(fontSize: 20.0, color: Colors.red, fontStyle: FontStyle.italic),
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
