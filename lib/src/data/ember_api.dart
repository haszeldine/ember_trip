import 'dart:io';
import 'dart:convert';
import 'package:async/async.dart';
import 'package:ember_trip/src/data/ember_http_client.dart';
import 'package:http/http.dart';

class EmberApiClient {
  const EmberApiClient({required this.httpClient});

  final EmberHttpClient httpClient;

  // Hardcoded for purposes of the demo
  Future<Result<List<String>>> fetchTripIdsHardcoded() async {
    final DateTime now = DateTime.now();
    final String startOfDay =
        DateTime(now.year, now.month, now.day).toUtc().toIso8601String();
    final String endOfDay = DateTime(now.year, now.month, now.day, 23, 59)
        .toUtc()
        .toIso8601String();
    final uri =
        'https://api.ember.to/v1/quotes/?origin=13&destination=42&departure_date_from=$startOfDay&departure_date_to=$endOfDay';

    final tripUidsFuture =
        httpClient.get(Uri.parse(uri)).then(_validateOk).then(_extractTripUids);
    return await Result.capture(tripUidsFuture);
  }

  Response _validateOk(Response response) {
    return response.statusCode == 200
        ? response
        : throw HttpException(
            'Problem with HTTP request, status ${response.statusCode}:\n${response.body}');
  }

  List<String> _extractTripUids(Response response) {
    final List<String> tripUids = [];
    final json = jsonDecode(response.body);
    if (json['quotes'] == null || json['quotes'] == []) {
      throw FormatException('Cannot find expected "quotes"');
    }
    json['quotes'].forEach((quote) {
      if (quote['legs'] == null || quote['legs'] == []) {
        throw FormatException('Cannot find expected "legs"');
      }
      quote['legs'].forEach((leg) => tripUids.add(leg['trip_uid'] as String));
      if (tripUids.isEmpty) {
        throw FormatException('Cannot find expected "trip_uids"');
      }
    });
    return tripUids;
  }
}
