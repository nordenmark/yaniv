import 'package:flutter/material.dart';
import 'package:yaniv/components/add-player.component.dart';

import 'package:yaniv/components/players.component.dart';
import 'package:yaniv/helpers/hex-color.dart';
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

  Widget header = Container(
      height: 200,
      child: Stack(fit: StackFit.expand, children: [
        Image(
            fit: BoxFit.cover,
            image: new AssetImage('assets/game-background.jpeg')),
        Row(children: [Text('a')]),
      ]));

  _getPlayerList() {
    return Expanded(
        child: StreamBuilder(
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
                return Container(
                    padding: EdgeInsets.all(18.0),
                    child: PlayersComponent(
                      players: game.players,
                      gameId: gameId,
                    ));
              }
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor('#f6f8fa'),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [header, _getPlayerList()]));
  }
}
