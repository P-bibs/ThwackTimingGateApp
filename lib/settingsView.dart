import 'dart:async';
import 'requester.dart';
import 'racerCard.dart';
import 'tableConfigureView.dart';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'package:connectivity/connectivity.dart';

import 'globals.dart' as globals;

enum ConfigurationValue  {wand, gun}

class SettingsView extends StatefulWidget {
  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final _deviceName = "Thwack1";
  var _configurationMode = ConfigurationValue.wand;
  final _pickIpController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    _pickIpController.dispose();
    super.dispose();
  }

  //  var _SSID = "";

  // resolveWifi() {
  //   Connectivity().getWifiName().then((val) => setState(() {
  //         _SSID = val;
  //       }));
  // }

  Future<void> _pickStartMode() async {
    switch (await showDialog<ConfigurationValue>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Select Configuration Mode'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () { Navigator.pop(context, ConfigurationValue.wand); },
                child: const Text('Start Wand (Alpine)'),
              ),
              SimpleDialogOption(
                onPressed: () { Navigator.pop(context, ConfigurationValue.gun); },
                child: const Text('Start Gun (Track)'),
              ),
            ],
          );
        }
      )) {
        case ConfigurationValue.wand:
          setState(() { _configurationMode = ConfigurationValue.wand; });
        break;
        case ConfigurationValue.gun:
          setState(() { _configurationMode = ConfigurationValue.gun; });
        break;
      }
    }

  Future<void> _pickIP() async {
    var _pickIpController = TextEditingController(text: globals.currentIP);
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter IP of Finish Line'),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _pickIpController,
              decoration: InputDecoration(
                labelText: 'Enter Pi IP'
              ),
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Enter'),
              onPressed: () {
                setState(() {
                  globals.currentIP = _pickIpController.text;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //  resolveWifi();
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings")
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text("SETTINGS"),
          ),

          Divider(),
          ListTile(
            title: Text("About", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          ListTile(
            title: Text("Device Name"),
            subtitle: Text(_deviceName),
          ),
          // ListTile(
          //   title: Text("Current Wifi"),
          //   subtitle: Text(_SSID),
          // ),
          Divider(),
          ListTile(
            title: Text(
              "Configuration",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            title: const Text("Finish Line IP"),
            subtitle: Text("Currently: " + globals.currentIP),
            onTap: _pickIP,
          ),
          ListTile(
            title: const Text("Start Configuration"),
            subtitle: Text("Currently: " + _configurationMode.toString().substring(_configurationMode.toString().indexOf(".")+1, _configurationMode.toString().length)),
            onTap: _pickStartMode,
          ),
          ListTile(
            title: const Text("ID to Name Conversion Table"),
            subtitle: Text("Tap to Configue"),
            onTap: () {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => TableConfigureView())
              );
            }
          ),

          Divider(),
          ListTile(
            title: Text("Dangerous", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
          ),
          ListTile(
            title: Text("Erase All Times"),
            onTap: (() {})
          )
        ]
      ),
    );
  }
}
/*
Settings

About:
Device Name
SSID

Configuration:
Start Wand
Start Gun

Erase all Times
*/