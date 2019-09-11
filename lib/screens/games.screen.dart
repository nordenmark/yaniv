import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:yaniv/components/games.component.dart';
import 'package:yaniv/models/game.model.dart';
import 'package:yaniv/models/player.model.dart';
import 'package:yaniv/services/firebase.service.dart';

class GamesScreen extends StatelessWidget {
  final FirebaseService firebaseService = FirebaseService();
  final GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of all games'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            tooltip: 'Logout',
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              await googleSignIn.signOut();
              Navigator.pushNamed(context, '/');
            },
          ),
        ],
      ),
      body: new StreamBuilder(
          stream: firebaseService.getGames(),
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

            if (games.length > 0) {
              return new GamesComponent(games: games);
            } else {
              return Center(
                child: Text("No games added, go ahead and add one!"),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String id = await firebaseService.createNewGame();
          debugPrint("Created game ${id}");
        },
        tooltip: 'Create new game',
        child: Icon(Icons.add),
      ),
    );
  }
}
