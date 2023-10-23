import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

    @override
    Widget build(BuildContext context) {
      return FlutterMap(
        options: MapOptions(
          center: LatLng(-85.5872, 42.2917),
          zoom: 10,
        ),
        children: [
          TileLayer(
            urlTemplate:'https://api.mapbox.com/styles/v1/praveen28/clnokbex2008g01qu33nrfvas/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoicHJhdmVlbjI4IiwiYSI6ImNsbWs0YngwOTA5YjAyc280eWJzdWptOWgifQ.cVTUe_NY8GChWktCpxL_DA',
            additionalOptions: {
              'accessToken': 'pk.eyJ1IjoicHJhdmVlbjI4IiwiYSI6ImNsbWs0YngwOTA5YjAyc280eWJzdWptOWgifQ.cVTUe_NY8GChWktCpxL_DA',
              'id': 'mapbox.mapbox-streets-v8'
            },
          ),
        ],
      );
    }
}
