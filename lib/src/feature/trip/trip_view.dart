import 'package:async/async.dart';
import 'package:ember_trip/src/data/trip/trip_model.dart';
import 'package:ember_trip/src/feature/trip/component/widget/route_display_widget.dart';
import 'package:ember_trip/src/feature/trip/component/widget/route_view_mode_button.dart';
import 'package:ember_trip/src/feature/trip/component/widget/trip_headline_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'trip_view_model.dart';

class TripView extends StatefulWidget {
  const TripView({super.key});

  @override
  State<StatefulWidget> createState() => _TripViewState();
}

class _TripViewState extends State<TripView> {
  late Future<Result<TripModel>> _loadInitialTrip;

  @override
  void initState() {
    super.initState();
    _loadInitialTrip = context.read<TripViewModel>().selectRandomTrip();
  }

  @override
  Widget build(BuildContext context) {
    context.select<TripViewModel, String?>((model) => model.tripUid);

    return Scaffold(
      appBar: AppBar(
        title: Text('Trip Viewer'),
        leading: IconButton(
          icon: Icon(Icons.refresh),
          tooltip: 'Select a new random trip',
          onPressed: context.read<TripViewModel>().selectRandomTrip,
        ),
        actions: [const RouteViewModeButton()],
      ),
      body: Center(
        child: FutureBuilder<Result<TripModel>>(
          future: _loadInitialTrip,
          builder: (BuildContext context,
              AsyncSnapshot<Result<TripModel>> snapshot) {
            if (snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const TripHeadlineWidget(),
                  Expanded(
                    child: const RouteDisplayWidget(),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('Error fetching data');
            } else {
              return const SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
