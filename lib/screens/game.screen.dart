import 'package:flutter/material.dart';

import 'package:yaniv/components/players.component.dart';
import 'package:yaniv/models/game.model.dart';
import 'package:yaniv/models/player.model.dart';
import 'package:yaniv/services/firebase.service.dart';

class GameScreen extends StatelessWidget {
  final FirebaseService firebaseService = FirebaseService();
  final String gameId;

  GameScreen({this.gameId});

  void _sortPlayersByScore(List<Player> players) {
    players.sort((Player p1, Player p2) => p2.points - p1.points);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Game scores"),
      ),
      body: StreamBuilder(
          stream: firebaseService.getGame(this.gameId),
          builder: (BuildContext context, AsyncSnapshot<Game> snapshot) {
            if (!snapshot.hasData) {
              return new Center(child: new CircularProgressIndicator());
            }

            Game game = snapshot.data;

            if (game.players.length == 0) {
              return Center(
                  child: Text('No players added, go ahead and add some!'));
            } else {
              return PlayersComponent(players: game.players);
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('Add player');
        },
        tooltip: 'Add player',
        child: Icon(Icons.add),
      ),
    );
  }
}
