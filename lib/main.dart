import 'package:flutter/material.dart';
import 'package:gpc/LoginAndRegistration/LoginPage.dart';
import 'package:gpc/MyHomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: LoginHomePage(),
    );
  }
}
