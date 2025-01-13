import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class RouteMapWidget extends StatefulWidget {
  const RouteMapWidget({super.key});

  @override
  State<StatefulWidget> createState() => _RouteMapWidgetState();
}

class _RouteMapWidgetState extends State<RouteMapWidget> {
  final mapWidget = MapWidget(
    viewport: CameraViewportState(
      center: Point(coordinates: Position(-3.20, 56.77)),
      zoom: 7,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return mapWidget;
  }
}
