import 'package:ember_trip/src/data/trip/trip_model.dart';
import 'package:ember_trip/src/feature/trip/component/data/node_location_data.dart';
import 'package:ember_trip/src/feature/trip/component/data/route_node_data.dart';
import 'package:ember_trip/src/feature/trip/component/data/trip_headline_data.dart';
import 'package:ember_trip/src/feature/trip/node_schedule_extractor.dart';

class TripDataBuilder {
  const TripDataBuilder(nodeScheduleExtractor)
      : _nodeScheduleExtractor = nodeScheduleExtractor;

  final NodeScheduleExtractor _nodeScheduleExtractor;

  TripHeadlineData buildHeadlineData(final List<RouteNode> routeNodes) {
    final originNode = routeNodes[0];
    final origin = RouteNodeData(
        schedule: _nodeScheduleExtractor.extractDeparture(originNode),
        location: NodeLocationData(
            nodeName: originNode.location.regionName,
            nodeNameDetail: originNode.location.detailedName,
            latitude: originNode.location.lat,
            longitude: originNode.location.lon));

    final destinationNode = routeNodes[routeNodes.length - 1];
    final destination = RouteNodeData(
        schedule: _nodeScheduleExtractor.extractDeparture(destinationNode),
        location: NodeLocationData(
            nodeName: destinationNode.location.regionName,
            nodeNameDetail: destinationNode.location.detailedName,
            latitude: destinationNode.location.lat,
            longitude: destinationNode.location.lon));

    // Not departed origin, already terminated, or no other possible nodes left before destination
    final hideNext = routeNodes[0].departure.actual == null ||
        routeNodes[routeNodes.length - 1].arrival.actual != null ||
        routeNodes.every((node) => node.skipped || node.arrival.actual != null);

    final RouteNode? nodeNext = hideNext
        ? null
        : routeNodes.skip(1).firstWhere(
            (node) => !node.skipped && (node.arrival.actual == null));
    final next = nodeNext == null
        ? null
        : RouteNodeData(
            schedule: _nodeScheduleExtractor.extractDeparture(nodeNext),
            location: NodeLocationData(
                nodeName: nodeNext.location.regionName,
                nodeNameDetail: nodeNext.location.detailedName,
                latitude: nodeNext.location.lat,
                longitude: nodeNext.location.lon),
          );

    return TripHeadlineData(
      origin: origin,
      destination: destination,
      next: next,
    );
  }

  List<RouteNodeData> buildRouteData(final List<RouteNode> routeNodes) {
    return List.unmodifiable(
      routeNodes.map(
        (node) => RouteNodeData(
          schedule: _nodeScheduleExtractor.extractIntermediary(node),
          location: NodeLocationData(
              nodeName: node.location.regionName,
              nodeNameDetail: node.location.detailedName,
              latitude: node.location.lat,
              longitude: node.location.lon),
        ),
      ),
    );
  }
}
