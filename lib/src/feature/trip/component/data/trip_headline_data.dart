import 'package:ember_trip/src/feature/trip/component/data/route_node_data.dart';

class TripHeadlineData {
  TripHeadlineData({
    required this.origin,
    required this.destination,
    this.next,
  });

  final RouteNodeData origin;
  final RouteNodeData destination;
  final RouteNodeData? next;
}
