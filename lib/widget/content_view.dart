import 'package:flutter/material.dart';
import 'package:ithome_reader/api/news_content.dart';
import 'package:ithome_reader/widget/news_content.dart';

class ContentView extends StatelessWidget {
  const ContentView({
    super.key,
    required this.newsid,
  });

  final int newsid;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getNewsContent(newsid),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final content = NewsContent(
            htmlString: snapshot.data!.detail,
            tags: snapshot.data!.newstags,
          );
          return content;
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
