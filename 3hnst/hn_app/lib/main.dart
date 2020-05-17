import 'package:flutter/material.dart';
import 'src/model/article.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Article> _article = articles;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
          setState(() {
            _article.removeAt(0);
          });
        },
        child: ListView(
            children: _article.map((article) {
          return _buildItem(article);
        }).toList()),
      ),
    );
  }

  Widget _buildItem(Article article) {
    return Padding(
      key: Key(article.text),
      padding: const EdgeInsets.all(18.0),
      child: ExpansionTile(
        title: new Text(article.text, style: new TextStyle(fontSize: 24)),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              new Text("${article.commentsCount} comments",
                  style: new TextStyle(fontSize: 24)),
              new IconButton(
                icon: new Icon(Icons.launch),
                onPressed: () {
                  _launchURL(article.domain);
                },
                color: Colors.teal,
              ),
            ],
          )
        ],
      ),
    );
  }

  _launchURL(String showUrl) async {
    final targetUrl = "http://$showUrl";
    if (await canLaunch(targetUrl)) {
      await launch(targetUrl);
    } else {
      throw 'Could not launch $targetUrl';
    }
  }
}
