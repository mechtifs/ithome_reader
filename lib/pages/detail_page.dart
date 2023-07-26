import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ithome_reader/widget/comments_view.dart';
import 'package:ithome_reader/widget/content_view.dart';
import 'package:ithome_reader/widget/multiline_app_bar.dart';

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

class _DetailPageState extends State<DetailPage> with TickerProviderStateMixin {
  late final TabController _tabController;
  final ScrollController _scrollController = ScrollController();

  Future<void> _launchUrl() async {
    if (!await launchUrl(
      Uri.parse('https://www.ithome.com${widget.url}'),
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch https://www.ithome.com${widget.url}');
    }
  }

  Future<void> _copyUrl(context) async {
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
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: TabBar(
        dividerColor: Colors.transparent,
        onTap: (index) {
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOut,
          );
        },
        controller: _tabController,
        tabs: const <Widget>[
          Tab(
            text: 'CONTENT',
          ),
          Tab(
            text: 'COMMENTS',
          ),
        ],
      ),
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          MultilineAppBar(
            label: widget.title,
            actions: <Widget>[
              PopupMenuButton(
                onSelected: (value) {
                  if (value == 'open_in_browser') {
                    _launchUrl();
                  } else if (value == 'copy_link') {
                    _copyUrl(context);
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
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
            ),
          ),
        ],
        body: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(36)),
          child: Material(
            elevation: 1,
            color: Theme.of(context).colorScheme.background,
            surfaceTintColor: Theme.of(context).colorScheme.surfaceTint,
            child: TabBarView(
              controller: _tabController,
              children: [
                ContentView(newsid: widget.newsid),
                CommentsView(url: widget.url),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
