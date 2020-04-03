import 'package:flutter/material.dart';
import 'package:gpc/notice_module/AdminPostPage.dart';
//import 'package:gpc/about.dart';
//import 'package:gpc/account.dart';
//import 'package:gpc/department.dart';



//class MyApp extends StatelessWidget {
//  // This widget is the root of your application.
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'GPC',
//      debugShowCheckedModeBanner: false,
//      theme: ThemeData.light(),
//      home: HomePage(),
//    );
//  }
//}

class HomePage extends StatefulWidget {

  HomePage({this.username});
  final String username;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {



  Future<bool>_onBackPressed(){
    return showDialog(
        context: context,
        builder: (context)=>AlertDialog(
          title: Text("Do you really want to exit?"),
          actions: <Widget>[
            FlatButton(
              child: Text("NO"),
              textColor: Colors.deepOrange,
              onPressed: ()=>Navigator.pop(context,false),
            ),
            FlatButton(
              child: Text("YES"),
              textColor: Colors.deepOrange,
              onPressed: ()=>Navigator.pop(context,true),
            )
          ],
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(title: Center(child: Text('GPC')),
          backgroundColor: Colors.blue,),
        body:
        Column(

          mainAxisAlignment: MainAxisAlignment.spaceAround,
//crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: <Widget>[
                SizedBox(
                  width: 300.0,
                  height: 120.0,
                  child: new RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0),
                        side: BorderSide(color: Colors.white12)
                    ),
                    color: Colors.white,
                    textColor: Colors.blue,
                    padding: EdgeInsets.all(20),
                    child: Column( // Replace with a Row for horizontal icon + text
                      children: <Widget>[
                        Icon(Icons.assignment,size: 40.0,),
                        Text("Notices",style: TextStyle(
                          fontSize: 20.0,
                        ),)
                      ],
                    ),
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AdminPostPage()),
                      );
//                      Navigator.pushNamed(context, '/AdminPage');
                    },

                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: <Widget>[
                SizedBox(
                  width: 150.0,
                  height: 120.0,
                  child: new RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0),
                        side: BorderSide(color: Colors.white12)
                    ),
                    color: Colors.white,
                    textColor: Colors.blue,
                    padding: EdgeInsets.all(20),
                    child: Column( // Replace with a Row for horizontal icon + text
                      children: <Widget>[
                        Icon(Icons.folder_special,size: 40.0,),
                        Text("Department",style: TextStyle(
                          fontSize: 20.0,
                        ),)
                      ],
                    ),
                    onPressed: (){
//                      Navigator.push(
//                        context,
//                        MaterialPageRoute(builder: (context) => DepartmentPage()),
//                      );
                    },

                  ),
                ),
                SizedBox(
                  width: 150.0,
                  height: 120.0,
                  child: new RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0),
                        side: BorderSide(color: Colors.white12)
                    ),
                    color: Colors.white,
                    textColor: Colors.blue,
                    padding: EdgeInsets.all(20),
                    child: Column( // Replace with a Row for horizontal icon + text
                      children: <Widget>[
                        Icon(Icons.book,size: 40.0,),
                        Text("Exam",style: TextStyle(
                          fontSize: 20.0,
                        ),)
                      ],
                    ),
                    onPressed: (){},

                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: <Widget>[
                SizedBox(
                  width: 150.0,
                  height: 120.0,
                  child: new RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0),
                        side: BorderSide(color: Colors.white12)
                    ),
                    color: Colors.white,
                    textColor: Colors.blue,
                    padding: EdgeInsets.all(20),
                    child: Column( // Replace with a Row for horizontal icon + text
                      children: <Widget>[
                        Icon(Icons.account_circle,size: 40.0,),
                        Text("Account",style: TextStyle(
                          fontSize: 20.0,
                        ),)
                      ],
                    ),
                    onPressed: (){
//                      Navigator.push(
//                        context,
//                        MaterialPageRoute(builder: (context) => AccountPage()),
//                      );
                    },

                  ),
                ),
                SizedBox(
                  width: 150.0,
                  height: 120.0,
                  child: new RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0),
                        side: BorderSide(color: Colors.white12)
                    ),
                    color: Colors.white,
                    textColor: Colors.blue,
                    padding: EdgeInsets.all(20),
                    child: Column( // Replace with a Row for horizontal icon + text
                      children: <Widget>[
                        Icon(Icons.fastfood,size: 40.0,),
                        Text("Canteen",style: TextStyle(
                          fontSize: 20.0,
                        ),)
                      ],
                    ),
                    onPressed: (){},

                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: <Widget>[
                SizedBox(
                  width: 300.0,
                  height: 120.0,
                  child: new RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0),
                        side: BorderSide(color: Colors.white12)
                    ),
                    color: Colors.white,
                    textColor: Colors.blue,
                    padding: EdgeInsets.all(20),
                    child: Column( // Replace with a Row for horizontal icon + text
                      children: <Widget>[
                        Icon(Icons.adb,size:40.0,),
                        Text("About App",style: TextStyle(
                          fontSize: 20.0,
                        ),)

                      ],
                    ),
                    onPressed: (){
//                      Navigator.push(
//                        context,
//                        MaterialPageRoute(builder: (context) => AboutPage()),
//                      );
                    },

                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}