import 'package:http/http.dart' as http;

class EmberHttpClient {
  const EmberHttpClient();

  Future<http.Response> get(Uri uri, {Map<String, String>? headers}) {
    return http.get(uri, headers: headers);
  }
}
