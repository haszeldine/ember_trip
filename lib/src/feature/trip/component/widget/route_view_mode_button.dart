import 'package:ember_trip/src/feature/trip/component/data/route_view_mode.dart';
import 'package:ember_trip/src/feature/trip/trip_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RouteViewModeButton extends StatelessWidget {
  const RouteViewModeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return switch (context
        .select<TripViewModel, RouteViewMode>((model) => model.routeViewMode)) {
      RouteViewMode.list => IconButton(
          onPressed: () =>
              context.read<TripViewModel>().routeViewMode = RouteViewMode.map,
          icon: Icon(Icons.map)),
      RouteViewMode.map => IconButton(
          onPressed: () =>
              context.read<TripViewModel>().routeViewMode = RouteViewMode.list,
          icon: Icon(Icons.list)),
    };
  }
}
