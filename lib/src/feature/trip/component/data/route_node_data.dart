import 'package:ember_trip/src/feature/trip/component/data/node_context_data.dart';
import 'package:ember_trip/src/feature/trip/component/data/node_location_data.dart';
import 'package:ember_trip/src/feature/trip/component/data/node_schedule_data.dart';

class RouteNodeData {
  const RouteNodeData({
    required this.schedule,
    required this.location,
    required this.context,
  });

  final NodeScheduleData schedule;
  final NodeLocationData location;
  final NodeContextData context;
}
