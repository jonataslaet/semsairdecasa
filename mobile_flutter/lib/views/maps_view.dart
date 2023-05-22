import 'package:flutter/material.dart';
import 'package:mobile_flutter/controllers/google_maps_controller.dart';

class MapsView extends StatelessWidget {
  const MapsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: GoogleMapsController()
      ),
    );
  }
}