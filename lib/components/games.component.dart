import 'package:flutter/material.dart';

import 'package:yaniv/models/game.model.dart';
import 'package:yaniv/models/player.model.dart';
import 'package:yaniv/screens/game.screen.dart';

class GamesComponent extends StatelessWidget {
  GamesComponent({this.games});

  final List<Game> games;

  Text _playersToListTitle(List<Player> players) {
    if (players.length == 0) {
      return Text('No players added...',
          style: TextStyle(fontStyle: FontStyle.italic));
    }

    String title = players.map((Player player) {
      return player.name;
    }).join(', ');

    return Text(title);
  }

  void _handleTappedGame(BuildContext context, Game game) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GameScreen(gameId: game.id),
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
            title: _playersToListTitle(game.players),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () => _handleTappedGame(context, game),
          ),
        );
      },
    );
  }
}
