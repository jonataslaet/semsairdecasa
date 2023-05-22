import 'package:flutter/material.dart';
import 'package:mobile_flutter/views/city_listing_view.dart';
import 'package:mobile_flutter/views/maps_view.dart';
import 'views/entry_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Presentation Page',
      initialRoute: '/',
      home: const EntryView(),
      routes: {
        '/maps': (context) => const MapsView(),
        '/cities': (context) => const CityListingView()
      },
    );
  }
}