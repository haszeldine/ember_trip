import 'package:ember_trip/src/feature/trip/trip_headline_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'trip_view_model.dart';

class TripView extends StatelessWidget {
  const TripView({super.key});

  @override
  Widget build(BuildContext context) {
    final tripViewModel = context.watch<TripViewModel>();
    final loading = tripViewModel.tripModel == null;

    return Scaffold(
      appBar: AppBar(
        title: Text('Trip Viewer'),
        leading: IconButton(
          icon: Icon(Icons.refresh),
          tooltip: 'Select a new random trip',
          onPressed: () => tripViewModel.selectRandomTrip(),
        ),
      ),
      body: Center(
        child: loading
            ? SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              )
            : Column(
          children: <Widget>[
                  TripHeadlineWidget(tripViewModel.collectHeadlineData()),
          ],
        ),
      ),
    );
  }
}
