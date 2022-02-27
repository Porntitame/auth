import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'screens/places_screen.dart';
import 'screens/more_info_screen.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 38),
            height: 57,
            width: double.infinity,
            padding: EdgeInsets.all(10),
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                    height: 30, child: Image.asset("assets/images/logo.png")),
                Text(
                  '  My',
                  style: TextStyle(
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.amber),
                ),
                Text(
                  'Account ',
                  style: TextStyle(
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.lightBlue),
                ),
              ],
            ),
          ),
          Divider(),
          SizedBox(
            height: 0,
          ),
          Container(
            child: Column(
              children: [
                Container(
                  height: 60,
                  child: ListTile(
                    horizontalTitleGap: 5,
                    leading: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.account_circle,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    title: Text('Username : ',
                        style: TextStyle(
                            fontSize: 16, color: Colors.grey.shade800)),
                    subtitle: Text('Porntita Meesat',
                        style: TextStyle(
                            fontSize: 16, color: Colors.grey.shade600)),
                  ),
                ),
                Divider(),
                Container(
                  height: 60,
                  child: ListTile(
                    horizontalTitleGap: 5,
                    leading: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.mail_outlined,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    title: Text('Email : ',
                        style: TextStyle(
                            fontSize: 16, color: Colors.grey.shade800)),
                    subtitle: Text('61011402@KMITL.ac.th',
                        style: TextStyle(
                            fontSize: 16, color: Colors.grey.shade600)),
                  ),
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: EdgeInsets.all(20),
                      height: 35,
                      width: 100,
                      color: Colors.grey.shade200,
                      child: TextButton(
                          child: Row(
                            children: [
                              Text(
                                'Log Out',
                                style:
                                    TextStyle(fontSize: 15, color: Colors.pink),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Container(
                                    height: 30,
                                    child: Image.asset(
                                        "assets/images/logout.png")),
                              ),
                            ],
                          ),
                          onPressed: () {
                            FirebaseAuth.instance.signOut();
                          }),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
//77