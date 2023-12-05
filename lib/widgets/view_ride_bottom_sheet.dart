import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:graphhooper_route_navigation/graphhooper_route_navigation.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import '../helpers/shared_prefs.dart';

LatLng userLocation = getTripLatLngFromSharedPrefs('source');
LatLng destination = getTripLatLngFromSharedPrefs('destination');

DirectionRouteResponse directionRouteResponse = DirectionRouteResponse();

getDataFromTheServer() async {
  ApiRequest apiRequest = ApiRequest();

  directionRouteResponse = await apiRequest.getDrivingRouteUsingGraphHooper(
      customBaseUrl: '',
      source: userLocation,
      destination: destination,
      navigationType: NavigationProfile.car,
      graphHooperApiKey: '0f33aa96-74ba-4e6f-9da6-720a08c91520');
}

Widget viewRideBottomSheet(
    BuildContext context, String distance, String dropOffTime) {
  String sourceAddress = getSourceAndDestinationPlaceText('source');
  String destinationAddress = getSourceAndDestinationPlaceText('destination');
  getDataFromTheServer();

  return Positioned(
    bottom: 0,
    child: SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('$sourceAddress ➡ $destinationAddress',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.indigo)),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    tileColor: Colors.grey[200],
                    title: Text('$distance mi ► $dropOffTime min'),
                  ),
                ),
                ElevatedButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => MapRouteNavigationScreenPage(
                                directionRouteResponse,
                                dotenv.env['MAPBOX_ACCESS_TOKEN']!))),
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(15),
                        backgroundColor: Colors.blue),
                    child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Start Route',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ])),
              ]),
        ),
      ),
    ),
  );
}
