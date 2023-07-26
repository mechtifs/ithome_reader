import 'dart:convert';
import 'package:ithome_reader/models/comment_list_item.dart';
import 'package:ithome_reader/util/requests.dart';

Future<String> getCommentSN(String idUrl) async {
  final String r = await get('https://www.ithome.com$idUrl');
  final String commentSN =
      RegExp(r'(?<=data-id=")[0-9a-f]{16}').firstMatch(r)!.group(0)!;
  return commentSN;
}

Future<List<CommentListItem>> getComments(String idUrl) async {
  final String sn = await getCommentSN(idUrl);
  final Map<String, dynamic> decoded = jsonDecode(await get(
    'https://cmt.ithome.com/api/webcomment/getnewscomment?sn=$sn',
  ));
  final List<CommentListItem> comments = [];
  for (final Map<String, dynamic> i in decoded['content']!['comments']!) {
    comments.add(CommentListItem.fromJson(i));
  }
  return comments.reversed.toList();
}
