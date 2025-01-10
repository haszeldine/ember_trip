import 'package:ember_trip/src/feature/trip/trip_view_model.dart';

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
