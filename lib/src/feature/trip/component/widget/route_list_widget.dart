import 'package:ember_trip/src/feature/trip/component/data/node_schedule_data.dart';
import 'package:ember_trip/src/feature/trip/component/widget/schedule_widget.dart';
import 'package:flutter/material.dart';

class RouteListWidget extends StatelessWidget {
  const RouteListWidget(this.nodeSchedules, {super.key});

  final List<NodeScheduleData> nodeSchedules;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) =>
          Card(
        child: ScheduleWidget(
          [
            (icon: SizedBox(), schedule: nodeSchedules[index]),
          ],
        ),
      ),
      itemCount: nodeSchedules.length,
    );
  }

}
