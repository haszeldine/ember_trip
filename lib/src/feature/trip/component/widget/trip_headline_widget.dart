import 'package:ember_trip/src/feature/trip/component/data/trip_headline_data.dart';
import 'package:ember_trip/src/feature/trip/component/widget/schedule_widget.dart';
import 'package:flutter/material.dart';

class TripHeadlineWidget extends StatelessWidget {
  const TripHeadlineWidget(this.trip, {super.key});

  final TripHeadlineData trip;

  @override
  Widget build(BuildContext context) {
    final ScheduleWidget schedule = trip.next == null
        ? ScheduleWidget([
            (icon: Text('From:'), schedule: trip.origin),
            (icon: Text('Dest:'), schedule: trip.destination),
          ])
        : ScheduleWidget([
            (icon: Text('From:'), schedule: trip.origin),
            (icon: Text('Dest:'), schedule: trip.destination),
            (icon: Text('Next:'), schedule: trip.next!),
          ]);

    return Card(
      child: schedule,
    );
  }
}
