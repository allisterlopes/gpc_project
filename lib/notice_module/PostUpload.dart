import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:gpc/LoginAndRegistration/LoginPage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as Img;
import 'dart:math' as Math;

class Uploadpage extends StatefulWidget {
  Uploadpage({this.username});
  final String username;

  @override
  _UploadpageState createState() => _UploadpageState();
}

class _UploadpageState extends State<Uploadpage> {
  File _image;
  TextEditingController cTitle = new TextEditingController();
  String editor = username;
  bool _validate = false;
  DateTime _currentdate = new DateTime.now();

  @override
  void dispose() {
    cTitle.dispose();
    super.dispose();
  }

  Future getImageGallery() async {
    var imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);

    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;

    int rand = new Math.Random().nextInt(100000);

    Img.Image image = Img.decodeImage(imageFile.readAsBytesSync());
    Img.Image smallerImg = Img.copyResize(image, width: 500);

    var compressImg = new File("$path/image_$rand.jpg")

//      ..writeAsBytesSync(Img.encodeJpg(image, quality: 85));
      ..writeAsBytesSync(Img.encodeJpg(smallerImg, quality: 85));

    setState(() {
      _image = compressImg;
    });
  }

  Future getImageCamera() async {
    var imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;

    int rand = new Math.Random().nextInt(100000);

    Img.Image image = Img.decodeImage(imageFile.readAsBytesSync());
    Img.Image smallerImg = Img.copyResize(image, width: 500);

    var compressImg = new File("$path/image_$rand.jpg")
      ..writeAsBytesSync(Img.encodeJpg(smallerImg, quality: 85));

    setState(() {
      _image = compressImg;
    });
  }

  Future upload(File imageFile, String _formattedate, BuildContext context) async {
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var uri = Uri.parse("http://192.168.43.206/GPC_Project/upload.php");

    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile("image_url", stream, length,
        filename: basename(imageFile.path));
    request.fields['title'] = cTitle.text;
    request.fields['noticeuploader'] = editor;
    request.fields['post_date'] = _formattedate;

    request.files.add(multipartFile);

    var response = await request.send();

    if (response.statusCode == 200) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Uploaded successfully"),
            actions: <Widget>[
              FlatButton(
                  child: Text("OK"),
                  textColor: Colors.green,
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ],
          ));
      print('successful');
    } else {
      print(" Failed");
    }

    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }


  @override
  Widget build(BuildContext context) {
    String _formattedate = new DateFormat().format(_currentdate);
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Notice"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          verticalDirection: VerticalDirection.up,
          children: <Widget>[
            Center(
              child: _image == null
                  ? new Text(
                      "No image selected!",
                      style: TextStyle(
                          color: Colors.red,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold),
                    )
                  : new Image.file(
                      _image,
                    ),
            ),
            RaisedButton(
              child: Text("UPLOAD"),
              color: Colors.green,
              onPressed: () {
                setState(() {
                  cTitle.text.isEmpty ? _validate = true : _validate = false;
                });
                upload(_image, _formattedate, context);
              },
            ),
            TextField(
              controller: cTitle,
              decoration: new InputDecoration(
                hintText: "Enter Notice Subject",
                errorText: _validate ? 'Subject Can\'t Be Empty' : null,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                RaisedButton(
                  child: Icon(Icons.image),
                  color: Colors.blue,
                  onPressed: getImageGallery,
                ),
                RaisedButton(
                  child: Icon(Icons.camera_alt),
                  color: Colors.blueAccent,
                  onPressed: getImageCamera,
                ),
              ],
            ),
            Text('${username}'),
            Text('${_formattedate}')
          ],
        ),
      ),
    );
  }
}
