import 'dart:async';
import 'requester.dart';
import 'racerCard.dart';
import 'cardResultView.dart';
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

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _currentIndex = 0;

  void onTabTapped(int index){
      setState((){
        _currentIndex = index;
      });
    }

  @override
  Widget build(BuildContext context) {
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
      ),
      body: AnimatedCrossFade(
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 200),
        firstChild: CardResultView(),
        secondChild: SettingsView(),
        crossFadeState: _currentIndex == 0 ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      ),
      bottomNavigationBar: new BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Colors.deepOrange,
            icon: Icon(Icons.flag),
            title: Text("Results")
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.lightBlue,
            icon: Icon(Icons.settings),
            title: Text("Settings")
          ),
        ]
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}