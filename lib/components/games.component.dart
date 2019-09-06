import 'package:flutter/material.dart';

import 'package:yaniv/models/game.model.dart';
import 'package:yaniv/models/player.model.dart';

class GamesComponent extends StatelessWidget {
  GamesComponent({this.games});

  final List<Game> games;

  String _playersToList(List<Player> players) {
    return players.map((Player player) {
      return player.name;
    }).join(', ');
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
            height: 50,
            child: Row(
              children: <Widget>[
                Text(game.createdAt.toString()),
                Expanded(child: Text(_playersToList(game.players)))
              ],
            ));
      },
    );
  }
}
