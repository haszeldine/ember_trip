import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'trip_view_model.dart';

class TripView extends StatelessWidget {
  const TripView({super.key});

  @override
  Widget build(BuildContext context) {
    TripViewModel tripViewModel = context.watch<TripViewModel>();

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
        child: Column(
          children: <Widget>[
            Text(tripViewModel.tripUid ?? 'None'),
          ],
        ),
      ),
    );
  }
}
