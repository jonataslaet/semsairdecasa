import 'package:flutter/material.dart';

import '../controllers/city_list_controller.dart';

class CityListingView extends StatelessWidget {
  const CityListingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CityListController()
      ),
    );

  }
}

