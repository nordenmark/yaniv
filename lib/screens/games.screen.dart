import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yaniv/components/games.component.dart';
import 'package:yaniv/models/game.model.dart';
import 'package:yaniv/models/player.model.dart';

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
            List<DocumentSnapshot> data = snapshot.data.documents;
            List<Game> games = data.map((game) {
              List<dynamic> players = game['players'];
              return new Game(
                completed: game['completed'],
                id: game.documentID,
                createdAt: game['createdAt'],
                players: players
                    .map((player) => new Player.fromJSON(new Map.from(
                        {"name": player["name"], "points": player["points"]})))
                    .toList(),
              );
            }).toList();
            return new GamesComponent(games: games);
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        tooltip: 'Create new game',
        child: Icon(Icons.add),
      ),
    );
  }
}
