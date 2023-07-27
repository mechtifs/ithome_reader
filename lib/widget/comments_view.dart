import 'package:flutter/material.dart';
import 'package:ithome_reader/api/comments.dart';
import 'package:ithome_reader/widget/comment_list_tile.dart';

class CommentsView extends StatelessWidget {
  const CommentsView({
    super.key,
    required this.url,
  });

  final String url;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getComments(url),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No comments!'),
            );
          }
          return Padding(
            padding: const EdgeInsets.only(top: 8),
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) => CommentListTile(
                item: snapshot.data!.elementAt(index),
              ),
              separatorBuilder: (context, index) => const Divider(
                indent: 16,
                endIndent: 16,
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('${snapshot.error}'),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
