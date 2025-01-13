import 'package:ember_trip/src/feature/trip/component/data/route_view_mode.dart';
import 'package:ember_trip/src/feature/trip/component/widget/route_list_widget.dart';
import 'package:ember_trip/src/feature/trip/component/widget/route_map_widget.dart';
import 'package:ember_trip/src/feature/trip/trip_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RouteDisplayWidget extends StatelessWidget {
  const RouteDisplayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<TripViewModel, RouteViewMode>(
      selector: (_, model) => model.routeViewMode,
      builder: (_, viewMode, __) => IndexedStack(
        index: switch (viewMode) {
          RouteViewMode.list => 0,
          RouteViewMode.map => 1,
        },
        children: [const RouteListWidget(), const RouteMapWidget()],
      ),
    );
  }
}
