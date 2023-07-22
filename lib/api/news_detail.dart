import 'package:ithome_reader/models/news_item.dart';
import 'package:ithome_reader/util/requests.dart';

Future<NewsItem> getNewsDetail(int newsid) async {
  final Map<String, dynamic> decoded = (await getJson(
    'https://api.ithome.com/json/newscontent/$newsid',
  ));
  final NewsItem newsItem = NewsItem.fromJson(decoded);
  return newsItem;
}
