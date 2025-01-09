import 'package:async/async.dart';
import 'package:ember_trip/src/data/ember_api.dart';
import 'package:ember_trip/src/data/trip/trip_model.dart';

class TripRespository {
  const TripRespository({required this.emberApiClient});

  final EmberApiClient emberApiClient;

  Future<Result<List<String>>> fetchTripUids() async {
    return await emberApiClient.fetchTripIdsHardcoded();
  }

  Future<Result<TripModel>> fetchTripByUid(String tripUid) async {
    return await emberApiClient.fetchTripByUid(tripUid);
  }

}
