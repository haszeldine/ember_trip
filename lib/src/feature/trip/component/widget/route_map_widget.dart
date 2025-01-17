import 'package:ember_trip/src/feature/trip/component/data/node_context_data.dart';
import 'package:ember_trip/src/feature/trip/component/data/route_node_data.dart';
import 'package:ember_trip/src/feature/trip/component/widget/node_context_style.dart';
import 'package:ember_trip/src/feature/trip/trip_view_model.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:provider/provider.dart';

class RouteMapWidget extends StatefulWidget {
  const RouteMapWidget({super.key});

  @override
  State<StatefulWidget> createState() => _RouteMapWidgetState();
}

class _RouteMapWidgetState extends State<RouteMapWidget> {

  CircleAnnotationManager? _annotationManager;

  @override
  Widget build(BuildContext context) {
    final routeNodes = context.select<TripViewModel, List<RouteNodeData>?>(
        (model) => model.routeData);

    if (routeNodes == null) {
      return ErrorWidget.withDetails(message: 'Failed to load route data');
    }

    if (_annotationManager != null) {
      _updateAnnotations(_annotationManager!, routeNodes);
    }

    return MapWidget(
      key: ValueKey('mapWidget'),
      onMapCreated: _onMapCreatedPartial(routeNodes),
    );
  }

  Future<void> Function(MapboxMap) _onMapCreatedPartial(
      final List<RouteNodeData> routeNodes) {
    return (MapboxMap map) async {
      map.setCamera(
        CameraOptions(
          center: Point(coordinates: Position(-3.20, 56.77)),
          zoom: 7,
        ),
      );
      _annotationManager =
          await map.annotations.createCircleAnnotationManager();
      _updateAnnotations(_annotationManager!, routeNodes);
    };
  }

  void _updateAnnotations(
      final CircleAnnotationManager manager, final List<RouteNodeData> routeNodes) {
    manager.deleteAll();
    manager.createMulti(
        routeNodes.where(_isValidGeoData).map(_buildNodeAnnotation).toList());
  }

  bool _isValidGeoData(final RouteNodeData node) {
    return node.location.latitude != null && node.location.longitude != null;
  }

  CircleAnnotationOptions _buildNodeAnnotation(final RouteNodeData node) {
    return CircleAnnotationOptions(
      geometry: Point(
        coordinates:
            Position(node.location.longitude!, node.location.latitude!),
      ),
      // ignore: deprecated_member_use
      circleColor: determineNodeColor(node.context.nodeScheduleContext).value,
      circleRadius: switch (node.context.nodeRouteContext) {
        NodeRouteContext.origin => 12.0,
        NodeRouteContext.destination => 12.0,
        NodeRouteContext.intermediary => 6.0,
      },
    );
  }



}
