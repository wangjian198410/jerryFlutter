import 'package:built_value/built_value.dart';
import 'package:hnapp/src/model/article.dart';
part 'json_parse.g.dart';

abstract class Article implements Built<Article, ArticleBuilder> {
  String get text;
  String get domain;
  String get by;
  String get age;
  int get score;
  int get commentsCount;

  Article._();
  factory Article([void Function(ArticleBuilder) updates]) = _$Article;
}

List<int> parseTopStoryList(String json) {
  throw UnimplementedError();
}

Article parseArticle(String json) {
  throw UnimplementedError();
}
