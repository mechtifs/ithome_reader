import 'dart:convert';

import 'package:http/http.dart' as http;

Future<dynamic> getJson(String uri) async {
  final r = await http.get(Uri.parse(uri));
  if (r.statusCode == 200) {
    return jsonDecode(r.body);
  } else {
    throw Exception('Failed to get $uri');
  }
}
