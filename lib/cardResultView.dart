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
    final jsonDB = await fetchTimes().
      timeout(
        Duration(seconds: 3),
        onTimeout: (){return [];}
      );

    //error message if request timeouts
    if (jsonDB.length == 0){
      // List<Widget> _errorMessage = [Column(
      //   mainAxisSize: MainAxisSize.min,
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: <Widget>[
      //     Text("ERROR"),
      //     Text("An error occured"),
      //     Text("ensure all connections are valid")
      //   ],
      // )];

      // for (var i = 1; i < _card.length; i++) {
      //   _errorMessage.add(_card[i]);
      // }
      List<Widget> _tempCard = [];
      _tempCard.add(RacerCard(1, "Paul", 54.0, "17:42"));
      _tempCard.add(RacerCard(2, "Liam", 51.2, "17:43"));
      _tempCard.add(RacerCard(3, "Aaron", 48, "17:43"));
      _tempCard.add(RacerCard(4, "Jacob", 55, "17:44"));      

      setState(() {
        _card = _tempCard;
      });
    }
    //if request is positive, update cards
    else{
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
    }

    var _tempCard = [];
      _tempCard.add(RacerCard(1, "Paul", 54.0, "17:42"));
      _tempCard.add(RacerCard(2, "Liam", 51.2, "17:43"));
      _tempCard.add(RacerCard(3, "Aaron", 48, "17:43"));
      _tempCard.add(RacerCard(4, "Jacob", 55, "17:44"));

      

      setState(() {
        _card = _tempCard;
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