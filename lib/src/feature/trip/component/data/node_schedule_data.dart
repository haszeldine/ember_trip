class NodeScheduleData {
  NodeScheduleData(
      {required this.nodeName,
      required this.nodeNameDetail,
      required this.scheduled,
      this.revisedSchedule,
      this.revisedDescriptor});

  final String nodeName;
  final String nodeNameDetail;
  final DateTime scheduled;
  final DateTime? revisedSchedule;
  final String? revisedDescriptor;
}
