//noon
import 'package:flutter/material.dart';

import 'place_map_screen.dart';
import './more_info_screen.dart';
import '../models/place_data.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages;
  int _selectPageIndex = 0;

  @override
  void initState() {
    var selectedPlace;
    _pages = [
      {'page': PlaceMapScreen(), 'title': 'Co-working Space'},
      {'page': MoreInfoScreen(), 'title': 'Information'},
    ];

    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final placeId = ModalRoute.of(context).settings.arguments as String;
    final selectedPlace =
        PLACE_CATEGORIES.firstWhere((place) => place.id == placeId);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Container(height: 30, child: Image.asset("assets/images/logo.png")),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                _pages[_selectPageIndex]['title'],
                style: TextStyle(color: Colors.grey.shade800),
              ),
            ),
          ],
        ),
        iconTheme: IconThemeData(color: Colors.grey.shade700),
      ),
      body: _pages[_selectPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Colors.grey.shade300,
        unselectedItemColor: Colors.grey.shade600,
        selectedItemColor: Colors.lightBlueAccent.shade400,
        currentIndex: _selectPageIndex,
        //type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.map_sharp,
            ),
            title: Text('Map'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.info_outline,
            ),
            title: Text('Information'),
          ),
        ],
      ),
    );
  }
}
