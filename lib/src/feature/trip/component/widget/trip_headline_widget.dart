import 'package:ember_trip/src/feature/trip/component/data/trip_headline_data.dart';
import 'package:ember_trip/src/feature/trip/component/widget/schedule_widget.dart';
import 'package:ember_trip/src/feature/trip/trip_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TripHeadlineWidget extends StatelessWidget {
  const TripHeadlineWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final data = context.select<TripViewModel, TripHeadlineData?>(
        (model) => model.headlineData);

    if (data == null) {
      return ErrorWidget.withDetails(message: 'Failed to load headline data');
    }

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
