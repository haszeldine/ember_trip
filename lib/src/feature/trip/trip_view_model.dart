import 'dart:math';

import 'package:async/async.dart';
import 'package:ember_trip/src/data/trip/trip_respository.dart';
import 'package:flutter/widgets.dart';

class TripViewModel extends ChangeNotifier {
  TripViewModel({required TripRespository tripRespository})
      : _tripRespository = tripRespository;

  final TripRespository _tripRespository;
  final _random = Random();

  String? tripUid;

  // Pretending to provide a selected trip (randomised for the demo)
  // from whatever previous context the user was in before the
  // TripView, likely some trip selector view
  Future<void> selectRandomTrip() async {
    final tripUidsResult = await _tripRespository.fetchTripUids();
    switch (tripUidsResult) {
      case ValueResult<List<String>> _:
        final tripUids = tripUidsResult.value;
        tripUid = tripUids[_random.nextInt(tripUids.length)];
        notifyListeners();
      case ErrorResult _:
      // case _:
      // TODO Do something with the error, look into handling this in the view as error widget
    }
  }
}
