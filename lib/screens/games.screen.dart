import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:yaniv/components/games.component.dart';
import 'package:yaniv/components/pill-button.component.dart';
import 'package:yaniv/models/game.model.dart';
import 'package:yaniv/models/player.model.dart';
import 'package:yaniv/services/firebase.service.dart';

TextStyle header = new TextStyle(
    fontSize: 18, fontWeight: FontWeight.normal, color: Colors.black);

class GamesScreen extends StatelessWidget {
  final FirebaseService firebaseService = FirebaseService();
  final GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
            child: Padding(
                padding: const EdgeInsets.only(top: 80, bottom: 32),
                child: Image(image: AssetImage('assets/logo-blue.png')))),
        Padding(
            padding: EdgeInsets.all(32),
            child: Text('Previous games', style: header)),
        Expanded(
            child: StreamBuilder(
                stream: firebaseService.getGames(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return new Center(child: CircularProgressIndicator());
                  }
                  List<DocumentSnapshot> data = snapshot.data.documents;
                  List<Game> games = data.map((game) {
                    List<dynamic> players = game['players'];
                    return new Game(
                      completed: game['completed'],
                      name: game['name'],
                      id: game.documentID,
                      createdAt: game['createdAt'],
                      players: players
                          .map((player) => new Player.fromJSON(new Map.from({
                                "name": player["name"],
                                "points": player["points"]
                              })))
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
                })),
        Center(
            child: Padding(
          padding: EdgeInsets.only(top: 32, bottom: 32),
          child: Container(
            width: 300,
            height: 50,
            child: PillButton(
              onPressed: () {
                Navigator.pushNamed(context, '/new-game');
              },
              child: Text(
                'NEW GAME',
                style: TextStyle(color: Colors.white),
              ),
              gradient: LinearGradient(colors: [Colors.purple, Colors.blue]),
            ),
          ),
        ))
      ],
    ));
  }
}
