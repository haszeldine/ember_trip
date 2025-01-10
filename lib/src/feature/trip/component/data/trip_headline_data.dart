import 'package:ember_trip/src/feature/trip/component/data/node_schedule_data.dart';

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
