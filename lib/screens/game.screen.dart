import 'package:flutter/material.dart';

import 'package:yaniv/components/players.component.dart';
import 'package:yaniv/models/game.model.dart';
import 'package:yaniv/models/player.model.dart';

class GameScreen extends StatelessWidget {
  GameScreen({this.game});

  final Game game;

  void _sortPlayersByScore(List<Player> players) {
    players.sort((Player p1, Player p2) => p2.points - p1.points);
  }

  @override
  Widget build(BuildContext context) {
    _sortPlayersByScore(this.game.players);

    return Scaffold(
      appBar: AppBar(
        title: Text("Game scores"),
      ),
      body: PlayersComponent(players: this.game.players),
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
