import 'package:ember_trip/src/feature/trip/trip_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TripHeadlineWidget extends StatelessWidget {
  const TripHeadlineWidget(this.trip, {super.key});

  final TripHeadlineData trip;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Table(
        columnWidths: const <int, TableColumnWidth>{
          0: FixedColumnWidth(40),
          1: FlexColumnWidth(),
          2: IntrinsicColumnWidth(),
        },
        children: [
          TableRow(
            children: _nodeScheduleWidgets('From:', trip.origin),
          ),
          TableRow(
            children: _nodeScheduleWidgets('Dest:', trip.destination),
          ),
          ...trip.next == null
              ? []
              : [
                  TableRow(
                    children: _nodeScheduleWidgets('Next:', trip.next!),
                  ),
                ],
        ],
      ),
    );
  }
}

List<Widget> _nodeScheduleWidgets(
    final String label, final NodeScheduleData data) {
  final revised = data.revisedSchedule != null;
  return [
    Text(label, textAlign: TextAlign.end),
    Text(DateFormat("HH:mm").format(data.scheduled),
        textAlign: TextAlign.center),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [Text(data.nodeName), Text(data.nodeNameDetail)],
    ),
    ...revised
        ? [
            Text(data.revisedDescriptor!, textAlign: TextAlign.end),
            Text(DateFormat("HH:mm").format(data.revisedSchedule!),
                textAlign: TextAlign.center),
          ]
        : [SizedBox(width: 10)],
  ];
}
