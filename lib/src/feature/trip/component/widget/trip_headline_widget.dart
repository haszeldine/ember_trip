import 'package:ember_trip/src/feature/trip/component/data/trip_headline_data.dart';
import 'package:ember_trip/src/feature/trip/component/widget/schedule_widget.dart';
import 'package:flutter/material.dart';

class TripHeadlineWidget extends StatelessWidget {
  const TripHeadlineWidget({required this.data, super.key});

  final TripHeadlineData data;

  @override
  Widget build(BuildContext context) {
    final ScheduleWidget schedule = data.next == null
        ? ScheduleWidget(data: [
            (
              icon: Text(
                'From:',
                textAlign: TextAlign.end,
              ),
              schedule: data.origin
            ),
            (
              icon: Text('Dest:', textAlign: TextAlign.end),
              schedule: data.destination
            ),
          ])
        : ScheduleWidget(data: [
            (
              icon: Text('From:', textAlign: TextAlign.end),
              schedule: data.origin
            ),
            (
              icon: Text('Dest:', textAlign: TextAlign.end),
              schedule: data.destination
            ),
            (
              icon: Text('Next:', textAlign: TextAlign.end),
              schedule: data.next!
            ),
          ]);

    return Card(
      child: schedule,
    );
  }
}
