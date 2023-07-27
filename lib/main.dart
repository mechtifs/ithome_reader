import 'package:flutter/material.dart';
import 'package:ithome_reader/pages/list_page.dart';
import 'package:ithome_reader/pages/detail_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ITHome Reader',
      onGenerateRoute: (settings) => MaterialPageRoute(
        settings: settings,
        builder: (context) {
          final Map<String, dynamic>? arguments =
              settings.arguments as Map<String, dynamic>?;
          switch (settings.name) {
            case '/':
              return const NewsListPage();
            case '/detail':
              return DetailPage(
                newsid: arguments!['newsid'],
                title: arguments['title'],
                url: arguments['url'],
              );
            default:
              return const NewsListPage();
          }
        },
      ),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.light,
          seedColor: const Color(0xff6750a4),
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: const Color(0xff6750a4),
        ),
        useMaterial3: true,
      ),
      home: const NewsListPage(),
    );
  }
}
