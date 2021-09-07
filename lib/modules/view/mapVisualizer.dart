import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapVisualizer extends StatefulWidget {
  const MapVisualizer({Key? key}) : super(key:key);
  @override
  _MapVisualizerState createState() => _MapVisualizerState();
}

class _MapVisualizerState extends State<MapVisualizer> {
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(-19.87455176494979, -43.92645056136651);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Pontos de Coleta'),
          backgroundColor: Color.fromARGB(255,72,20,69),
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0
          ),
        ),
      ),
    );
  }
}