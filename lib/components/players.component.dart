import 'package:flutter/material.dart';
import 'package:yaniv/models/player.model.dart';
import 'package:yaniv/services/firebase.service.dart';

// class PlayersComponent extends StatefulWidget {
//   final String gameId;
//   final List<Player> players;

//   PlayersComponent({this.players, this.gameId});

//   @override
//   PlayersComponentState createState() =>
//       new PlayersComponentState(gameId: gameId, players: players);
// }

class PlayersComponent extends StatelessWidget {
  PlayersComponent({this.gameId, this.players});

  final FirebaseService firebaseService = FirebaseService();
  final List<Player> players;
  final String gameId;

  void _handleTappedPlayer(Player player, BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) => Container(
                child: Padding(
              padding: EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: new TextFormField(
                autofocus: true,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'How many points?',
                  labelText: 'Points',
                ),
                onFieldSubmitted: (String points) {
                  firebaseService.addPointsToPlayer(
                      gameId, player.name, int.parse(points));
                  Navigator.of(context).pop();
                },
              ),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8.0),
      itemCount: players.length,
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemBuilder: (BuildContext context, int index) {
        Player player = players[index];

        return Container(
          child: ListTile(
            leading: Text(
              player.points.toString(),
              style: TextStyle(fontSize: 18.0),
            ),
            title: Text(player.name),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () => _handleTappedPlayer(player, context),
          ),
        );
      },
    );
  }
}
