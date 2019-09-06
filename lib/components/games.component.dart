import 'package:flutter/material.dart';

import 'package:yaniv/models/game.model.dart';
import 'package:yaniv/models/player.model.dart';
import 'package:yaniv/screens/game.screen.dart';

class GamesComponent extends StatelessWidget {
  GamesComponent({this.games});

  final List<Game> games;

  String _playersToList(List<Player> players) {
    return players.map((Player player) {
      return player.name;
    }).join(', ');
  }

  void _handleTappedGame(BuildContext context, Game game) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GameScreen(game: game),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8.0),
      itemCount: games.length,
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemBuilder: (BuildContext context, int index) {
        Game game = games[index];

        return Container(
          child: ListTile(
            leading: game.completed
                ? Icon(
                    Icons.check,
                    color: Colors.green,
                  )
                : new Text(''),
            title: Text(_playersToList(game.players)),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () => _handleTappedGame(context, game),
          ),
        );
      },
    );
  }
}
