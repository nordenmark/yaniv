import 'package:flutter/material.dart';
import 'dart:developer' as developer;

import 'package:yaniv/models/game.model.dart';

class GamesScreen extends StatelessWidget {
  final List<Game> games = [];

  GamesScreen() {
    for (var i = 0; i < 10; i++) {
      games.add(Game.randomize());
      developer
          .log("Added: id: ${games[i].id} players: ${games[i].players.length}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of all games'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          developer.log('Create new game');
        },
        tooltip: 'Create new game',
        child: Icon(Icons.add),
      ),
    );
  }
}
