import 'dart:math';

import 'package:async/async.dart';
import 'package:ember_trip/src/data/trip/trip_model.dart';
import 'package:ember_trip/src/data/trip/trip_respository.dart';
import 'package:ember_trip/src/feature/trip/node_schedule_extractor.dart';
import 'package:flutter/widgets.dart';

class TripViewModel extends ChangeNotifier {
  TripViewModel(
      {required TripRespository tripRespository,
      required nodeScheduleExtractor})
      : _tripRespository = tripRespository,
        _nodeScheduleExtractor = nodeScheduleExtractor;

  final TripRespository _tripRespository;
  final NodeScheduleExtractor _nodeScheduleExtractor;
  final _random = Random();

  String? tripUid;
  TripModel? tripModel;

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
            tripModel = tripModelResult.value;
            tripUid = newTripUid;
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

  TripHeadlineData collectHeadlineData() {
    final List<RouteNode> routeNodes = tripModel!.route.routeNodes;

    // Already arrived at destination, or no other possible nodes left before it
    final hideNext = routeNodes[routeNodes.length - 1].arrival.actual != null ||
        routeNodes.every((node) => node.skipped || node.arrival.actual != null);

    final RouteNode? nodeNext = hideNext
        ? null
        : routeNodes.skip(1).firstWhere(
            (node) => !node.skipped && (node.arrival.actual == null));

    return TripHeadlineData(
      origin: _nodeScheduleExtractor.extractOrigin(routeNodes[0]),
      destination: _nodeScheduleExtractor
          .extractDestination(routeNodes[routeNodes.length - 1]),
      next: hideNext ? null : _nodeScheduleExtractor.extractNext(nodeNext!),
    );
  }

  List<NodeScheduleData> collectRouteData() {
    final List<RouteNode> routeNodes = tripModel!.route.routeNodes;

    return routeNodes.map(_nodeScheduleExtractor.extractDestination).toList();
  }
}

class TripHeadlineData {
  TripHeadlineData({
    required this.origin,
    required this.destination,
    this.next,
  });

  final NodeScheduleData origin;
  final NodeScheduleData destination;
  final NodeScheduleData? next;
}

class NodeScheduleData {
  NodeScheduleData(
      {required this.nodeName,
      required this.nodeNameDetail,
      required this.scheduled,
      this.revisedSchedule,
      this.revisedDescriptor});

  final String nodeName;
  final String nodeNameDetail;
  final DateTime scheduled;
  final DateTime? revisedSchedule;
  final String? revisedDescriptor;
}
