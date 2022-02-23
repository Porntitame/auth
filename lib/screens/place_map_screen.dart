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
  Color huntButtonColor = Colors.lightBlueAccent.shade100;
  final _locationController = TextEditingController();
  var submit;
  bool isStoped = false;
  var location;

  // final formKey = GlobalKey<FormState>();
  // Signal mySignal = Signal();

  @override
  void initState() {
    submit = () async {
      await _submitData();
    };
    super.initState();
  }

  Future<void> huntWiFis() async {
    if (!isStoped) {
      setState(() => huntButtonColor = Colors.amber.shade300);

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
        Future.delayed(Duration(seconds: 1), () async {
          await _submitData();
          huntWiFis();
        });
      } on PlatformException catch (exception) {
        print(exception.toString());
      }

      if (!mounted) return;

      setState(() => huntButtonColor = Colors.lightBlueAccent.shade100);
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
        location = response.body;
      });

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    } catch (e) {
      setState(() {
        submit = () async {
          await _submitData();
        };
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: 80,
                  child: TextButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(huntButtonColor)),
                    child: Row(
                      children: [
                        Icon(Icons.navigation_outlined),
                        Text(
                          'Start',
                          style: TextStyle(color: Colors.grey.shade800),
                        ),
                      ],
                    ),
                    onPressed: () => clickHuntWifi(),
                  ),
                ),
                wiFiHunterResult.isNotEmpty
                    ? Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.location_on),
                              Text('location : ${location}')
                            ],
                          ),
                        ],
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
