import 'package:flutter/material.dart';

import '../place_item.dart';
import '../models/place_data.dart';
import '../models/place.dart';
import '../main_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PlacesScreen extends StatefulWidget {
  static const routeName = '/';
  @override
  _PlacesScreenState createState() => _PlacesScreenState();
}

class _PlacesScreenState extends State<PlacesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Text(
              'My',
              style: TextStyle(
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.amber),
            ),
            Text(
              'Maps ',
              style: TextStyle(
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.lightBlue),
            ),
            Container(
                padding: EdgeInsets.only(left: 8),
                height: 30,
                child: Image.asset("assets/images/map.png")),
          ],
        ),
        iconTheme: IconThemeData(color: Colors.grey.shade700),
      ),
      drawer: MainDrawer(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView.builder(
          itemBuilder: (ctx, index) {
            return PlaceItem(
                id: PLACE_CATEGORIES[index].id,
                title: PLACE_CATEGORIES[index].title,
                location: PLACE_CATEGORIES[index].location,
                imageUrl: PLACE_CATEGORIES[index].imageUrl);
          },
          itemCount: PLACE_CATEGORIES.length,
        ),
      ),
    );
  }
}
