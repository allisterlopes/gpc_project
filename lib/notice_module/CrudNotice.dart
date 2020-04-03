import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gpc/notice_module/AdminPostPage.dart';
import 'package:http/http.dart' as http;

class CrudNotice extends StatefulWidget {
  final String username;

  final Post value;

  CrudNotice({Key key, this.value, this.username}) : super(key: key);
  @override
  _CrudNoticeState createState() => _CrudNoticeState();
}

class _CrudNoticeState extends State<CrudNotice> {
//  Future deleteMethod() async {
//    var uri = Uri.parse("http://192.168.43.206/GPC_Project/delete.php");
//
//    var request = new http.MultipartRequest("POST", uri);
//
//    request.fields['id'] = widget.value.id;
//
//    var response = await request.send();
//
//    if (response.statusCode == 200) {
//      Navigator.pop(context);
////      print(widget.value.id);
//      print('successful');
//    } else {
//      print(" Failed");
//    }
//    response.stream.transform(utf8.decoder).listen((value) {
//      print(value);
//    });
//  }

Future deleteMethod() async {
  String theUrl = "http://192.168.43.206/GPC_Project/delete.php";
  var res = await http.post(Uri.encodeFull(theUrl),
    headers: {"Accept":"application/json"},
  body: {
    "id" : widget.value.id,
  }
  );
  var respBody = json.decode(res.body);
  print(respBody);
}

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Padding(
            child: Image.network('${widget.value.imageUrl}'),
            padding: EdgeInsets.all(12.0),
          ),
          Padding(
            child: Text(
              '${widget.value.id}',
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 10.0,
                  color: Colors.black),
            ),
            padding: EdgeInsets.all(12.0),
          ),
          RaisedButton(
            child: Text("Delete"),
            color: Colors.green,
            onPressed: () {
              deleteMethod();
//              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
