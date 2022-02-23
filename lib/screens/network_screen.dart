import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/signal.dart';
import 'dart:async';

import 'package:wifi_hunter/wifi_hunter.dart';
import 'package:wifi_hunter/wifi_hunter_result.dart';

class NetworkScreen extends StatefulWidget {
  static const routeName = '/network';
  @override
  _NetworkScreenState createState() => _NetworkScreenState();
}

class _NetworkScreenState extends State<NetworkScreen> {
  //WiFiHunterResult wiFiHunterResult = WiFiHunterResult();
  WiFiHunterResult wiFiHunterResults = WiFiHunterResult();
  List wiFiHunterResult = [];
  Color huntButtonColor = Colors.lightBlue;

  @override
  void initState() {
    huntWiFis();
    super.initState();
  }

  Future<void> huntWiFis() async {
    setState(() => huntButtonColor = Colors.grey.shade200);

    try {
      //wiFiHunterResult = (await WiFiHunter.huntWiFiNetworks);

      wiFiHunterResults = (await WiFiHunter.huntWiFiNetworks);
      wiFiHunterResult = [];
      for (int index = 0; index < wiFiHunterResults.results.length; index++) {
        // if (['Noon', 'BB Court C_FL1-1']
        //     .contains(wiFiHunterResults.results[index].SSID))
        {
          wiFiHunterResult.add(wiFiHunterResults.results[index]);
        }
        // if (wiFiHunterResults.results[index].SSID == 'Noon' || wiFiHunterResults.results[index].SSID == 'D') {
        //   wiFiHunterResult.add(wiFiHunterResults.results[index]);
        // }
      }
      //wiFiHunterResult = wiFiHunterResults.results.where((element) {
      //   if (element.SSID == 'Noon') {
      //     return true;
      //   }
      //   return false;
      // }).toList();
      huntWiFis();
    } on PlatformException catch (exception) {
      print(exception.toString());
    }

    if (!mounted) return;

    setState(() => huntButtonColor = Colors.grey.shade200);
  }

  // Map<String, bool> _filters = {
  //   'ball_aek': false,
  // };

  // List available = [];
 
  // void _setFilters(Map<String, bool> filterData) {
  //   setState(() {
  //     _filters = filterData;

  //     available = wiFiHunterResult.results.where((SSID) {
  //       if (wiFiHunterResult.results == 'ball_aek') {
  //         return false;
  //       }
  //       return true;
  //     }).toList();
  //     print(available);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber.shade300,
        title: Text(
          "Network",
          style: TextStyle(color: Colors.grey.shade800),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(5),
        child: SingleChildScrollView(
          child: wiFiHunterResult.isNotEmpty
              ? Container(
                  child: Column(
                    children: [
                      ...List.generate(
                        //available.length,
                        wiFiHunterResult.length,
                        (index) => Container(
                          margin: const EdgeInsets.symmetric(vertical: 3),
                          child: Column(
                            children: [
                              ListTile(
                                minVerticalPadding: 1,
                                leading: Text(
                                    wiFiHunterResult[index].level.toString() +
                                        ' dbm'),
                                title: Text(wiFiHunterResult[index].SSID),
                                subtitle: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('BSSID : ' +
                                        wiFiHunterResult[index].BSSID),
                                    Text('Capabilities : ' +
                                        wiFiHunterResult[index].capabilities),
                                    Text('Frequency : ' +
                                        wiFiHunterResult[index]
                                            .frequency
                                            .toString()),
                                    Text('Channel Width : ' +
                                        wiFiHunterResult[index]
                                            .channelWidth
                                            .toString()),
                                    Text('Timestamp : ' +
                                        wiFiHunterResult[index]
                                            .timestamp
                                            .toString()),
                                  ],
                                ),
                              ),
                              Divider(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
        ),
      ),
    );
  }
}
