class NodeContextData {
  NodeContextData(
      {required this.nodeRouteContext, required this.nodeScheduleContext});

  final NodeRouteContext nodeRouteContext;
  final NodeScheduleContext nodeScheduleContext;
}

enum NodeRouteContext {
  origin,
  destination,
  intermediary,
}

enum NodeScheduleContext {
  skipped,
  previous,
  current,
  next,
  upcoming,
}
