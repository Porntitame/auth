import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../screens/auth_screen.dart';
import '../screens/places_screen.dart';
import 'screens/place_map_screen.dart';
import 'screens/place_map2_screen.dart';
import '../screens/more_info_screen.dart';
import '../screens/more_info2_screen.dart';
import '../screens/tabs_screen.dart';
import '../screens/tabs2_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Indoor Positioning',
      theme: ThemeData(
        accentColor: Colors.deepPurple,
        accentColorBrightness: Brightness.dark,
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
        PlaceMapScreen.routeName: (ctx) => TabsScreen(),
        PlaceMap2Screen.routeName: (ctx) => Tabs2Screen(),
        MoreInfoScreen.routeName: (ctx) => MoreInfoScreen(),
        MoreInfo2Screen.routeName: (ctx) => MoreInfo2Screen(),
      },
    );
  }
}
