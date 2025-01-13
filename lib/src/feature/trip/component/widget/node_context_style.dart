import 'package:ember_trip/src/feature/trip/component/data/node_context_data.dart';
import 'package:flutter/material.dart';

Color determineNodeColor(final NodeScheduleContext scheduleContext) {
  switch (scheduleContext) {
    case NodeScheduleContext.skipped:
    case NodeScheduleContext.previous:
      return const Color.fromARGB(255, 75, 75, 75);
    case NodeScheduleContext.current:
      return const Color.fromARGB(255, 35, 125, 35);
    case NodeScheduleContext.next:
    case NodeScheduleContext.upcoming:
      return const Color.fromARGB(255, 75, 125, 225);
  }
}

