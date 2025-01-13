import 'dart:math';

import 'package:async/async.dart';
import 'package:ember_trip/src/data/trip/trip_model.dart';
import 'package:ember_trip/src/data/trip/trip_respository.dart';
import 'package:ember_trip/src/feature/trip/component/data/trip_headline_data.dart';
import 'package:ember_trip/src/feature/trip/component/data/node_schedule_data.dart';
import 'package:ember_trip/src/feature/trip/trip_data_builder.dart';
import 'package:flutter/widgets.dart';

class TripViewModel extends ChangeNotifier {
  TripViewModel(
      {required TripRespository tripRespository,
      required tripDataBuilder})
      : _tripRespository = tripRespository,
        _tripDataBuilder = tripDataBuilder;

  final TripRespository _tripRespository;
  final TripDataBuilder _tripDataBuilder;
  final _random = Random();

  String? _tripUid;
  TripModel? _tripModel;
  TripHeadlineData? _headlineData;
  List<NodeScheduleData>? _routeData;

  // Pretending to provide a selected trip (randomised for the demo)
  // from whatever previous context the user was in before the
  // TripView, likely some trip selector view
  Future<Result<TripModel>> selectRandomTrip() async {
    switch (await _tripRespository.fetchTripUids()) {
      case ValueResult<List<String>> tripUidsResult:
        final tripUids = tripUidsResult.value;
        final newTripUid = tripUids[_random.nextInt(tripUids.length)];

        switch (await _tripRespository.fetchTripByUid(newTripUid)) {
          case ValueResult<TripModel> tripModelResult:
            _tripUid = newTripUid;
            _tripModel = tripModelResult.value;
            _headlineData = _tripDataBuilder.buildHeadlineData(_tripModel!.route.routeNodes);
            _routeData = _tripDataBuilder.buildRouteData(_tripModel!.route.routeNodes);
            notifyListeners();
            return tripModelResult;
          case ErrorResult errorResult:
            return errorResult;
        }

      case ErrorResult errorResult:
        return errorResult;
    }
    return ErrorResult(Exception());
  }

  String? get tripUid => _tripUid;

  TripHeadlineData? get headlineData => _headlineData;

  List<NodeScheduleData>? get routeData => _routeData;

}
