import 'dart:async';
import 'requester.dart';
import 'racerCard.dart';
import 'settingsView.dart';
import 'globals.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:math';

class SingleRacerView extends StatefulWidget {
  int racerID;
  String racerName;

  SingleRacerView({Key key, @required this.racerID, this.racerName}): super(key: key);

  @override
  _SingleRacerViewState createState() => _SingleRacerViewState();
}

class _SingleRacerViewState extends State<SingleRacerView> with SingleTickerProviderStateMixin{
  List _racerCards;
  static const List<IconData> icons = const [ Icons.access_time, Icons.timer ];

  AnimationController _controller;

  @override
  initState(){
    super.initState();
    _racerCards = gCards.where((a) => a[0] == widget.racerID).toList();
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  void _sortCards(List cards){
    if(gSortType == 3){ //reverse list if sorting by finish time
      setState(() {
        cards.sort((a,b) => b[gSortType].compareTo(a[gSortType]));
      });
    }
    else if(gSortType == 2){
      List dnfs = [];
      for (var i = 0; i < cards.length; i++) {
        if (cards[i][2] == 0) {
          dnfs.add(cards[i]);
          cards.removeAt(i);
        }
      }
      cards.sort((a,b) => a[gSortType].compareTo(b[gSortType]));
      setState(() {
        cards.addAll(dnfs);
      });
    }
    else{
      setState(() {
        cards.sort((a,b) => a[gSortType].compareTo(b[gSortType]));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).cardColor;
    Color foregroundColor = Theme.of(context).accentColor;

    return Scaffold(
      appBar: AppBar(
        title: Text((widget.racerName ?? "Racer " + widget.racerID.toString()) + "'s results")
      ),
      body: Container(
        child: ListView.builder(
          itemCount: _racerCards.length,
          itemBuilder: (context, index) {
            List thisCard = _racerCards[index];
            return RacerCard(racerID: thisCard[0], racerName: thisCard[1], runDuration: thisCard[2], startTime: thisCard[3], showButtons: false,);
          },

        )
        
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: new List.generate(icons.length, (int index) {
          Widget child = new Container(
            height: 70.0,
            width: 56.0,
            alignment: FractionalOffset.topCenter,
            child: new ScaleTransition(
              scale: new CurvedAnimation(
                parent: _controller,
                curve: new Interval(
                  0.0,
                  1.0 - index / icons.length / 2.0,
                  curve: Curves.easeOut
                ),
              ),
              child: new FloatingActionButton(
                heroTag: null,
                backgroundColor: backgroundColor,
                mini: true,
                child: new Icon(icons[index], color: foregroundColor),
                onPressed: (){
                  gSortType = ((index == 0 ? 1 : index == 1 ? 3 : index == 2 ? 2 : -1));
                  _sortCards(_racerCards);
                  _controller.reverse();
                },
              ),
            ),
          );
          return child;
        }).toList()..add(
          new FloatingActionButton(
            heroTag: null,
            child: new AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, Widget child) {
                return new Transform(
                  transform: new Matrix4.rotationZ(_controller.value * 0.5 * 3.14159),
                  alignment: FractionalOffset.center,
                  child: AnimatedCrossFade(
                    alignment: Alignment.center,
                    duration: const Duration(milliseconds: 300),
                    firstChild: Icon(Icons.sort),
                    secondChild: Icon(Icons.close),
                    crossFadeState: _controller.isDismissed ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                  )
                );
              },
            ),
            onPressed: () {
              if (_controller.isDismissed) {
                _controller.forward();
              } else {
                _controller.reverse();
              }
            },
          ),
        )
      )
    );
  }
}