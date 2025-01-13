import 'package:ember_trip/src/data/trip/trip_model.dart';
import 'package:ember_trip/src/feature/trip/component/data/node_schedule_data.dart';
import 'package:ember_trip/src/feature/trip/component/data/trip_headline_data.dart';
import 'package:ember_trip/src/feature/trip/node_schedule_extractor.dart';

class TripDataBuilder {
  const TripDataBuilder(nodeScheduleExtractor)
      : _nodeScheduleExtractor = nodeScheduleExtractor;

  final NodeScheduleExtractor _nodeScheduleExtractor;

  TripHeadlineData buildHeadlineData(final List<RouteNode> routeNodes) {
    // Not departed origin, already terminated, or no other possible nodes left before destination
    final hideNext = routeNodes[0].departure.actual == null ||
        routeNodes[routeNodes.length - 1].arrival.actual != null ||
        routeNodes.every((node) => node.skipped || node.arrival.actual != null);

    final RouteNode? nodeNext = hideNext
        ? null
        : routeNodes.skip(1).firstWhere(
            (node) => !node.skipped && (node.arrival.actual == null));

    return TripHeadlineData(
      origin: _nodeScheduleExtractor.extractDeparture(routeNodes[0]),
      destination: _nodeScheduleExtractor
          .extractArrival(routeNodes[routeNodes.length - 1]),
      next: hideNext ? null : _nodeScheduleExtractor.extractArrival(nodeNext!),
    );
  }

  List<NodeScheduleData> buildRouteData(final List<RouteNode> routeNodes) {
    return List.unmodifiable(
        routeNodes.map(_nodeScheduleExtractor.extractDeparture));
  }
}
