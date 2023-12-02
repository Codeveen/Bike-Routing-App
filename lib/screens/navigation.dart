import 'package:flutter/material.dart';
import 'package:flutter_mapbox_navigation/flutter_mapbox_navigation.dart';
import '../helpers/latlng.dart';
// import 'package:flutter_mapbox_navigation/library.dart';
// import 'package:mapbox_gl/mapbox_gl.dart';

import '../helpers/shared_prefs.dart';
import '../screens/home.dart';

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
  //late MapBoxOptions _options;
  // double _distanceRemaining, _durationRemaining;
  late MapBoxNavigationViewController _controller;
  final bool isMultipleStop = false;
  String instruction = "";
  bool arrived = false;
  bool routeBuilt = false;
  bool isNavigating = false;

  @override
  void initState() {
    super.initState();
    initialize();
  }

  Future<void> initialize() async {
    print("hello");
    if (!mounted) return;
    print("if (!mounted) return");

    MapBoxNavigation.instance.setDefaultOptions(MapBoxOptions(
        zoom: 18.0,
        voiceInstructionsEnabled: true,
        bannerInstructionsEnabled: true,
        mode: MapBoxNavigationMode.cycling,
        isOptimized: true,
        units: VoiceUnits.metric,
        simulateRoute: true,
        language: "en"));
    // Setup directions and options
    MapBoxNavigation.instance.registerRouteEventListener(_onRouteEvent);
    print("directions = MapBoxNavigation(onRouteEvent: _onRouteEvent)");
    print("MapBoxOptions");

    // Configure waypoints
    sourceWaypoint = WayPoint(
        name: "Source", latitude: source.latitude, longitude: source.longitude);
    destinationWaypoint = WayPoint(
        name: "Destination",
        latitude: destination.latitude,
        longitude: destination.longitude);
    wayPoints.add(sourceWaypoint);
    wayPoints.add(destinationWaypoint);
    print("waypoints");

    // Start the trip

    await MapBoxNavigation.instance.startNavigation(wayPoints: wayPoints);
    print("await directions.startNavigation");
  }

  @override
  Widget build(BuildContext context) {
    return const Home();
  }

  Future<void> _onRouteEvent(e) async {
    // _distanceRemaining = await MapBoxNavigation.instance.getDistanceRemaining();
    // _durationRemaining = await MapBoxNavigation.instance.getDurationRemaining();

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
}