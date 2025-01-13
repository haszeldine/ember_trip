import 'package:ember_trip/src/data/trip/trip_model.dart';
import 'package:ember_trip/src/feature/trip/component/data/node_context_data.dart';
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
        location: _buildLocation(originNode.location),
        context: NodeContextData(
          nodeRouteContext: NodeRouteContext.origin,
          nodeScheduleContext: _nodeScheduleExtractor.extractScheduleContext(originNode),
        ));

    final destinationNode = routeNodes[routeNodes.length - 1];
    final destination = RouteNodeData(
        schedule: _nodeScheduleExtractor.extractDeparture(destinationNode),
        location: _buildLocation(destinationNode.location),
        context: NodeContextData(
          nodeRouteContext: NodeRouteContext.destination,
          nodeScheduleContext: _nodeScheduleExtractor.extractScheduleContext(originNode),
        ));

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
            location: _buildLocation(nodeNext.location),
            context: NodeContextData(
              nodeRouteContext: NodeRouteContext.intermediary,
              nodeScheduleContext: NodeScheduleContext.next,
            )
          );

    return TripHeadlineData(
      origin: origin,
      destination: destination,
      next: next,
    );
  }

  List<RouteNodeData> buildRouteData(final List<RouteNode> routeNodes) {
    final originNode = routeNodes[0];
    final destinationNode = routeNodes[routeNodes.length - 1];
    final intermediaryNodes = routeNodes.sublist(0, routeNodes.length - 1);

    final originSchedule = _nodeScheduleExtractor.extractDeparture(originNode);
    final destinationSchedule =
        _nodeScheduleExtractor.extractArrival(destinationNode);
    final intermediarySchedules = List.unmodifiable(
        intermediaryNodes.map(_nodeScheduleExtractor.extractIntermediary));

    final originContext = NodeContextData(
      nodeRouteContext: NodeRouteContext.origin,
      nodeScheduleContext: _nodeScheduleExtractor.extractScheduleContext(originNode),
    );
    final destinationContext = NodeContextData(
      nodeRouteContext: NodeRouteContext.destination,
      nodeScheduleContext: _nodeScheduleExtractor.extractScheduleContext(destinationNode),
    );
    final intermediaryContexts = List.unmodifiable(
      intermediaryNodes.map(
        (node) => NodeContextData(
          nodeRouteContext: NodeRouteContext.intermediary,
          nodeScheduleContext: _nodeScheduleExtractor.extractScheduleContext(node),
        ),
      ),
    );

    final originData = RouteNodeData(
        schedule: originSchedule,
        location: _buildLocation(originNode.location),
        context: originContext);
    final destinationData = RouteNodeData(
        schedule: destinationSchedule,
        location: _buildLocation(destinationNode.location),
        context: destinationContext);
    final intermediaryData = List.generate(
      intermediaryNodes.length,
      (i) => RouteNodeData(
          schedule: intermediarySchedules[i],
          location: _buildLocation(intermediaryNodes[i].location),
          context: intermediaryContexts[i]),
    );

    return List<RouteNodeData>.unmodifiable(
        [originData, ...intermediaryData, destinationData]);
  }

  NodeLocationData _buildLocation(final Location location) {
    return NodeLocationData(
        nodeName: location.regionName,
        nodeNameDetail: location.detailedName,
        latitude: location.lat,
        longitude: location.lon);
  }

}
