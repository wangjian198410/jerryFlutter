import 'dart:async';
import 'dart:collection';
import 'package:http/http.dart' as http;
import 'package:hnapp/src/model/article.dart';
import 'package:rxdart/subjects.dart';

enum StoriesType {
  topStories,
  newStories,
}

class HackerNewBloc {
  final _articlesSubject = BehaviorSubject<UnmodifiableListView<Article>>();
  // ignore: close_sinks
  final _storiesTypeController = StreamController<StoriesType>();

  Sink<StoriesType> get storiesType => _storiesTypeController.sink;

  var _articles = <Article>[];
  List<int> _newIds = [
    23455033,
  ];
  List<int> _topIds = [
    23456061,
  ];

  HackerNewBloc() {
    _getAndupdateArticles(_topIds);
    _storiesTypeController.stream.listen((storiesType) {
      if (storiesType == StoriesType.newStories) {
        _getAndupdateArticles(_newIds);
      } else {
        _getAndupdateArticles(_topIds);
      }
    });
  }

  _getAndupdateArticles(List<int> articleIds) {
    _updateArticles(articleIds).then((_) {
      _articlesSubject.add(UnmodifiableListView(_articles));
    });
  }

  Future<Null> _updateArticles(List<int> articleIds) async {
    final futureArticles = articleIds.map((id) => _getArticle(id));
    final articles = await Future.wait(futureArticles);
    _articles = articles;
  }

  Stream<UnmodifiableListView<Article>> get articles => _articlesSubject.stream;

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
