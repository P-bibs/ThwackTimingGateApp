import 'dart:async';
import 'dart:convert';

import 'globals.dart' as globals;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Time>> fetchTimes() async {
  final response =
      await http.get('http://' + globals.currentIP + ':5000/results');

  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON
    List data = json.decode(response.body);

    List<Time> returnList = [];
    for(var i = 0; i < data.length; i++){ 
      returnList.add(Time.fromJson(data[i]));
    }
    return returnList;

  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load post');
  }
}

class Time {
  final int racerID;
  final String racerName;
  final double runDuration;
  final String startTime;

  Time({this.racerID, this.racerName, this.runDuration, this.startTime});

  factory Time.fromJson(Map<String, dynamic> json) {
    return Time(
      racerID: json['racerID'] as int,
      racerName: json['racerName'] as String,
      runDuration: json['runDuration'] as double,
      startTime: json['startTime'] as String,
    );
  }
}

Future<List<Map<String, dynamic>>> fetchTable() async {
  final response =
      await http.get('http://' + globals.currentIP + ':5000/idTable');

  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON
    List data = json.decode(response.body);
    return data;

    // List<TableItem> returnList = [];
    // for(var i = 0; i < data.length; i++){ 
    //   returnList.add(TableItem.fromJson(data[i]));
    // }
    // return returnList;

  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load post');
  }
}