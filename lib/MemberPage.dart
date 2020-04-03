import 'package:flutter/material.dart';

class MemberPage extends StatelessWidget {

  MemberPage({this.username});
  final String username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("welcome Member"),),
      body: Column(
        children: <Widget>[
          Text('Hello $username', style: TextStyle(fontSize: 20.0),),
          RaisedButton(
            child: Text("LogOut"),
            onPressed: (){
              Navigator.pushReplacementNamed(context, '/MyHomePage');
            },
          )
        ],
      ),
    );
  }
}


//
//class MemberPage extends StatefulWidget {
//
//  MemberPage({this.username});
//  final String username;
//
//  @override
//  _MemberPageState createState() => _MemberPageState();
//}
//
//class _MemberPageState extends State<MemberPage> {
//  String id = 'postretrive';
//
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      debugShowCheckedModeBanner: false,
//      theme: new ThemeData(primarySwatch: Colors.indigo),
//      home: new Scaffold(
//        appBar: AppBar(
//          title: const Text('MYSQL Image Text'),
//        ),
//        body: RefreshIndicator(
//          child: Center(
//            child: new FutureBuilder<List<Post>>(
//              future: downloadJSON(),
//              builder: (context, snapshot) {
//                if (snapshot.hasData) {
//                  List<Post> posts = snapshot.data;
//                  return new CustomListView(posts);
//                } else if (snapshot.hasError) {
//                  return Text('${snapshot.error}');
//                }
//                return CircularProgressIndicator();
//              },
//            ),
//          ),
//          onRefresh: _handleRefresh,
//        ),
////        floatingActionButton: FloatingActionButton(
////            onPressed: () {
////              Navigator.pushNamed(context, '/upload');
////            },
////            child: Icon(Icons.create)),
//      ),
//    );
//  }
//  Future<Null> _handleRefresh() async {
//    await new Future.delayed(new Duration(seconds: 3));
//
//    setState(() {
//      FutureBuilder<List<Post>>(
//        future: downloadJSON(),
//        builder: (context, snapshot) {
//          if (snapshot.hasData) {
//            List<Post> posts = snapshot.data;
//            return new CustomListView(posts);
//          } else if (snapshot.hasError) {
//            return Text('${snapshot.error}');
//          }
//          return CircularProgressIndicator();
//        },
//      );
//    });
//
//    return null;
//  }
//}
//
//class Post {
//  final String id;
//  final String imageUrl, title;
//
//  Post({this.id, this.imageUrl, this.title});
//
//  factory Post.fromJson(Map<String, dynamic> jsonData) {
//    return Post(
//      id: jsonData['id'],
//      title: jsonData['title'],
//      imageUrl:
//      "http://192.168.43.206/test_post/images/" + jsonData['image_url'],
//    );
//  }
//}
//
//class CustomListView extends StatefulWidget {
//  final List<Post> posts;
//  CustomListView(this.posts);
//
//  @override
//  _CustomListViewState createState() => _CustomListViewState();
//}
//
//class _CustomListViewState extends State<CustomListView> {
//  Widget build(context) {
//    return ListView.builder(
//      itemCount: widget.posts.length,
//      itemBuilder: (context, int currentIndex) {
//        return createViewItem(widget.posts[currentIndex], context);
//      },
//    );
//  }
//
//  Widget createViewItem(Post post, BuildContext context) {
//    return new ListTile(
//        title: new Card(
//          elevation: 5.0,
//          child: new Container(
//            decoration: BoxDecoration(border: Border.all(color: Colors.indigo)),
//            padding: EdgeInsets.all(10.0),
//            margin: EdgeInsets.all(10.0),
//            child: Column(
//              children: <Widget>[
//                Padding(
//                  child: Image.network(post.imageUrl),
//                  padding: EdgeInsets.only(bottom: 8.0),
//                ),
//                Row(
//                  children: <Widget>[
//                    Padding(
//                      child: Text(
////                      post.title,
//                        'title',
//                        style: new TextStyle(fontWeight: FontWeight.bold),
//                        textAlign: TextAlign.right,
//                      ),
//                      padding: EdgeInsets.all(1.0),
//                    ),
//                    Text(" | "),
//                    Padding(
//                      child: Text(
//                        post.title,
////                        'title1',
//                        style: new TextStyle(fontWeight: FontWeight.bold),
//                        textAlign: TextAlign.right,
//                      ),
//                      padding: EdgeInsets.all(1.0),
//                    ),
//                  ],
//                )
//              ],
//            ),
//          ),
//        ),
//        onTap: () {
//          var route = new MaterialPageRoute(
//            builder: (BuildContext context) => new SecondScreen(value: post),
//          );
//          Navigator.of(context).push(route);
//        });
//  }
//}
//
//Future<List<Post>> downloadJSON() async {
//  final jsonEndpoint = "http://192.168.43.206/test_post/";
//
//  final response = await get(jsonEndpoint);
//
//  if (response.statusCode == 200) {
//    List posts = jsonDecode(response.body);
//    return posts.map((post) => new Post.fromJson(post)).toList();
//  } else {
//    throw Exception(
//        'We were not able to successfully download the json data. ');
//  }
//}
//
//class SecondScreen extends StatefulWidget {
//  final Post value;
//
//  SecondScreen({Key key, this.value}) : super(key: key);
//  @override
//  _SecondScreenState createState() => _SecondScreenState();
//}
//
//class _SecondScreenState extends State<SecondScreen> {
//  @override
//  Widget build(BuildContext context) {
//    return new Scaffold(
//      appBar: AppBar(title: Text('Detail page')),
//      body: ListView(
////        elevation: 5.0,
//        children: <Widget>[
//          Container(
//            decoration: BoxDecoration(border: Border.all(color: Colors.indigo)),
//            padding: EdgeInsets.all(10.0),
//            margin: EdgeInsets.all(10.0),
//            child: Column(
//              children: <Widget>[
//                Padding(
//                  child: Text(
//                    'DETAILS',
//                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
//                    textAlign: TextAlign.right,
//                  ),
//                  padding: EdgeInsets.only(bottom: 10.0),
//                ),
//                Padding(
//                  child: Image.network('${widget.value.imageUrl}'),
//                  padding: EdgeInsets.all(12.0),
//                ),
//                Column(
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: <Widget>[
//                    Row(
//                      children: <Widget>[
//                        Padding(
//                          child: Text(
//                            'NAME : ${widget.value.title}',
//                            style: TextStyle(
//                                fontWeight: FontWeight.bold, fontSize: 15.0),
//                            textAlign: TextAlign.right,
//                          ),
//                          padding: EdgeInsets.only(bottom: 20.0),
//                        ),
//
////                      Text(" : "),
////                      Padding(
////                        child: Text(''),
////                        padding: EdgeInsets.all(12.0),
////                      ),
////                      Padding(
////                        child: Text('PROPELLANT : ${widget.value.propellant}',
////                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),
////                          textAlign: TextAlign.right,
////                        ),
////                        padding: EdgeInsets.only(bottom: 20.0),
////                      ),
//                      ],
//                    ),
////                    Padding(
////                      child: Text(
////                        'Admin Name : ${widget.value.title}',
////                        style: TextStyle(
////                            fontWeight: FontWeight.bold, fontSize: 15.0),
////                        textAlign: TextAlign.right,
////                      ),
////                      padding: EdgeInsets.only(bottom: 20.0),
////                    ),
//                  ],
//                )
//              ],
//            ),
//          ),
//        ],
//      ),
//    );
//  }
//}
//
//
