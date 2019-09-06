import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// import 'package:yaniv/models/game.model.dart';

class GamesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of all games'),
      ),
      body: new StreamBuilder(
          stream: Firestore.instance
              .collection('games')
              .document('nordenmark@gmail.com')
              .collection('games')
              .getDocuments()
              .asStream(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return new Center(child: new CircularProgressIndicator());
            }
            Map<dynamic, dynamic> data = snapshot.data.documents.first.data;
            debugPrint(data.toString());
            return new Center(child: new Text("DATA LOADED"));
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        tooltip: 'Create new game',
        child: Icon(Icons.add),
      ),
    );
  }
}
