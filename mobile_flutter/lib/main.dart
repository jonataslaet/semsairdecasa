import 'package:flutter/material.dart';
import 'package:mobile_flutter/views/city_listing_view.dart';

import 'views/entry_view.dart';

Future<void> main(List<String> arguments) async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      title: 'Presentation Page',
      initialRoute: '/',
      home: const EntryView(),
      routes: {
        '/cities': (context) => const CityListingView()
      },
    );
  }
}