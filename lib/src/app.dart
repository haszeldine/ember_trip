import 'package:ember_trip/src/data/trip/trip_respository.dart';
import 'package:ember_trip/src/feature/trip/node_schedule_extractor.dart';
import 'package:ember_trip/src/feature/trip/trip_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'feature/trip/trip_view.dart';

class TripApp extends StatelessWidget {
  const TripApp(
      {super.key,
      required this.tripRespository,
      required this.nodeScheduleExtractor});

  final TripRespository tripRespository;
  final NodeScheduleExtractor nodeScheduleExtractor;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          TripViewModel(
          tripRespository: tripRespository,
          nodeScheduleExtractor: nodeScheduleExtractor),
      child: MaterialApp(
        title: 'Ember Trip View',
        theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.green)),
        home: TripView(),
      ),
    );
  }
}
