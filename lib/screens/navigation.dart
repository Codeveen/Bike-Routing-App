/*import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
//import 'package:flutter_mapbox_navigation/flutter_mapbox_navigation.dart';
import 'package:flutter_mapbox_navigation/library.dart';
import 'package:get/get.dart';
import 'package:graphhooper_route_navigation/graphhooper_route_navigation.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import '../helpers/shared_prefs.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  // Waypoints to mark trip start and end
  LatLng source = getTripLatLngFromSharedPrefs('source');
  LatLng destination = getTripLatLngFromSharedPrefs('destination');
  late WayPoint sourceWaypoint, destinationWaypoint;
  var wayPoints = <WayPoint>[];

  // Config variables for Mapbox Navigation
  late MapBoxNavigation directions;
  late MapBoxOptions _options;
  late double distanceRemaining, durationRemaining;
  late MapBoxNavigationViewController _controller;
  final bool isMultipleStop = false;
  String instruction = "";
  bool arrived = false;
  bool routeBuilt = false;
  bool isNavigating = false;

  DirectionRouteResponse directionRouteResponse = DirectionRouteResponse();

  @override
  void initState() {
    super.initState();
    initialize();
  }

  Future<void> initialize() async {
    if (!mounted) return;

    // Setup directions and options

    directions = MapBoxNavigation(onRouteEvent: _onRouteEvent);
    _options = MapBoxOptions(
        zoom: 18.0,
        voiceInstructionsEnabled: true,
        bannerInstructionsEnabled: true,
        mode: MapBoxNavigationMode.drivingWithTraffic,
        isOptimized: true,
        units: VoiceUnits.metric,
        simulateRoute: true,
        language: "en");

    // Configure waypoints
    sourceWaypoint = WayPoint(
        name: "Source", latitude: source.latitude, longitude: source.longitude);
    destinationWaypoint = WayPoint(
        name: "Destination",
        latitude: destination.latitude,
        longitude: destination.longitude);
    wayPoints.add(sourceWaypoint);
    wayPoints.add(destinationWaypoint);

    // Start the trip
    //await directions.startNavigation(wayPoints: wayPoints, options: _options);

    ApiRequest apiRequest = ApiRequest();

    directionRouteResponse = await apiRequest.getDrivingRouteUsingGraphHooper(
        customBaseUrl: '',
        source: source,
        destination: destination,
        navigationType: NavigationProfile.car,
        graphHooperApiKey: '0f33aa96-74ba-4e6f-9da6-720a08c91520');
  }

  CalculatorUtils calculatorUtils = CalculatorUtils();
  buildNavigateToBottomSheetUI(DirectionRouteResponse directionRouteResponse) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.white,
          ),
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20))),
      padding: EdgeInsets.all(16.0),
      height: 168.0,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${calculatorUtils.calculateTime(miliSeconds: directionRouteResponse.paths![0].time!)} (${(directionRouteResponse.paths![0].distance! / 1000).toStringAsFixed(2)}km)',
                style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.normal,
                    height: 1.25,
                    letterSpacing: 0.0,
                    color: Colors.black),
              ),
              IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(
                    Icons.close,
                    color: NavigationColors.black,
                  ))
            ],
          ),
          const SizedBox(
            height: 16.0,
          ),
          ElevatedButton.icon(
              // color: NaxaAppColors.red,
              onPressed: () async {
                Get.back();
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  Get.to(MapRouteNavigationScreenPage(directionRouteResponse,
                      dotenv.env['MAPBOX_ACCESS_TOKEN']!));
                });
              },
              icon: const Icon(
                Icons.navigation_outlined,
                color: Colors.white,
              ),
              label: Text(
                'Start Navigation',
                style: CustomAppStyle.body14pxRegular(context)
                    .copyWith(color: NavigationColors.white.withOpacity(0.9)),
              )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildNavigateToBottomSheetUI(directionRouteResponse);
  }

  Future<void> _onRouteEvent(e) async {
    distanceRemaining = await directions.distanceRemaining;
    durationRemaining = await directions.durationRemaining;

    switch (e.eventType) {
      case MapBoxEvent.progress_change:
        var progressEvent = e.data as RouteProgressEvent;
        arrived = progressEvent.arrived!;
        if (progressEvent.currentStepInstruction != null) {
          instruction = progressEvent.currentStepInstruction!;
        }
        break;
      case MapBoxEvent.route_building:
      case MapBoxEvent.route_built:
        routeBuilt = true;
        break;
      case MapBoxEvent.route_build_failed:
        routeBuilt = false;
        break;
      case MapBoxEvent.navigation_running:
        isNavigating = true;
        break;
      case MapBoxEvent.on_arrival:
        arrived = true;
        if (!isMultipleStop) {
          await Future.delayed(const Duration(seconds: 3));
          await _controller.finishNavigation();
        } else {}
        break;
      case MapBoxEvent.navigation_finished:
      case MapBoxEvent.navigation_cancelled:
        routeBuilt = false;
        isNavigating = false;
        break;
      default:
        break;
    }
    //refresh UI
    setState(() {});
  }
}*/
