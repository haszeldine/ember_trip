import 'package:ember_trip/src/data/trip/trip_model.dart';
import 'package:ember_trip/src/feature/trip/component/data/node_schedule_data.dart';

class NodeScheduleExtractor {
  const NodeScheduleExtractor();

  NodeScheduleData extractDeparture(final RouteNode node) {
    final ({String? revisedDescriptor, DateTime? revisedSchedule}) revision =
        _determineRevisions(node.departure, 'Dep:');
    return NodeScheduleData(
        nodeName: node.location.regionName,
        nodeNameDetail: node.location.detailedName,
        scheduled: node.departure.scheduled,
        revisedSchedule: revision.revisedSchedule,
        revisedDescriptor: revision.revisedDescriptor);
  }

  NodeScheduleData extractArrival(final RouteNode node) {
    final ({String? revisedDescriptor, DateTime? revisedSchedule}) revision =
        _determineRevisions(node.arrival, 'Arr:');
    return NodeScheduleData(
        nodeName: node.location.regionName,
        nodeNameDetail: node.location.detailedName,
        scheduled: node.arrival.scheduled,
        revisedSchedule: revision.revisedSchedule,
        revisedDescriptor: revision.revisedDescriptor);
  }

  NodeScheduleData extractIntermediary(final RouteNode node) {
    final isStopCompleted = node.departure.actual != null;
    return isStopCompleted ? extractDeparture(node) : extractArrival(node);
  }

  ({DateTime? revisedSchedule, String? revisedDescriptor}) _determineRevisions(
      final NodeSchedule schedule, final String revisionCompletionLabel) {
    final DateTime scheduled = schedule.scheduled;
    final DateTime? estimated = schedule.estimated;
    final DateTime? actual = schedule.actual;

    final isActualRevised =
        actual != null && _isTangibleDifference(scheduled, actual);
    final isEstimatedRevised =
        estimated != null && _isTangibleDifference(scheduled, estimated);

    final DateTime? revisedSchedule = isActualRevised
        ? actual
        : isEstimatedRevised
            ? estimated
            : null;
    final String? revisedDescriptor = isActualRevised
        ? revisionCompletionLabel
        : isEstimatedRevised
            ? 'Est:'
            : null;

    return (
      revisedSchedule: revisedSchedule,
      revisedDescriptor: revisedDescriptor
    );
  }

  bool _isTangibleDifference(final DateTime a, final DateTime b) {
    return a.difference(b) >= const Duration(minutes: 1);
  }
}
