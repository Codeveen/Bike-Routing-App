import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:nav_application/screens/prepare_route.dart';
import 'package:nav_application/widgets/amenity_toggle.dart';

import '../helpers/shared_prefs.dart';
import '../widgets/topology_toggle.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  LatLng latLng = getCurrentLatLngFromSharedPrefs();
  late CameraPosition _initialCameraPosition;
  late MapboxMapController controller;
  int selectedIndex = 0;

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
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
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
      // Prepare Route Button
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
      // Bottom Bar with Topologies and Amenities
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.edit_road_rounded),
            label: 'Stress Level',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_bulleted_rounded),
            label: 'Amenities',
          ),
        ],
        backgroundColor: Colors.blue[400],
        iconSize: 35,
        selectedItemColor: Colors.white,
        currentIndex: selectedIndex,
        onTap: (int index) {
          switch (index) {
            case 0:
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    scrollable: true,
                    title: const Text("Street Topologies"),
                    content: const Padding(
                      padding: EdgeInsets.all(0),
                      child: TopologyToggle(),
                    ),
                    actions: [
                      ElevatedButton(
                        child: const Text("Done"),
                        onPressed: () {
                          // Add captureSelection
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                },
              );
              break;
            case 1:
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    scrollable: true,
                    title: const Text("Amenities"),
                    content: const Padding(
                      padding: EdgeInsets.all(0),
                      child: AmenityToggle(),
                    ),
                    actions: [
                      ElevatedButton(
                        child: const Text("Done"),
                        onPressed: () {
                          // Add captureSelection
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                },
              );
              break;
          }
          setState(
            () {
              selectedIndex = index;
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
