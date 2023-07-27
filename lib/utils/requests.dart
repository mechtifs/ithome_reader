import 'package:http/http.dart' as http;
import 'package:retry/retry.dart';

Future<String> get(String url) async {
  final r = await retry(() => http.get(Uri.parse(url)));
  if (r.statusCode == 200) {
    return r.body;
  } else {
    throw Exception('Failed to get $url');
  }
}
