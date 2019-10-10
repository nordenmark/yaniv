import 'package:flutter/material.dart';
import 'package:yaniv/components/add-player.component.dart';

import 'package:yaniv/components/players.component.dart';
import 'package:yaniv/models/game.model.dart';
import 'package:yaniv/services/firebase.service.dart';

class GameScreen extends StatelessWidget {
  final FirebaseService firebaseService = FirebaseService();
  final String gameId;

  GameScreen({this.gameId});

  _showDeleteConfirmation(BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text(
                'Your game will be deleted forever, and forever ever.'),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text("Delete"),
                textColor: Colors.red,
                onPressed: () async {
                  await firebaseService.deleteGame(gameId);
                  Navigator.pushNamed(context, '/games');
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Game scores"),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => _showDeleteConfirmation(context),
          )
        ],
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
              return PlayersComponent(
                players: game.players,
                gameId: gameId,
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) => new AddPlayer(gameId: this.gameId));
        },
        tooltip: 'Add player',
        child: Icon(Icons.add),
      ),
    );
  }
}
