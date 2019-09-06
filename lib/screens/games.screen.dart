import 'package:flutter/material.dart';
import 'dart:developer' as developer;

import 'package:yaniv/models/game.model.dart';
import 'package:yaniv/components/games.component.dart';

class GamesScreen extends StatelessWidget {
  final List<Game> games = [];

  _createNewGame() {
    developer.log('Create new game');
  }

  GamesScreen() {
    for (var i = 0; i < 20; i++) {
      this.games.add(Game.randomize());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of all games'),
      ),
      body: GamesComponent(games: this.games),
      floatingActionButton: FloatingActionButton(
        onPressed: _createNewGame,
        tooltip: 'Create new game',
        child: Icon(Icons.add),
      ),
    );
  }
}
