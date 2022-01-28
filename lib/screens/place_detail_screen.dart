import 'package:flutter/material.dart';

import '../models/place_data.dart';

class PlaceDetailScreen extends StatelessWidget {
  static const routeName = '/place-detail';

  @override
  Widget build(BuildContext context) {
    final placeId = ModalRoute.of(context).settings.arguments as String;
    final selectedPlace =
        PLACE_CATEGORIES.firstWhere((place) => place.id == placeId);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 760,
                  color: Colors.white,
                  child: Image.asset(
                    'assets/images/t203.jpg',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
