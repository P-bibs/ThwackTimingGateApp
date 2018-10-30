import 'dart:async';
import 'requester.dart';
import 'racerCard.dart';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

var rng = new Random();

var names = ['Steve', 'Bill', 'John', 'Ted', 'Eric', 'Tom', 'Luke', 'Peter'];

class CardResultView extends StatefulWidget {
  @override
  _CardResultViewState createState() => _CardResultViewState();
}

class _CardResultViewState extends State<CardResultView> {
  List<Widget> _card = [Text("No Results Yet")];

  Future<Null> updateCards() async {
    final jsonDB = await fetchTimes();

    List<RacerCard> _newCards = [];

    var entry = jsonDB;
    //_newCards.add(RacerCard(entry.racerID, entry.racerName, entry.runDuration, entry.startTime));

    for(var i = 0; i < jsonDB.length; i++){
      var entry = jsonDB[i];
      _newCards.add(RacerCard(entry.racerID, entry.racerName, entry.runDuration, entry.startTime));
    }

    setState(() {
      //_card = new List<RacerCard>.generate(12, (_) => RacerCard(rng.nextInt(20), names[rng.nextInt(names.length)], rng.nextInt(500)/10, '5:45'));
      _card = _newCards;
    });

    return null;
  }


  @override
  Widget build(BuildContext context) {
    //return Container(
    //  child: FutureBuilder<Time>(
    //    future: fetchTimes(),
    //    builder: (context, snapshot) {
    //      if (snapshot.hasData) {
    //        return Text(snapshot.data.racerName);
    //      } else if (snapshot.hasError) {
    //        return Text("${snapshot.error}");
    //      }
    //      // By default, show a loading spinner
    //      return CircularProgressIndicator();
    //    },
    //  )
    //);
    return Container(
      child: RefreshIndicator(
        onRefresh: updateCards,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: _card
        )
      ),
    );
  }
}