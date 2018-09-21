import 'dart:async';
import 'requester.dart';
import 'racerCard.dart';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

enum ConfigurationValue  {wand, gun}

class SettingsView extends StatefulWidget {
  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final _deviceName = "Thwack1";
  var _configurationMode = ConfigurationValue.wand;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("SETTINGS"),
        Divider(),
        Text("About",
        style: TextStyle(fontWeight: FontWeight.bold),),
        Text("Device Name: " + _deviceName),
        Divider(),
        Text("Configuration",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
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


Configuration:
Start Wand
Start Gun

Erase all Times
*/