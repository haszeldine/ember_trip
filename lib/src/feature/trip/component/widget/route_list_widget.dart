import 'package:ember_trip/src/feature/trip/component/data/node_context_data.dart';
import 'package:ember_trip/src/feature/trip/component/data/route_node_data.dart';
import 'package:ember_trip/src/feature/trip/component/widget/node_context_style.dart';
import 'package:ember_trip/src/feature/trip/component/widget/schedule_widget.dart';
import 'package:ember_trip/src/feature/trip/trip_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RouteListWidget extends StatelessWidget {
  const RouteListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final data = context.select<TripViewModel, List<RouteNodeData>?>(
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
            (
              icon: Icon(
                Icons.trip_origin,
                color:
                    determineNodeColor(data[index].context.nodeScheduleContext),
                size: switch (data[index].context.nodeRouteContext) {
                  NodeRouteContext.origin => 35,
                  NodeRouteContext.destination => 35,
                  NodeRouteContext.intermediary => 20,
                },
              ),
              node: data[index]
            ),
          ],
        ),
      ),
      itemCount: data.length,
    );
  }

}
