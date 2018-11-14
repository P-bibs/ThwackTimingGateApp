import 'dart:async';
import 'requester.dart';
import 'racerCard.dart';
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
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myController.dispose();
    super.dispose();
  }

  //  var _SSID = "";

  // resolveWifi() {
  //   Connectivity().getWifiName().then((val) => setState(() {
  //         _SSID = val;
  //       }));
  // }

  void changeIP(){
    setState(() {
      globals.currentIP = myController.text;
    });
  }

  Future<void> _pickStartMode1() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pick Start Mode'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new RadioListTile<ConfigurationValue>(
                title: const Text('Start Wand (Alpine)'),
                value: ConfigurationValue.wand,
                groupValue: _configurationMode,
                onChanged: (ConfigurationValue value) { setState(() { _configurationMode = value; }); },
              ),
              new RadioListTile<ConfigurationValue>(
                title: const Text('Start Gun (Track)'),
                value: ConfigurationValue.gun,
                groupValue: _configurationMode,
                onChanged: (ConfigurationValue value) { setState(() { _configurationMode = value; }); },
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Confirm'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

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

  @override
  Widget build(BuildContext context) {
    //  resolveWifi();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("SETTINGS"),
        Divider(),
        Text("About",
        style: TextStyle(fontWeight: FontWeight.bold),),
        Text("Device Name: " + _deviceName),
        //  Text("Current Network: " + _SSID),
        Text("Current Target IP: " + globals.currentIP),
        Divider(),
        ListTile(
          title: Text(
            "Configuration",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Row(
          
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: myController,
                  decoration: InputDecoration(
                    labelText: 'Enter Pi IP'
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                child: Text("Enter"),
                onPressed: changeIP,
              ),
            )
          ],
        ),
        ListTile(
          title: const Text("Finish Line IP"),
          subtitle: Text("Currently: " + globals.currentIP),
        ),
        ListTile(
          title: const Text("Start Configuration"),
          subtitle: Text("Currently: " + _configurationMode.toString()),
          onTap: _pickStartMode,
        ),

        Divider(),

        Text("Dangerous",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
        ),
        ListTile(
          title: Text("Erase All Times"),
          onTap: (() {})
        )
      ]
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