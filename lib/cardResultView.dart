import 'dart:async';
import 'requester.dart';
import 'racerCard.dart';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

var rng = new Random();

class CardResultView extends StatefulWidget {
  @override
  _CardResultViewState createState() => _CardResultViewState();
}

class _CardResultViewState extends State<CardResultView> {
  List<Widget> _card = [Text("No Results Yet")];

  Future<Null> updateCards() async {
    final jsonDB = await fetchTimes();

    List<Widget> _newCards = [];

    _newCards.add(Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text("Results: ", ),
    ));

    for(var i = jsonDB.length-1; i >= 0; i--){
      var entry = jsonDB[i];
      _newCards.add(RacerCard(entry.racerID, entry.racerName, entry.runDuration, entry.startTime));
    }

    setState(() {
      _card = _newCards;
    });

    return null;
  }


  @override
  Widget build(BuildContext context) {
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