import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import '../helpers/mapbox_handler.dart';
import '../helpers/shared_prefs.dart';
import '../screens/view_route.dart';

Widget viewRouteFaButton(BuildContext context) {
  return FloatingActionButton.extended(
      icon: const Icon(Icons.pedal_bike),
      onPressed: () async {
        LatLng sourceLatLng = getTripLatLngFromSharedPrefs('source');
        LatLng destinationLatLng = getTripLatLngFromSharedPrefs('destination');
        Map modifiedResponse =
            await getDirectionsAPIResponse(sourceLatLng, destinationLatLng);

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ViewRoute(modifiedResponse: modifiedResponse)));
      },
      label: const Text('Review Route'));
}
