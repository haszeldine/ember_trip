import 'package:ember_trip/src/data/trip/trip_model.dart';
import 'package:ember_trip/src/feature/trip/component/data/node_schedule_data.dart';

class NodeScheduleExtractor {
  const NodeScheduleExtractor();

  NodeScheduleData extractOrigin(final RouteNode node) {
    final DateTime scheduledDeparture = node.departure.scheduled;
    final DateTime? revisedDeparture =
        node.departure.actual ?? node.departure.estimated;
    final String? revisedDescriptor = node.departure.actual != null
        ? 'Dep:'
        : node.departure.estimated != null
            ? 'Est:'
            : null;
    return NodeScheduleData(
        nodeName: node.location.regionName,
        nodeNameDetail: node.location.detailedName,
        scheduled: scheduledDeparture,
        revisedSchedule: revisedDeparture,
        revisedDescriptor: revisedDescriptor);
  }

  NodeScheduleData extractDestination(final RouteNode node) {
    final DateTime scheduledArrival = node.arrival.scheduled;
    final DateTime? revisedArrival =
        node.arrival.actual ?? node.arrival.estimated;
    final String? revisedDescriptor = node.arrival.actual != null
        ? 'Arr:'
        : node.arrival.estimated != null
            ? 'Est:'
            : null;
    return NodeScheduleData(
        nodeName: node.location.regionName,
        nodeNameDetail: node.location.detailedName,
        scheduled: scheduledArrival,
        revisedSchedule: revisedArrival,
        revisedDescriptor: revisedDescriptor);
  }

  NodeScheduleData extractNext(final RouteNode node) {
    final DateTime scheduledArrival = node.arrival.scheduled;
    final DateTime? revisedArrival =
        node.arrival.actual ?? node.arrival.estimated;
    final String? revisedDescriptor =
        node.arrival.estimated != null ? 'Est:' : null;
    return NodeScheduleData(
        nodeName: node.location.regionName,
        nodeNameDetail: node.location.detailedName,
        scheduled: scheduledArrival,
        revisedSchedule: revisedArrival,
        revisedDescriptor: revisedDescriptor);
  }
}
