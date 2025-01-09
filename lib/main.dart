import 'package:ember_trip/src/data/ember_api.dart';
import 'package:ember_trip/src/data/ember_http_client.dart';
import 'package:ember_trip/src/data/trip/trip_respository.dart';
import 'package:ember_trip/src/feature/trip/node_schedule_extractor.dart';
import 'package:flutter/material.dart';

import 'src/app.dart';

void main() async {
  const emberHttpClient = EmberHttpClient();
  const emberApiClient = EmberApiClient(httpClient: emberHttpClient);
  const tripRespository = TripRespository(emberApiClient: emberApiClient);
  const nodeScheduleExtractor = NodeScheduleExtractor();
  runApp(const TripApp(
    tripRespository: tripRespository,
    nodeScheduleExtractor: nodeScheduleExtractor,
  ));
}
