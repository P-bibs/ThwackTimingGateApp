import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Time>> fetchTimes(http.Client client) async {
  final response =
      //await client.get('https://jsonplaceholder.typicode.com/Times');
      //await client.get('http://localhost:3000/times');
      await client.get(new Uri.http('10.0.2.2:3000', '/times'));

  // Use the compute function to run parseTimes in a separate isolate
  return compute(parseTimes, response.body);
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

// Future<Post> fetchPost() async {
//   final response =
//       //await http.get('https://jsonplaceholder.typicode.com/posts/1');
//       await http.get('http://localhost:3000/racers/');

//   if (response.statusCode == 200) {
//     // If the call to the server was successful, parse the JSON
//     return Post.fromJson(json.decode(response.body));
//   } else {
//     // If that call was not successful, throw an error.
//     throw Exception('Failed to load post');
//   }
// }

// class Post {
//   final int racerID;
//   final int racerName;
//   final String runDuration;
//   final String startTime;

//   Post({this.racerID, this.racerName, this.runDuration, this.startTime});

//   factory Post.fromJson(Map<String, dynamic> json) {
//     return Post(
//       racerID: json['racerID'],
//       racerName: json['racerName'],
//       runDuration: json['runDuration'],
//       startTime: json['startTime'],
//     );
//   }
// }