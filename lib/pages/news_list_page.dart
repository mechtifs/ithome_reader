import 'package:flutter/material.dart';
import 'package:ithome_reader/api/news_list.dart';
import 'package:ithome_reader/models/news_list_item.dart';
import 'package:ithome_reader/widget/base_page_layout.dart';
import 'package:ithome_reader/widget/news_list_tile.dart';
import 'package:easy_refresh/easy_refresh.dart';

class NewsListPage extends StatefulWidget {
  const NewsListPage({super.key, required this.title});

  final String title;

  @override
  State<NewsListPage> createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  late Future<List<NewsListItem>> _listFuture;

  Future<List<NewsListItem>> _refreshList() async {
    setState(() {
      _listFuture = getNewsList();
    });
    return await _listFuture;
  }

  Future<List<NewsListItem>> _loadList() async {
    final newList = await getNewsList(
      timestamp: (await _listFuture).last.postdate.millisecondsSinceEpoch,
    );
    final List<NewsListItem> oldList = await _listFuture;
    oldList.addAll(newList);
    setState(() {
      _listFuture = Future.value(oldList);
    });
    return _listFuture;
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(widget.title),
          content: const Text('ITHome Reader is a simple reader for ITHome.'),
          actions: [
            SizedBox(
              height: 48,
              child: FilledButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Close',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _listFuture = getNewsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BasePageLayout(
        title: 'ITHome Reader',
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              if (value == 'about') {
                _showDialog();
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  value: 'about',
                  child: ListTile(
                    title: Text('About'),
                  ),
                ),
              ];
            },
          ),
        ],
        hasBackButton: false,
        body: EasyRefresh(
          onRefresh: _refreshList,
          onLoad: _loadList,
          footer: const ClassicFooter(
            position: IndicatorPosition.locator,
          ),
          child: FutureBuilder(
            future: _listFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final List<NewsListItem> items = snapshot.data!;
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  // child: ListView.builder(
                  //   padding: const EdgeInsets.symmetric(horizontal: 8),
                  //   itemCount: items.length,
                  //   itemBuilder: (BuildContext context, int index) {
                  //     return NewsListTile(item: items.elementAt(index));
                  //   },
                  // ),
                  child: CustomScrollView(
                    slivers: [
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return NewsListTile(item: items.elementAt(index));
                            },
                            childCount: items.length,
                          ),
                        ),
                      ),
                      const FooterLocator.sliver(),
                    ],
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
          ),
        ),
      ),
    );
  }
}
