import 'dart:convert';
import 'package:ithome_reader/models/news_list_item.dart';
import 'package:ithome_reader/utils/requests.dart';

Future<List<NewsListItem>> getNewsList({int timestamp = 0}) async {
  final json = jsonDecode(await get(
    'https://m.ithome.com/api/news/newslistpageget?ot=$timestamp',
  ));
  final List<dynamic> decoded = json['Result']!;
  final List<NewsListItem> newsList = [];
  for (final Map<String, dynamic> i in decoded) {
    if (i['PostDateStr']! != '') {
      newsList.add(NewsListItem.fromJson(i));
    }
  }
  return newsList;
}
