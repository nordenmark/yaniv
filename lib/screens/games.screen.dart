import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:yaniv/models/game.model.dart';

class GamesScreen extends StatelessWidget {

  test() {
    Firestore.instance.collection('games').document().setData({'bla': 'test', 'bla2': 1});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of all games'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: test,
        tooltip: 'Create new game',
        child: Icon(Icons.add),
      ),
    );
  }
}
