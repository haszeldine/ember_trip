import 'package:ember_trip/src/feature/trip/component/data/route_node_data.dart';
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

    onMapCreated(mapboxMap) {
      mapboxMap.setCamera(
        CameraOptions(
          center: Point(coordinates: Position(-3.20, 56.77)),
          zoom: 7,
        ),
      );
      mapboxMap.annotations
          .createCircleAnnotationManager()
          // This looks pretty hacky, but it's from the SDK's own examples
          .then((manager) => _annotationManager = manager)
          .then((manager) => _updateAnnotations(manager, routeNodes));
    }

    _updateAnnotations(_annotationManager, routeNodes);
    return MapWidget(key: ValueKey('mapWidget'), onMapCreated: onMapCreated);
  }

  void _updateAnnotations(annotationManager, List<RouteNodeData> routeNodes) {
    annotationManager?.deleteAll();
    annotationManager?.createMulti(
      List<CircleAnnotationOptions>.unmodifiable(
        routeNodes.where(_isValidGeoData).map(_buildNodeAnnotation),
      ),
    );
  }

  bool _isValidGeoData(RouteNodeData node) {
    return node.location.latitude != null && node.location.longitude != null;
  }

  CircleAnnotationOptions _buildNodeAnnotation(final RouteNodeData node) {
    return CircleAnnotationOptions(
      geometry: Point(
        coordinates:
            Position(node.location.longitude!, node.location.latitude!),
      ),
      // ignore: deprecated_member_use
      circleColor: Color.fromARGB(255, 59, 49, 164).value,
      circleRadius: 8.0,
    );
  }
}
