import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'serializers.dart';
import 'dart:convert' as json;
part 'article.g.dart';

abstract class Article implements Built<Article, ArticleBuilder> {
  int get id;
  @nullable
  bool get deleted;
  String get type; // "job", "story", "comment", "poll", or "pollopt".
  String get by;
  int get time;
  @nullable
  String get text;
  @nullable
  bool get dead;
  @nullable
  int get parent;
  @nullable
  int get poll;
  BuiltList<int> get kids;
  String get url;
  int get score;
  String get title;
  BuiltList<int> get parts;
  int get descendants;

  Article._();
  factory Article([void Function(ArticleBuilder) updates]) = _$Article;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(Article.serializer, this);
  }

  static Article fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(Article.serializer, json);
  }

  static Serializer<Article> get serializer => _$articleSerializer;
}

List<int> parseTopStoryList(String json) {
  throw UnimplementedError();
}

Article parseArticle(String jsonStr) {
  final parsed = json.jsonDecode(jsonStr);
  Article article = Article.fromJson(parsed);
  return article;
}
