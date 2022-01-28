import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

import '../models/place_data.dart';

import './network_screen.dart';

class MoreInfoScreen extends StatelessWidget {
  static const routeName = '/more-info';

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
                child: Image.asset('assets/images/room.jpg'),
              ),
              Card(
                child: ListTile(
                  leading: Icon(
                    Icons.location_on_outlined,
                    color: Colors.grey.shade800,
                  ),
                  title: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text('Laboratory T-203'),
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
                    Icons.person_pin_circle,
                    color: Colors.grey.shade800,
                  ),
                  title: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text('Your location : '),
                  ),
                ),
              ),
              GestureDetector(
                child: Card(
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.wifi),
                        title: Text('Network'),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(NetworkScreen.routeName);
                },
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
