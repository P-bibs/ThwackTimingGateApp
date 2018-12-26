import 'package:flutter/material.dart';
import 'SingleRacerView.dart';

class RacerCard extends StatelessWidget {
  final racerID;
  final racerName;
  final runDuration;
  final startTime;
  final showButtons;

  RacerCard({this.racerID, this.racerName, @required this.runDuration, @required this.startTime, this.showButtons = true});

  @override
  Widget build(BuildContext context){
    return new Card(
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading:
              Icon(
                Icons.flag,
                color: runDuration == 0 ? Colors.red : Colors.green
                ),
            title: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(runDuration == 0 ? "DNF" : (runDuration.toString() + " seconds")),
            ),
            subtitle:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(racerName ?? 'No Name', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Racer ' + racerID.toString()),
                  Text('Started at ' + startTime)
                ]
              )
          ),
          ButtonTheme.bar( // make buttons use the appropriate styles for cards
            child: ButtonBar(
              children: <Widget>[
                Offstage(
                  offstage: !showButtons,
                  child: FlatButton(
                    child: const Text('VIEW RACER\'S TIMES'),
                    onPressed: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => SingleRacerView(racerID: racerID, racerName: racerName,))
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}