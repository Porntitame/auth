import 'package:flutter/material.dart';

class MoreInfo2Screen extends StatelessWidget {
  static const routeName = '/more-info2';

  Widget buildCard(String Device, String SSID, String RSSI) {
    return Container(
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey.shade200,
              radius: 30,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: FittedBox(
                  child: Text(
                    Device,
                    style: TextStyle(fontSize: 15, color: Colors.grey.shade900),
                  ),
                ),
              ),
            ),
            title: Text(
              'SSID : ',
              style: TextStyle(fontSize: 15, color: Colors.grey.shade900),
            ),
            subtitle: Text(
              'RSSI : ',
              style: TextStyle(fontSize: 15, color: Colors.grey.shade900),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                child: Image.asset('assets/images/corridor.jpg'),
              ),
              Card(
                child: ListTile(
                  leading: Container(
                      height: 30, child: Image.asset('assets/images/logo.png')),
                  title: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text('3rd Floor Corridor'),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                        'Located in  : Telecommunication Engineering Department'),
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(
                    Icons.square_foot_outlined,
                    color: Colors.amber,
                    size: 30,
                  ),
                  title: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text('Area Size'),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text('size : 2.1 x 33.0 square meters'),
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(
                    Icons.description,
                    color: Colors.blue,
                  ),
                  title: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text('description'),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text('-'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


      //         TextButton(
      //             child: Row(
      //               children: [
      //                 Icon(Icons.wifi),
      //                 Text('Network'),
      //               ],
      //             ),
      //             onPressed: () {
      //               Navigator.of(context)
      //                   .pushReplacementNamed(NetworkScreen.routeName);
      //             }),
      //         FloatingActionButton(onPressed: () {
      //           Navigator.of(context)
      //               .pushReplacementNamed(NetworkScreen.routeName);
      //         })
      //       ],
      //     ),
      //   ),
      // ),

//         children: [
//           Padding(
//             padding: const EdgeInsets.all(15),
//             child: Container(
//               color: Colors.amber,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Icon(Icons.location_on_outlined),
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Text('Laboratory T-203'),
//                       Text(
//                         'Located in  : Telecommunication Engineering Department, ',
//                       ),
//                       Text(
//                           'King Mongkut\'s Institude of Technology Ladkrabang'),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Container(
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     Icon(Icons.wifi),
//                     Text('network'),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     Text('device 1'),
//                     Column(
//                       children: [
//                         Text('SSID : '),
//                       ],
//                     ),
//                     Text('RSSI : ')
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Text('device 2'),
//                     Column(
//                       children: [
//                         Text('SSID : '),
//                       ],
//                     ),
//                     Text('RSSI : ')
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Text('device 3'),
//                     Column(
//                       children: [
//                         Text('SSID : '),
//                       ],
//                     ),
//                     Text('RSSI : ')
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Text('device 4'),
//                     Column(
//                       children: [
//                         Text('SSID : '),
//                       ],
//                     ),
//                     Text('RSSI : ')
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Text('device 5'),
//                     Column(
//                       children: [
//                         Text('SSID : '),
//                       ],
//                     ),
//                     Text('RSSI : ')
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             child: Text('Your location : '),
//           )
//         ],
//       ),
