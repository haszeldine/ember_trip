import 'package:ember_trip/src/feature/trip/component/data/node_schedule_data.dart';
import 'package:ember_trip/src/feature/trip/component/widget/schedule_widget.dart';
import 'package:ember_trip/src/feature/trip/trip_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RouteListWidget extends StatelessWidget {
  const RouteListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final data = context.select<TripViewModel, List<NodeScheduleData>?>(
        (model) => model.routeData);

    if (data == null) {
      return ErrorWidget.withDetails(message: 'Failed to load route data');
    }

    return ListView.builder(
      itemBuilder: (BuildContext context, int index) =>
          Card(
        child: ScheduleWidget(
          data:
          [
            (icon: SizedBox(), schedule: data[index]),
          ],
        ),
      ),
      itemCount: data.length,
    );
  }

}
