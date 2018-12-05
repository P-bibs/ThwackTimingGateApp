import 'dart:async';
import 'requester.dart';
import 'racerCard.dart';
import 'settingsView.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Thwack Timing',
      theme: new ThemeData(
        primaryColor: Colors.blueGrey[700],
        primaryColorDark: Color(0xFF455A64),
        primaryColorLight: Color(0xFFCFD8DC),
        accentColor: Colors.blue,
      ),
      home: new MyHomePage(title: 'Thwack Timing Gate'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin{
  AnimationController _controller;

  static const List<IconData> icons = const [ Icons.sort_by_alpha, Icons.format_list_numbered, Icons.timer ];

  @override
  void initState() {
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  int _counter = 0;
  int _currentIndex = 0;


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
    Color backgroundColor = Theme.of(context).cardColor;
    Color foregroundColor = Theme.of(context).accentColor;
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: (){
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => SettingsView())
              );

            },
          )
        ],
      ),
      floatingActionButton: new Column(
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
                onPressed: _controller.reverse,
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
                  //child: new Icon(_controller.isDismissed ? Icons.sort : Icons.close),
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
        ),
      ),

      body: Container(
        child: RefreshIndicator(
          onRefresh: updateCards,
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: _card
          )
        ),
      )
    );
  }
}