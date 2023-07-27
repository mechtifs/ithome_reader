import 'package:flutter/material.dart';
import 'package:ithome_reader/api/news_list.dart';
import 'package:ithome_reader/models/news_list_item.dart';
import 'package:ithome_reader/widget/news_list_tile.dart';
import 'package:easy_refresh/easy_refresh.dart';

class NewsListPage extends StatefulWidget {
  const NewsListPage({super.key});

  @override
  State<NewsListPage> createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  late Future<List<NewsListItem>> _listFuture;
  final ScrollController _scrollController = ScrollController();
  bool isAtTop = true;

  void _scrollListener() {
    setState(() => isAtTop = _scrollController.offset == 0);
  }

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

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _listFuture = getNewsList();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('ITHome Reader'),
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
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: !isAtTop
          ? FloatingActionButton(
              // scroll to top
              onPressed: () {
                _scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOut,
                );
              },
              child: const Icon(Icons.arrow_upward),
            )
          : null,
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar.large(
            title: const Text('ITHome Reader'),
            expandedHeight: 240,
            actions: [
              PopupMenuButton(
                onSelected: (value) {
                  switch (value) {
                    case 'settings':
                      Navigator.pushNamed(
                        context,
                        '/settings',
                      );
                      break;
                    case 'about':
                      _showDialog();
                      break;
                  }
                },
                itemBuilder: (BuildContext context) {
                  return [
                    const PopupMenuItem(
                      value: 'settings',
                      child: ListTile(
                        title: Text('Settings'),
                      ),
                    ),
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
          ),
        ],
        body: Material(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(36)),
          elevation: 1,
          color: Theme.of(context).colorScheme.background,
          surfaceTintColor: Theme.of(context).colorScheme.surfaceTint,
          child: EasyRefresh(
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
                    child: CustomScrollView(
                      slivers: [
                        SliverPadding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                return NewsListTile(
                                    item: items.elementAt(index));
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
      ),
    );
  }
}
