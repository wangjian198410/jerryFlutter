import 'dart:collection';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hnapp/src/bloc/hn_bloc.dart';
import 'package:hnapp/src/model/article.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hnapp/src/util/myHttpOverrides.dart';

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  final hnBloc = HackerNewBloc();
  runApp(MyApp(bloc: hnBloc));
}

class MyApp extends StatelessWidget {
  final HackerNewBloc bloc;
  MyApp({Key key, this.bloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page', bloc: bloc),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final HackerNewBloc bloc;

  MyHomePage({Key key, this.title, this.bloc}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamBuilder<UnmodifiableListView<Article>>(
          stream: widget.bloc.articles,
          initialData: UnmodifiableListView<Article>([]),
          builder: (context, snapshot) => ListView(
                children: snapshot.data.map(_buildItem).toList(),
              )),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        items: [
          BottomNavigationBarItem(
            title: Text('Top Stores'),
            icon: Icon(Icons.arrow_drop_up),
          ),
          BottomNavigationBarItem(
            title: Text('New Stores'),
            icon: Icon(Icons.new_releases),
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            print('tap Top Stores');
            widget.bloc.storiesType.add(StoriesType.topStories);
          } else {
            print('tap News Stores');
            widget.bloc.storiesType.add(StoriesType.newStories);
          }
        },
      ),
    );
  }

  Widget _buildItem(Article article) {
    return Padding(
      key: Key(article.title),
      padding: const EdgeInsets.all(18.0),
      child: ExpansionTile(
        title:
            Text(article.title ?? '[null]', style: TextStyle(fontSize: 24.0)),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(article.type),
              IconButton(
                icon: Icon(Icons.launch),
                onPressed: () {
                  _launchURL(article.url);
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
    if (await canLaunch(showUrl)) {
      await launch(showUrl);
    } else {
      throw 'Could not launch $showUrl';
    }
  }
}
