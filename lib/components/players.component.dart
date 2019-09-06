import 'package:flutter/material.dart';

import 'package:yaniv/models/player.model.dart';

class PlayersComponent extends StatelessWidget {
  PlayersComponent({this.players});

  final List<Player> players;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8.0),
      itemCount: players.length,
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemBuilder: (BuildContext context, int index) {
        Player player = players[index];

        return Container(
          height: 50,
          child: ListTile(
              title: Text(player.name),
              trailing: Text(player.score.toString())),
        );
      },
    );
  }
}
