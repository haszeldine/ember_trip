class NodeScheduleData {
  NodeScheduleData(
      {required this.scheduled,
      this.revisedSchedule,
      this.revisedDescriptor});

  final DateTime scheduled;
  final DateTime? revisedSchedule;
  final String? revisedDescriptor;
}
