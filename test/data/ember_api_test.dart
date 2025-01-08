import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:ember_trip/src/data/ember_http_client.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:ember_trip/src/data/ember_api.dart';

class MockEmberHttpClient extends Mock implements EmberHttpClient {}

class MockResponse extends Mock implements Response {}

void main() {
  final EmberHttpClient httpClient = MockEmberHttpClient();
  final Response response = MockResponse();
  final EmberApiClient emberApiClient = EmberApiClient(httpClient: httpClient);

  group('fetchTripIdsHardcoded', () {
    final DateTime now = DateTime.now();
    final String startOfDay =
        DateTime(now.year, now.month, now.day).toUtc().toIso8601String();
    final String endOfDay = DateTime(now.year, now.month, now.day, 23, 59)
        .toUtc()
        .toIso8601String();
    final uriHardcoded =
        'https://api.ember.to/v1/quotes/?origin=13&destination=42&departure_date_from=$startOfDay&departure_date_to=$endOfDay';

    final bodyJsonMinimal = {
      "quotes": [
        {
          "legs": [
            {
              "trip_uid": "uid1",
            }
          ]
        },
        {
          "legs": [
            {
              "trip_uid": "uid2",
            }
          ]
        }
      ],
    };

    final bodyJsonIncorrect = {
      "quotes_incorrect": [],
    };

    test('returns a list of UIDs when the request is successful', () async {
      when(() => response.statusCode).thenReturn(200);
      when(() => response.body).thenReturn(jsonEncode(bodyJsonMinimal));
      when(() => httpClient.get(Uri.parse(uriHardcoded)))
          .thenAnswer((_) async => response);

      final result = await emberApiClient.fetchTripIdsHardcoded();

      expect(result.runtimeType, ValueResult<List<String>>);
      expect(result.asValue!.value, ['uid1', 'uid2']);
    });

    // There are many more cases for each level that could be tested
    test('returns an error result type when parsing exception', () async {
      when(() => response.statusCode).thenReturn(200);
      when(() => response.body).thenReturn(jsonEncode(bodyJsonIncorrect));
      when(() => httpClient.get(Uri.parse(uriHardcoded)))
          .thenAnswer((_) async => response);

      final result = await emberApiClient.fetchTripIdsHardcoded();

      expect(result.runtimeType, ErrorResult);
      expect(result.asError!.error.runtimeType, FormatException);
    });

    test('returns an error result type when http status is not OK', () async {
      when(() => response.statusCode).thenReturn(500);
      when(() => response.body).thenReturn(jsonEncode(bodyJsonMinimal));
      when(() => httpClient.get(Uri.parse(uriHardcoded)))
          .thenAnswer((_) async => response);

      final result = await emberApiClient.fetchTripIdsHardcoded();

      expect(result.runtimeType, ErrorResult);
      expect(result.asError!.error.runtimeType, HttpException);
    });

    test('returns an error result type when http request throws exception',
        () async {
      when(() => response.statusCode).thenReturn(200);
      when(() => response.body).thenReturn(jsonEncode(bodyJsonMinimal));
      when(() => httpClient.get(Uri.parse(uriHardcoded)))
          .thenAnswer((_) async => throw Exception());

      final result = await emberApiClient.fetchTripIdsHardcoded();

      expect(result.runtimeType, ErrorResult);
    });
  });
}
