import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsController extends StatefulWidget {
  const GoogleMapsController({super.key});
  
  @override
  State<GoogleMapsController> createState() =>
      _GoogleMapsControllerState();
}

class _GoogleMapsControllerState extends State<GoogleMapsController> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(-5.08921, -42.80165);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Mapa de Teresina'),
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(target: _center, zoom: 11.0,),
        )
      );
  }
}