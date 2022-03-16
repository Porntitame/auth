import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:async';
import 'package:wifi_hunter/wifi_hunter.dart';
import 'package:wifi_hunter/wifi_hunter_result.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class PlaceMapScreen extends StatefulWidget {
  static const routeName = '/place-map';

  @override
  State<PlaceMapScreen> createState() => _PlaceMapScreenState();
}

class _PlaceMapScreenState extends State<PlaceMapScreen> {
  WiFiHunterResult wiFiHunterResults = WiFiHunterResult();
  List wiFiHunterResult = [];
  List<Map> dataset = [];
  Color huntButtonColor = Colors.blue.shade400;
  var submit;
  bool isStoped = false;
  String locations;
  Map<String, dynamic> location = {};
  double x = 0;
  double y = 0;

  @override
  void initState() {
    submit = () async {
      await _submitData();
    };
    super.initState();
  }

  Future<void> huntWiFis() async {
    if (!isStoped) {
      setState(() => huntButtonColor = Colors.blue.shade500);

      try {
        wiFiHunterResults = (await WiFiHunter.huntWiFiNetworks);
        wiFiHunterResult = [];
        dataset = [];

        for (int index = 0; index < wiFiHunterResults.results.length; index++) {
          // if ([
          //   'cc:2d:21:91:6c:61',
          //   '74:22:bb:8a:02:5c',
          //   '00:2e:c7:8f:f1:68',
          //   '00:2e:c7:8f:f2:67',
          //   '78:44:76:ec:26:48',
          //   'cc:2d:21:91:81:c1',
          //   '00:2e:c7:8f:f1:c6',
          //   '00:2e:c7:8f:f1:61',
          //   '00:2e:c7:8f:f1:63',
          //   '00:2e:c7:8f:f1:69'
          // ].contains(wiFiHunterResults.results[index].BSSID))
          {
            wiFiHunterResult.add(wiFiHunterResults.results[index]);

            dataset.add({
              'BSSID': wiFiHunterResults.results[index].BSSID,
              'RSSI': wiFiHunterResults.results[index].level,
            });
          }
        }
        Future.delayed(Duration(seconds: 0), () async {
          await _submitData();
          huntWiFis();
        });
      } on PlatformException catch (exception) {
        print(exception.toString());
      }
      //if (!mounted) return;
      setState(() => huntButtonColor = Colors.blue.shade400);
    }
  }

  Future<void> clickHuntWifi() async {
    await huntWiFis();
  }

  Future<void> _submitData() async {
    setState(() => submit = null);

    Map<String, dynamic> playload = {"dataset": dataset};
    try {
      var url = Uri.parse('http://192.168.137.108:8000/rssi-to-coordinate');
      var response = await http.post(
        url,
        body: json.encode(playload),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      setState(() {
        submit = () async {
          await _submitData();
        };
        locations = response.body;
        location = json.decode(locations);
        x = location['x'].toDouble();
        y = location['y'].toDouble();
      });

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: 100,
                  margin: const EdgeInsets.symmetric(vertical: 20.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(huntButtonColor)),
                    child: Row(
                      children: [
                        Icon(
                          Icons.navigation_rounded,
                          color: Colors.white,
                        ),
                        Text(
                          'Start',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    onPressed: () => clickHuntWifi(),
                  ),
                ),
                ClipRect(
                  child: InteractiveViewer(
                    child: Container(
                      width: 500,
                      height: 470,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/t203.jpg"),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      child: Stack(
                        children: <Widget>[
                          new Positioned.fill(
                            child: new LayoutBuilder(
                              builder: (context, constraints) {
                                return Transform.translate(
                                  offset: Offset(
                                    (constraints.biggest.width * (x + 1) / 7) -
                                        (constraints.biggest.width / 2),
                                    (constraints.biggest.height * (y + 1) / 8) -
                                        (constraints.biggest.height / 2),
                                  ),
                                  child: Icon(
                                    Icons.location_on,
                                    color: Colors.red,
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                location.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                    height: 30,
                                    child:
                                        Image.asset('assets/images/logo.png')),
                                Text('Your location : ${location.values}'),
                              ],
                            ),
                          ],
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




// child: Stack(
                      //   alignment: ,
                      //   children: [
                      //     Positioned(
                      //       top: x,
                      //       left: y,
                      //       child: Icon(
                      //         Icons.location_on,
                      //         color: Colors.red,
                      //       ),
                      //     ),
                      //   ],
                      // ),