import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_complete_guide/screens/network_screen.dart';

import '../screens/auth_screen.dart';
import '../screens/places_screen.dart';
import '../screens/place_detail_screen.dart';
import '../screens/more_info_screen.dart';
import '../screens/tabs_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Indoor Positioning',
      theme: ThemeData(
        // primarySwatch: Colors.pink,
        // backgroundColor: Colors.pink,
        accentColor: Colors.deepPurple,
        accentColorBrightness: Brightness.dark,
        // buttonTheme: ButtonTheme.of(context).copyWith(
        //   textTheme: ButtonTextTheme.primary,
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(20),
        //   ),
        // ),
      ),
      home: StreamBuilder(
          stream: FirebaseAuth.instance.onAuthStateChanged,
          builder: (ctx, userSnapshot) {
            if (userSnapshot.hasData) {
              return PlacesScreen();
            }
            return AuthScreen();
          }),
      routes: {
        PlaceDetailScreen.routeName: (ctx) => TabsScreen(),
        MoreInfoScreen.routeName: (ctx) => MoreInfoScreen(),
        NetworkScreen.routeName: (ctx) => NetworkScreen(),
      },
    );
  }
}
