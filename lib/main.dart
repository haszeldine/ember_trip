import 'package:ember_trip/src/data/ember_api.dart';
import 'package:ember_trip/src/data/ember_http_client.dart';
import 'package:ember_trip/src/data/trip/trip_respository.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const accessToken = String.fromEnvironment("MAPBOX_SDK_ACCESS_TOKEN");
  MapboxOptions.setAccessToken(accessToken);

  const emberHttpClient = EmberHttpClient();
  const emberApiClient = EmberApiClient(httpClient: emberHttpClient);
  const tripRespository = TripRespository(emberApiClient: emberApiClient);
  runApp(const TripApp(
    tripRespository: tripRespository,
  ));
}
