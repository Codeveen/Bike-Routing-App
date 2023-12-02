import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import '../helpers/shared_prefs.dart';
import '../screens/prepare_route.dart';
import '../widgets/home_bottom_bar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  LatLng latLng = getCurrentLatLngFromSharedPrefs();
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
    /*controller.addSymbol(
      const SymbolOptions(
        geometry: LatLng(-33.86711, 151.1947171),
        iconImage: "assets/icon/burger.png",
      ),
    );*/
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              // Display Map
              height: MediaQuery.of(context).size.height * 0.9,
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
            // Return to Current Location Button
            IconButton(
              onPressed: () {
                controller.animateCamera(
                    CameraUpdate.newCameraPosition(_initialCameraPosition));
              },
              icon: const Icon(Icons.my_location_rounded),
              iconSize: 45,
            ),
          ],
        ),
      ),
      // Search button
      floatingActionButton: FloatingActionButton.large(
        backgroundColor: Colors.blue,
        foregroundColor: const Color.fromARGB(255, 255, 204, 38),
        shape: const CircleBorder(),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const PrepareRoute()));
        },
        child: const Icon(
          Icons.search,
          size: 50,
        ),
      ),
      // Bottom bar with topology and amenity selection plus alignment
      bottomNavigationBar: const HomeBottomBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
