import 'package:flutter/material.dart';

class RacerCard extends StatelessWidget {
  final racerID;
  final racerName;
  final runDuration;
  final startTime;

  RacerCard(this.racerID, this.racerName, this.runDuration, this.startTime);

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
              padding: const EdgeInsets.all(4.0),
              child: Text(runDuration == 0 ? "DNF" : (runDuration.toString() + " seconds")),
            ),
            subtitle:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Racer ' + racerID.toString() + ' (' + (racerName ?? 'No Name') + ')'),
                  Text('Started at ' + startTime)
                ]
              )
          ),
          new ButtonTheme.bar( // make buttons use the appropriate styles for cards
            child: new ButtonBar(
              children: <Widget>[
                new FlatButton(
                  child: const Text('VIEW RACER'),
                  onPressed: () { /* ... */ },
                ),
                new FlatButton(
                  child: const Text('N/A'),
                  onPressed: () { /* ... */ },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}