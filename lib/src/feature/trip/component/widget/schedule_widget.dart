import 'package:ember_trip/src/feature/trip/component/data/route_node_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScheduleWidget extends StatelessWidget {
  const ScheduleWidget({required this.data, super.key});

  final List<({Widget icon, RouteNodeData node})> data;

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const <int, TableColumnWidth>{
        0: FixedColumnWidth(40),
        1: FixedColumnWidth(50),
        2: FlexColumnWidth(),
        3: FixedColumnWidth(40),
        4: FixedColumnWidth(50),
      },
      children: data
          .map(
            (element) => TableRow(
              children: _scheduleRowWidgets(context, element),
            ),
          )
          .toList(),
    );
  }

  List<Widget> _scheduleRowWidgets(BuildContext context,
      final ({Widget icon, RouteNodeData node}) data) {
    final schedule = data.node.schedule;
    final location = data.node.location;
    final revisedWidgets = schedule.revisedSchedule != null
        ? [
            Text(schedule.revisedDescriptor!, textAlign: TextAlign.end),
            Text(DateFormat("HH:mm").format(schedule.revisedSchedule!),
                textAlign: TextAlign.center),
          ]
        : [SizedBox(), SizedBox()];

    return [
      data.icon,
      Text(DateFormat("HH:mm").format(schedule.scheduled),
          textAlign: TextAlign.center),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(location.nodeName),
          Text(location.nodeNameDetail,
              style: DefaultTextStyle.of(context)
                  .style
                  .apply(fontSizeFactor: 0.8)),
        ],
      ),
      ...revisedWidgets,
    ];
  }
}
