import 'dart:convert';
import 'package:vector_math/vector_math_64.dart' show Vector3;
import 'package:flutter/material.dart';
import 'package:http/http.dart';
//
//class MemberViewPage extends StatelessWidget {
//
//  MemberViewPage({this.username});
//  final String username;
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(title: Text("welcome Member"),),
//      body: Column(
//        children: <Widget>[
//          Text('Hello $username', style: TextStyle(fontSize: 20.0),),
//          RaisedButton(
//            child: Text("LogOut"),
//            onPressed: (){
//              Navigator.pushReplacementNamed(context, '/MyHomePage');
//            },
//          )
//        ],
//      ),
//    );
//  }
//}

class MemberViewPage extends StatefulWidget {
  MemberViewPage({this.username});
  final String username;

  @override
  _MemberViewPageState createState() => _MemberViewPageState();
}

class _MemberViewPageState extends State<MemberViewPage> {
  String id = 'postretrive';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(primarySwatch: Colors.blue),
      home: new Scaffold(
        appBar: AppBar(
          title: const Text('MYSQL Image Text'),
        ),
        body: RefreshIndicator(
          child: Center(
            child: new FutureBuilder<List<Post>>(
              future: downloadJSON(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Post> posts = snapshot.data;
                  return new CustomListView(posts);
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return CircularProgressIndicator();
              },
            ),
          ),
          onRefresh: _handleRefresh,
        ),
      ),
    );
  }

  Future<Null> _handleRefresh() async {
    await new Future.delayed(new Duration(seconds: 3));

    setState(() {
      FutureBuilder<List<Post>>(
        future: downloadJSON(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Post> posts = snapshot.data;
            return new CustomListView(posts);
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return CircularProgressIndicator();
        },
      );
    });

    return null;
  }
}

class Post {
  final String id;
  final String imageUrl, title, noticeuploader, post_date;

  Post({
    this.id,
    this.imageUrl,
    this.title,
    this.noticeuploader,
    this.post_date,
  });

  factory Post.fromJson(Map<String, dynamic> jsonData) {
    return Post(
      id: jsonData['id'],
      title: jsonData['title'],
      noticeuploader: jsonData['noticeuploader'],
      post_date: jsonData['post_date'],
      imageUrl:
          "http://192.168.43.206/GPC_Project/images/" + jsonData['image_url'],
    );
  }
}

class CustomListView extends StatefulWidget {
  final List<Post> posts;
  CustomListView(this.posts);

  @override
  _CustomListViewState createState() => _CustomListViewState();
}

class _CustomListViewState extends State<CustomListView> {
  Widget build(context) {
    return ListView.builder(
      itemCount: widget.posts.length,
      itemBuilder: (context, int currentIndex) {
        return createViewItem(widget.posts[currentIndex], context);
      },
    );
  }

  Widget createViewItem(Post post, BuildContext context) {
    return new ListTile(
        title: new Card(
          elevation: 5.0,
          child: new Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
            padding: EdgeInsets.all(10.0),
            margin: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Padding(
                  child: Text(
                    'Topic : ${post.title}',
                    style: new TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.right,
                  ),
                  padding: EdgeInsets.all(2.0),
                ),
                Text(
                  '${post.post_date}',
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 10.0),
//                  textAlign: TextAlign.left,
                ),
                Padding(
                  child: Image.network(post.imageUrl),
                  padding: EdgeInsets.only(bottom: 8.0),
                ),
                Text(
                  'posted by ${post.noticeuploader}',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 10.0),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
        ),
        onTap: () {
          var route = new MaterialPageRoute(
            builder: (BuildContext context) => new SecondScreen(value: post),
          );
          Navigator.of(context).push(route);
        });
  }
}

Future<List<Post>> downloadJSON() async {
  final jsonEndpoint = "http://192.168.43.206/Gpc_Project/";

  final response = await get(jsonEndpoint);

  if (response.statusCode == 200) {
    List posts = jsonDecode(response.body);
    return posts.map((post) => new Post.fromJson(post)).toList();
  } else {
    throw Exception(
        'We were not able to successfully download the json data. ');
  }
}

class SecondScreen extends StatefulWidget {
  final Post value;

  SecondScreen({Key key, this.value}) : super(key: key);
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  double _scale = 1.0;
  double _previousScale = 1.0;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text('Detail page')),
      body: GestureDetector(
        onScaleStart: (ScaleStartDetails details) {
          print(details);
          _previousScale = _scale;
          setState(() {});
        },
        onScaleUpdate: (ScaleUpdateDetails details) {
          print(details);
          _scale = _previousScale * details.scale;
          setState(() {});
        },
        onScaleEnd: (ScaleEndDetails details) {
          print(details);
          _previousScale = 1.0;
          setState(() {});
        },
        child: Padding(
          child: Transform(
            transform: Matrix4.diagonal3(Vector3(_scale, _scale, _scale)),
            alignment: FractionalOffset.center,
            child: Image.network('${widget.value.imageUrl}'),
          ),
          padding: EdgeInsets.all(12.0),
        ),
      ),
//                Column(
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: <Widget>[
//                    Padding(
//                      child: Text(
//                        'NAME : ${widget.value.title}',
//                        style: TextStyle(
//                            fontWeight: FontWeight.bold, fontSize: 15.0),
//                        textAlign: TextAlign.right,
//                      ),
//                      padding: EdgeInsets.only(bottom: 20.0),
//                    ),
//                    Padding(
//                      child: Text(
//                        'Admin Name : ${widget.value.noticeuploader}',
//                        style: TextStyle(
//                            fontWeight: FontWeight.bold, fontSize: 15.0),
//                        textAlign: TextAlign.right,
//                      ),
//                      padding: EdgeInsets.only(bottom: 20.0),
//                    ),
//                  ],
//                )

//      ),
    );
  }
}
