import 'dart:convert';
import 'package:ithome_reader/models/news_content.dart';
import 'package:ithome_reader/utils/requests.dart';

Future<NewsContent> getNewsContent(int newsid) async {
  final Map<String, dynamic> decoded = jsonDecode(await get(
    'https://api.ithome.com/json/newscontent/$newsid',
  ));
  final NewsContent newsItem = NewsContent.fromJson(decoded);
  return newsItem;
}
