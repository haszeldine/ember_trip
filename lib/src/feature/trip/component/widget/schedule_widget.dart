import 'package:ember_trip/src/feature/trip/component/data/node_schedule_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScheduleWidget extends StatelessWidget {
  const ScheduleWidget(this.data, {super.key});

  final List<({Widget icon, NodeScheduleData schedule})> data;

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
              children: _scheduleRowWidgets(element),
            ),
          )
          .toList(),
    );
  }

  List<Widget> _scheduleRowWidgets(
      final ({Widget icon, NodeScheduleData schedule}) data) {
    final revisedWidgets = data.schedule.revisedSchedule != null
        ? [
            Text(data.schedule.revisedDescriptor!, textAlign: TextAlign.end),
            Text(DateFormat("HH:mm").format(data.schedule.revisedSchedule!),
                textAlign: TextAlign.center),
          ]
        : [SizedBox(), SizedBox()];

    return [
      data.icon,
      Text(DateFormat("HH:mm").format(data.schedule.scheduled),
          textAlign: TextAlign.center),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(data.schedule.nodeName),
          Text(data.schedule.nodeNameDetail)
        ],
      ),
      ...revisedWidgets,
    ];
  }
}
