import 'package:flutter/material.dart';

// import 'screens/place_map_screen.dart';
// import 'screens/place_map2_screen.dart';

// import 'models/place.dart';

class PlaceItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final String location;

  PlaceItem({
    @required this.id,
    @required this.title,
    @required this.location,
    @required this.imageUrl,
  });

  void selectPlace(BuildContext context) {
    Navigator.of(context)
        .pushNamed(
      id == 'p1'
          ? '/place-map'
          : id == 'p2'
              ? '/place-map2'
              : '/',
      arguments: id,
    )
        .then((result) {
      if (result != null) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectPlace(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.asset(
                    imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 1,
                  left: 1,
                  child: Container(
                    width: 400,
                    color: Colors.black54,
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 5,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 26,
                            color: Colors.white,
                          ),
                          softWrap: true,
                          overflow: TextOverflow.fade,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Padding(
            //   padding: EdgeInsets.all(20),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     children: <Widget>[
            //       Icon(
            //         Icons.place,
            //         color: Colors.red,
            //       ),
            //       SizedBox(
            //         width: 6,
            //       ),
            //       Text(location),
            //     ],
            //   ),
            // )
            Container(
              height: 60,
              child: ListTile(
                horizontalTitleGap: 5,
                leading: Icon(
                  Icons.place,
                  color: Colors.red,
                ),
                title: Text(location),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
