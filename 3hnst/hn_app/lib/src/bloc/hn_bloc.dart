import 'dart:collection';
import 'package:http/http.dart' as http;
import 'package:hnapp/src/model/article.dart';
import 'package:rxdart/subjects.dart';

class HackerNewBloc {
  final _articlesSubject = BehaviorSubject<UnmodifiableListView<Article>>();
  var _articles = <Article>[];
  List<int> _ids = [
    23455033,
    23454557,
    23438359,
    23455463,
    23455309,
    23454352,
    23452721,
    23453308,
    23456061,
    23446242,
    23455208,
    23452365
  ];
  HackerNewBloc() {
    _updateArticles().then((_) {
      _articlesSubject.add(UnmodifiableListView(_articles));
    });
  }
  Stream<UnmodifiableListView<Article>> get articles => _articlesSubject.stream;
  Future<Null> _updateArticles() async {
    final futureArticles = _ids.map((id) => _getArticle(id));
    final articles = await Future.wait(futureArticles);
    _articles = articles;
  }

  Future<Article> _getArticle(int id) async {
    final storyUrl = 'https://hacker-news.firebaseio.com/v0/item/$id.json';
    final storyRes = await http.get(storyUrl);
    if (storyRes.statusCode == 200) {
      return parseArticle(storyRes.body);
    } else {
      throw Exception('Failed to load data ');
    }
  }
}
