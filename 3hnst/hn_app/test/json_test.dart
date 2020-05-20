import 'package:hnapp/src/model/article.dart';
import "package:test/test.dart";
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  test('parse topstories.json', () {
    const jsonString = '''[ 9129911, 9129199, 9127761,
         9128141, 9128264, 9127792, 9129248, 
         9127092, 9128367, 9038733 ]''';

    expect(parseTopStoryList(jsonString).first, 9129911);
  });

  test('parse item.json', () {
    const jsonString = '''{
      "by" : "dhouston",
      "descendants" : 71,
      "id" : 8863,
      "kids" : [ 8952, 9224, 8917, 8884, 8887, 8943, 8869, 8958, 9005, 9671, 8940, 9067, 8908, 9055, 8865, 8881, 8872, 8873, 8955, 10403, 8903, 8928, 9125, 8998, 8901, 8902, 8907, 8894, 8878, 8870, 8980, 8934, 8876 ],
      "score" : 111,
      "time" : 1175714200,
      "title" : "My YC app: Dropbox - Throw away your USB drive",
      "type" : "story",
      "url" : "http://www.getdropbox.com/u/2/screencast.html"
    }''';

    expect(parseArticle(jsonString).by, 'dhouston');
  });

  test('parse item.json over network', () async {
    final url = 'https://hacker-news.firebaseio.com/v0/beststories.json';
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final idList = json.decode(response.body);
      if (idList.isNotEmpty) {
        final articleUrl =
            'https://hacker-news.firebaseio.com/v0/item/${idList.first}.json';
        final articleRes = await http.get(articleUrl);
        if (articleRes.statusCode == 200) {
          final Article article = parseArticle(articleRes.body);
          expect(article.by, isNotNull);
        }
      }
    }
  });
}
