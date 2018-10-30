import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Time>> fetchTimes() async {
  final response =
      await http.get('http://192.168.0.103:5000');

  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON
    List temp = json.decode(response.body);
    List<Time> returnList = [];
    for(var i = 0; i < temp.length; i++){ 
      returnList.add(Time.fromJson(temp[i]));
    }
    return returnList;
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load post');
  }

}

// A function that will convert a response body into a List<Time>
List<Time> parseTimes(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Time>((json) => Time.fromJson(json)).toList();
}

class Time {
  final int racerID;
  final String racerName;
  final double runDuration;
  final int startTime;

  Time({this.racerID, this.racerName, this.runDuration, this.startTime});

  factory Time.fromJson(Map<String, dynamic> json) {
    return Time(
      racerID: json['racerID'] as int,
      racerName: json['racerName'] as String,
      runDuration: json['runDuration'] as double,
      startTime: json['startTime'] as int,
    );
  }
}