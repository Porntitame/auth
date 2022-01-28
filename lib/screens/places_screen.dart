import 'package:flutter/material.dart';

import '../widgets/place_item.dart';
import '../models/place_data.dart';
import '../models/place.dart';
import '../widgets/main_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PlacesScreen extends StatefulWidget {
  static const routeName = '/';
  @override
  _PlacesScreenState createState() => _PlacesScreenState();
}

class _PlacesScreenState extends State<PlacesScreen> {
  //void sendMessage() async {
  //   final user = await FirebaseAuth.instance.currentUser();

  //   print(user.uid);
  // }
  // @override
  // void initState() {
  //   final _auth = FirebaseAuth.instance;
  //   final FirebaseUser user = _auth.currentUser().then((FirebaseUser user) {
  //     final userid = user.uid;

  //     print(user);
  //   }) as FirebaseUser;
  // ignore: todo
  // TODO: implement initState
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 153, 170, 1),
        title: Text(
          'Indoor Positioning',
          style: TextStyle(
              fontFamily: 'Lato',
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.grey.shade900),
        ),
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
