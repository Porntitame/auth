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
  double x = 2.5;
  double y = 6.7;
  List<List<Map>> datasets = [];
  Map<String, double> data = {};

  @override
  void initState() {
    submit = () async {
      await _submitData();
    };
    super.initState();
  }

  double sumArray(arr) {
    double sum = 0;
    for (var i = 0; i < arr.length; i++) {
      sum += arr[i];
    }
    return sum / arr.length;
  }

  Future<void> huntWiFis() async {
    if (!isStoped) {
      setState(() => huntButtonColor = Colors.blue.shade500);

      try {
        wiFiHunterResults = (await WiFiHunter.huntWiFiNetworks);
        wiFiHunterResult = [];
        dataset = [];

        for (int index = 0; index < wiFiHunterResults.results.length; index++) {
          if ([
            'Device1',
            'Device2',
            'Device3',
            'Device4',
          ].contains(wiFiHunterResults.results[index].SSID))
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
              'SSID': wiFiHunterResults.results[index].SSID,
              'RSSI': wiFiHunterResults.results[index].level,
            });
          }
        }
        datasets.add(dataset);
        //print(datasets);

        Future.delayed(Duration(seconds: 0), () async {
          if (datasets.length == 5) {
            Map<String, List<int>> temp = {};
            for (var i = 0; i < datasets.length; i++) {
              for (var j = 0; j < datasets[i].length; j++) {
                if (temp[datasets[i][j]["SSID"]] != null) {
                  temp[datasets[i][j]["SSID"]].add(datasets[i][j]["RSSI"]);
                } else {
                  temp[datasets[i][j]["SSID"]] = [datasets[i][j]["RSSI"]];
                }
              }
            }

            // temp = {
            //  Device_1 : [55,20],
            //  Device_2 : [20]
            // }

            const sendApiKeys = [
              'rssi_0',
              'rssi_1',
              'rssi_2',
              'rssi_3',
            ]; //Object.sendApiKeys(temp); // ['key1', 'key2']
            for (var i = 0; i < sendApiKeys.length; i++) {
              data[sendApiKeys[i]] = 0;
            }

            // data = {
            // 'rssi_0': 0,
            // 'rssi_1': 0,
            // ..
            // 'rssi_10': 0
            // }

            List readSsidKeys = [];
            temp.keys.forEach((key) {
              readSsidKeys.add(key);
            });
            // readSsidKeys = ['Device_1', 'Device_2']

            for (var index = 0; index < readSsidKeys.length; index++) {
              String mapKey = '';
              switch (readSsidKeys[index]) {
                case 'Device1':
                  {
                    mapKey = sendApiKeys[0];
                  }
                  break;
                case 'Device2':
                  {
                    mapKey = sendApiKeys[1];
                  }
                  break;
                case 'Device3':
                  {
                    mapKey = sendApiKeys[2];
                  }
                  break;
                case 'Device4':
                  {
                    mapKey = sendApiKeys[3];
                  }
                  break;
              }
              data[mapKey] = sumArray(temp[readSsidKeys[index]]);
            }
            print(data);

            await _submitData();
            datasets = [];
          }

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
    // Map<String, dynamic> playload = {"dataset": data};
    try {
      var url = Uri.parse('http://161.246.18.222:8888/rssi/');
      var response = await http.post(
        url,
        body: json.encode(data),
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
        height: 1000,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/grid1.jpg"),
            fit: BoxFit.cover,
          ),
        ),
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
                          image: AssetImage("assets/images/coWorking.jpg"),
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
                                    child: Image.asset('assets/images/lo.png')),
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