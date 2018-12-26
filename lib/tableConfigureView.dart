import 'dart:async';
import 'requester.dart';
import 'racerCard.dart';
import 'dart:math';
import 'globals.dart' as globals;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TableConfigureView extends StatefulWidget {
  @override
  _TableConfigureViewState createState() => _TableConfigureViewState();
}

class _TableConfigureViewState extends State<TableConfigureView> {

  List _table = globals.idToNameTable;

  Future<void> _addEntry() async {
    var _idController = TextEditingController();
    var _nameController = TextEditingController();
    return showDialog<void>(
      context: context,
      barrierDismissible: true, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Assign ID to Racer'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            //shrinkWrap: true,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _idController,
                  decoration: InputDecoration(
                    labelText: 'Enter Racer ID'
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Enter Racer Name'
                  ),
                ),
              ),
            ]
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Enter'),
              onPressed: () {
                setState(() {
                  _table.add([_idController.text, _nameController.text]);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Add/Delete Table Entries"),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.check),
          onPressed: (){globals.idToNameTable = _table;Navigator.pop(context);},
        ),
        
        actions: <Widget>[
          //sort alphabetical by name
          IconButton(
            icon: Icon(Icons.sort_by_alpha),
            tooltip: "Sort By Name",
            onPressed: (){
              setState(() {
                _table.sort((a,b) => a[1].compareTo(b[1]));
              });
            },
          ),
          //sort by id number
          IconButton(
            icon: Icon(Icons.format_list_numbered),
            tooltip: "Sort By ID",
            onPressed: (){
              setState(() {
                _table.sort((a,b) => a[0].compareTo(b[0]));
              });
            }
          ),
        ],
      ),
      //add new entry
      floatingActionButton:
        FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: _addEntry,
        ),
      body: ListView.builder(
        itemCount: _table.length,
        itemBuilder: (context, index) {
          final item = _table[index];

          return Dismissible(
            // Each Dismissible must contain a Key. Keys allow Flutter to
            // uniquely identify Widgets.
            key: Key(item[0]),
            // We also need to provide a function that tells our app
            // what to do after an item has been swiped away.
            onDismissed: (direction) {
              // Remove the item from our data source
              setState(() {
                _table.removeAt(index);
              });

              // Then show a snackbar!
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text("Deleted")));
            },
            // Show a red background as the item is swiped away
            background: Container(color: Colors.red),
            child: ListTile(title: Text("Racer ID " + item[0] + " -> " + item[1]), subtitle: Text("Swipe to Delete"),),
          );
        },
      ),
    );
  }
}