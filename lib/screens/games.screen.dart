import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:yaniv/components/games.component.dart';
import 'package:yaniv/components/pill-button.component.dart';
import 'package:yaniv/models/game.model.dart';
import 'package:yaniv/models/player.model.dart';
import 'package:yaniv/services/firebase.service.dart';

TextStyle header = new TextStyle(
    fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black);

class GamesScreen extends StatelessWidget {
  final FirebaseService firebaseService = FirebaseService();
  final GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return new Scaffold (
        body: new Stack(fit: StackFit.expand, children: [
        new Image(
            fit: BoxFit.cover,
            image: new AssetImage('assets/main-background.png')),
            new Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        new Container(
            child: new Padding(
                padding: const EdgeInsets.only(top: 60, bottom: 0, left: 30),
                child:
                    new Image(image: new AssetImage('assets/logo-blue.png')))),
        new Padding(
            padding: EdgeInsets.only(top: 30, bottom: 15, left: 30, right: 30),
            child: Text('Previous games', 
                style: new TextStyle(
    fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
            )
        ),
        new Expanded(
            child: new StreamBuilder(
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
        new Center(
            child: new Container(
                decoration: const BoxDecoration(
                    color: const Color(0xFFFFFFFF),
                    border: Border(
                        top: BorderSide(width: 1.0, color: Color(0xFFE9EAEB)),
                    ),
                ),
                padding: EdgeInsets.only(top: 30, bottom: 30, left: 30, right: 30),
                child: new Container(
                    height: 50,
                    child: new PillButton(
                    onPressed: () async {
                        await firebaseService.createNewGame();
                    },
                    child: new Text(
                        'NEW GAME',
                        style: new TextStyle(color: Colors.white, letterSpacing: 1.3, fontWeight: FontWeight.w500, fontSize: 14),
                    ),
                    gradient:
                        new LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [const Color(0xFF5A7BEF), const Color(0xFF4048EF)]),
                    ),
                ),
            )
        )
      ],
    )]));
  }
}
