import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import '../helpers/shared_prefs.dart';

class BikingMap extends StatefulWidget {
  const BikingMap({Key? key}) : super(key: key);

  @override
  State<BikingMap> createState() => _BikingMapState();
}

class _BikingMapState extends State<BikingMap> {
  LatLng latLng = getLatLngFromSharedPrefs();
  late CameraPosition _initialCameraPosition;
  late MapboxMapController controller;

  @override
  void initState() {
    super.initState();
    _initialCameraPosition = CameraPosition(target: latLng, zoom: 12);
  }

  _onMapCreated(MapboxMapController controller) async {
    this.controller = controller;
  }

  _onStyleLoadedCallback() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Biking Map'),
        ),
        body: SafeArea(
            child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: MapboxMap(
                accessToken: dotenv.env['MAPBOX_ACCESS_TOKEN'],
                initialCameraPosition: _initialCameraPosition,
                onMapCreated: _onMapCreated,
                onStyleLoadedCallback: _onStyleLoadedCallback,
                myLocationEnabled: true,
                myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
                minMaxZoomPreference: const MinMaxZoomPreference(14, 17),
              ),
            ),
          ],
        )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.animateCamera(
                CameraUpdate.newCameraPosition(_initialCameraPosition));
          },
          child: const Icon(Icons.my_location),
        ));
  }
}
// KZOO LatLng: 42.29022370217956, -85.58727797138698