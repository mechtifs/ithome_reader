import 'package:flutter/material.dart';
import 'package:ithome_reader/widget/news_content.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'package:ithome_reader/widget/base_page_layout.dart';
import 'package:ithome_reader/api/news_detail.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({
    super.key,
    required this.newsid,
    required this.title,
    required this.url,
  });

  final int newsid;
  final String title;
  final String url;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Future<void> _launchUrl() async {
    if (!await launchUrl(
      Uri.parse('https://www.ithome.com${widget.url}'),
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch https://www.ithome.com${widget.url}');
    }
  }

  Future<void> _copyUri(context) async {
    await Clipboard.setData(
        ClipboardData(text: 'https://www.ithome.com${widget.url}'));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text('Link copied!'),
        duration: Duration(milliseconds: 1500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BasePageLayout(
        title: widget.title,
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (value) {
              if (value == 'open_in_browser') {
                _launchUrl();
              } else if (value == 'copy_link') {
                _copyUri(context);
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  value: 'open_in_browser',
                  child: ListTile(
                    title: Text('Open in Browser'),
                  ),
                ),
                const PopupMenuItem(
                  value: 'copy_link',
                  child: ListTile(
                    title: Text('Copy Link'),
                  ),
                ),
              ];
            },
          ),
        ],
        hasBackButton: true,
        body: FutureBuilder(
          future: getNewsDetail(widget.newsid),
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
        ),
      ),
    );
  }
}
