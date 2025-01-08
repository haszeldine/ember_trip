import 'package:async/async.dart';
import 'package:ember_trip/src/data/ember_api.dart';

class TripRespository {
  const TripRespository({required this.emberApiClient});

  final EmberApiClient emberApiClient;

  Future<Result<List<String>>> fetchTripUids() async {
    return await emberApiClient.fetchTripIdsHardcoded();
  }

}
